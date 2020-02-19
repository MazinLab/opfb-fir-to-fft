#include "toplevel.hpp"
#ifndef __SYNTHESIS__
#include <iostream>
using namespace std;
#endif


void sort_input_lanes(pfbaxisin_t input[N_LANES][N_CHAN_PLANE*2],
				hls::stream<iqstruct_t> A[N_LANES], hls::stream<iqstruct_t> B[N_LANES], hls::stream<iqstruct_t> C[N_LANES]) {
	sort_chan: for (ap_uint<10> cycle=0; cycle<N_CHAN_PLANE*2;cycle++) {
#pragma HLS INTERFACE ap_ctrl_none port=return
#pragma HLS pipeline rewind
		for (unsigned short lane=0; lane<N_LANES; lane++) {
#pragma HLS UNROLL
			iq_t iq=input[lane][cycle].data;
			iqstruct_t in;
//			in.i=iq.real();
//			in.q=iq.imag();
			//In the agregate design this nested if places a high-fanout WE to the memories that back these FIFOs
			// an alternate approach would be to write to the mem every time and only alter the address
			//bool odd_cycle = ap_uint<1>(cycle);
			if (cycle[0]) {
				if (cycle < N_CHAN_PLANE) {
					B[lane].write(in);
				} else {
					C[lane].write(in);
				}
			} else {
				A[lane].write(in);
			}
		}
	}
}

void play_output_lanes(hls::stream<iqstruct_t> A[N_LANES], hls::stream<iqstruct_t> B[N_LANES], hls::stream<iqstruct_t> C[N_LANES],
				 pfbaxisin_t output[N_LANES][N_CHAN_PLANE*2]) {
//#pragma HLS INTERFACE ap_ctrl_none port=return
	iqstruct_t temp;
	play_chan: for (int cycle=0; cycle<2*N_CHAN_PLANE; cycle++) {
#pragma HLS pipeline rewind
		for (unsigned short lane=0; lane<N_LANES; lane++) {
#pragma HLS UNROLL
			#ifndef __SYNTHESIS__
			cout<<"Cycle "<<cycle<<": Read ";
			#endif
			if (cycle < N_CHAN_PLANE) {
				A[lane].read(temp);
				#ifndef __SYNTHESIS__
				cout<<(temp.to_uint()&0xffff)<<" from A";
				#endif
			} else if (cycle-N_CHAN_PLANE >= N_CHAN_PLANE/2) {
				B[lane].read(temp);
				#ifndef __SYNTHESIS__
				cout<<(temp.to_uint()&0xffff)<<" from B";
				#endif
			} else {
				C[lane].read(temp);
				#ifndef __SYNTHESIS__
				cout<<(temp.to_uint()&0xffff)<<" from C";
				#endif
			}
			#ifndef __SYNTHESIS__
			cout<<" Sizes: "<<A[lane].size()<<", "<<B[lane].size()<<", "<<C[lane].size()<<"\n";
			#endif
			output[lane][cycle].data=iq_t(temp); //do we need the iq_t()?
			output[lane][cycle].last=cycle==255 || cycle==511;
		}
	}
}


void fir_to_fftx16(pfbaxisin_t input[N_LANES][N_CHAN_PLANE*2], pfbaxisin_t output[N_LANES][N_CHAN_PLANE*2]) {
//This takes a single PFB lane stream, consisting of 2 sets (one is delayed) of 256 TDM channels,
// and reorders them, correctly applying the required circular shift.
// e.g. 1 1z 2 2z 3 3z ... 256 256z becomes 1...256 129z...256z 1z...128z.
// This is achieved by placing the even samples into a single 256 deep fifo (A) and the
// odd samples into 2 128 deep FIFOs, one for the first 128 (B) and one for the second (C). The FIFOs
// are replayed in order A C B A C B ... Due to the flip of the B and C replay order B needs to be 256 deep
// to prevent overwrite. NB/TODO: There is probably a way to optimize the B waste.
#pragma HLS DATAFLOW
#pragma HLS ARRAY_PARTITION variable=input dim=1
#pragma HLS ARRAY_PARTITION variable=output dim=1
#pragma HLS DATA_PACK variable=input
#pragma HLS DATA_PACK variable=output
#pragma HLS INTERFACE axis port=input depth=512 register=reverse
#pragma HLS INTERFACE axis port=output depth=512 register=forward
#pragma HLS INTERFACE ap_ctrl_none port=return


	hls::stream<iqstruct_t> A[N_LANES], B[N_LANES], C[N_LANES];
#pragma HLS STREAM depth=256 variable=A
#pragma HLS STREAM depth=256 variable=B
#pragma HLS STREAM depth=128 variable=C
#pragma HLS RESOURCE variable=A core=FIFO_LUTRAM
#pragma HLS RESOURCE variable=B core=FIFO_LUTRAM
#pragma HLS RESOURCE variable=C core=FIFO_LUTRAM //FIFO_LUTRAM FIFO_BRAM FIFO_SRL
//#pragma HLS DATA_PACK variable=A
//#pragma HLS DATA_PACK variable=B
//#pragma HLS DATA_PACK variable=C
	sort_input_lanes(input, A, B, C);
	play_output_lanes(A,B,C, output);

}


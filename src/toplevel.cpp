#include "toplevel.hpp"
#ifndef __SYNTHESIS__
#include <iostream>
using namespace std;
#endif


void sort_input_lanes(pfbaxisin_t input[N_LANES][N_CHAN_PLANE*2],
				hls::stream<iq_t> A[N_LANES], hls::stream<iq_t> B[N_LANES], hls::stream<iq_t> C[N_LANES]) {
//#pragma HLS INTERFACE ap_ctrl_none port=return
	bool mismatch[N_LANES];
#pragma HLS ARRAY_PARTITION variable=mismatch complete

	sort_chan: for (ap_uint<10> cycle=0; cycle<N_CHAN_PLANE*2;cycle++) {
#pragma HLS PIPELINE REWIND
		for (unsigned short lane=0; lane<N_LANES; lane++) {
#pragma HLS UNROLL
			pfbaxisin_t in=input[lane][cycle];
			iq_t iq=in.data;
			mismatch[lane]|=in.last && cycle!=511;
			//In the aggregate design this nested if places a high-fanout WE to the memories that back these FIFOs
			// an alternate approach would be to write to the mem every time and only alter the address
			//bool odd_cycle = ap_uint<1>(cycle);
			if (cycle[0]) {
				if (cycle < N_CHAN_PLANE) {
					B[lane].write(iq);
				} else {
					C[lane].write(iq);
				}
			} else {
				A[lane].write(iq);
			}
		}
	}
}

void play_output_lanes(hls::stream<iq_t> A[N_LANES], hls::stream<iq_t> B[N_LANES], hls::stream<iq_t> C[N_LANES],
				 pfbaxisout_t output[N_CHAN_PLANE*2]) {
//#pragma HLS INTERFACE ap_ctrl_none port=return
	iq_t temp;

#ifndef __SYNTHESIS__
	int sizes[3]={0,0,0};
	bool sizegrow=false;
#endif

	play_chan: for (int cycle=0; cycle<2*N_CHAN_PLANE; cycle++) {
#pragma HLS pipeline rewind
		for (unsigned short lane=0; lane<N_LANES; lane++) {
#pragma HLS UNROLL
			#ifndef __SYNTHESIS__
			//cout<<"Cycle "<<cycle<<": Read ";
			#endif
			if (cycle < N_CHAN_PLANE) {
				A[lane].read(temp);
			} else if (cycle >= 3*N_CHAN_PLANE/2) {
				B[lane].read(temp);
			} else {
				C[lane].read(temp);
			}
			#ifndef __SYNTHESIS__
				sizegrow = (A[lane].size()>sizes[0] || B[lane].size()>sizes[1] || B[lane].size()>sizes[2]);
				sizes[0]=A[lane].size()>sizes[0]? A[lane].size():sizes[0];
				sizes[1]=B[lane].size()>sizes[1]? B[lane].size():sizes[1];
				sizes[2]=C[lane].size()>sizes[2]? C[lane].size():sizes[2];
				if (sizegrow)
					cout<<" Max Sizes: "<<sizes[0]<<", "<<sizes[1]<<", "<<sizes[2]<<"\n";
			#endif
			output[cycle].data[lane]=temp;
			output[cycle].last=cycle==255 || cycle==511;
		}
	}
}


void fir_to_fft(pfbaxisin_t input[N_LANES][N_CHAN_PLANE*2], pfbaxisout_t output[N_CHAN_PLANE*2]) {
//This takes a single PFB lane stream, consisting of 2 sets (one is delayed) of 256 TDM channels,
// and reorders them, correctly applying the required circular shift.
// e.g. 1 1z 2 2z 3 3z ... 256 256z becomes 1...256 129z...256z 1z...128z.
// This is achieved by placing the even samples into a single 256 deep fifo (A) and the
// odd samples into 2 128 deep FIFOs, one for the first 128 (B) and one for the second (C). The FIFOs
// are replayed in order A C B A C B ... Due to the flip of the B and C replay order B needs to be 256 deep
// to prevent overwrite.
#pragma HLS DATAFLOW
#pragma HLS DATA_PACK variable=output
#pragma HLS ARRAY_PARTITION variable=input dim=1
//#pragma HLS ARRAY_PARTITION variable=output dim=1
#pragma HLS INTERFACE axis port=input register reverse
#pragma HLS INTERFACE axis port=output register forward
#pragma HLS INTERFACE ap_ctrl_none port=return


	hls::stream<iq_t> A[N_LANES], B[N_LANES], C[N_LANES];
#pragma HLS STREAM depth=256 variable=A
#pragma HLS STREAM depth=256 variable=B
#pragma HLS STREAM depth=128 variable=C
//#pragma HLS RESOURCE variable=A core=FIFO_LUTRAM
//#pragma HLS RESOURCE variable=B core=FIFO_LUTRAM
//#pragma HLS RESOURCE variable=C core=FIFO_LUTRAM //FIFO_LUTRAM FIFO_BRAM FIFO_SRL
	sort_input_lanes(input, A, B, C);
	play_output_lanes(A,B,C, output);

}

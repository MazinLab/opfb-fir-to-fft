#include "toplevel.hpp"
#ifndef __SYNTHESIS__
#include <iostream>
using namespace std;
#endif




void sort_input(pfbaxisin_t input[N_CHAN_PLANE*2],
				hls::stream<iqstruct_t> &A, hls::stream<iqstruct_t> &B, hls::stream<iqstruct_t> &C) {
	for (int cycle=0; cycle<N_CHAN_PLANE*2;cycle++) {
#pragma HLS pipeline rewind
		iq_t iq=input[cycle].data;
		iqstruct_t in;
		in.i=iq.real();
		in.q=iq.imag();
		bool odd_cycle = ap_uint<1>(cycle);
		if (odd_cycle) {
			if (cycle < N_CHAN_PLANE) {
				B.write(in);
			} else {
				C.write(in);
			}
		} else {
			A.write(in);
		}
	}
}

void play_output(hls::stream<iqstruct_t> &A, hls::stream<iqstruct_t> &B, hls::stream<iqstruct_t> &C,
				 pfbaxisin_t output[N_CHAN_PLANE*2]) {
	iqstruct_t temp;
	for (int cycle=0; cycle<2*N_CHAN_PLANE; cycle++) {
#pragma HLS pipeline rewind enable_flush

		#ifndef __SYNTHESIS__
		cout<<"Cycle "<<cycle<<": Read ";
		#endif
		if (cycle < N_CHAN_PLANE) {
			A.read(temp);
			#ifndef __SYNTHESIS__
			cout<<temp.i<<" from A";
			#endif
		} else if (cycle-N_CHAN_PLANE >= N_CHAN_PLANE/2) {
			B.read(temp);
			#ifndef __SYNTHESIS__
			cout<<temp.i<<" from B";
			#endif
		} else {
			C.read(temp);
			#ifndef __SYNTHESIS__
			cout<<temp.i<<" from C";
			#endif
		}
		#ifndef __SYNTHESIS__
		cout<<" Sizes: "<<A.size()<<", "<<B.size()<<", "<<C.size()<<"\n";
		#endif
		output[cycle].data=iq_t(temp.i, temp.q);
	}
}

void top(pfbaxisin_t input[N_CHAN_PLANE*2], pfbaxisin_t output[N_CHAN_PLANE*2]) {
//This takes a single PFB lane stream, consisting of 2 sets (one is delayed) of 256 TDM channels,
// and reorders them, correctly applying the required circular shift.
// e.g. 1 1z 2 2z 3 3z ... 256 256z becomes 1...256 129z...256z 1z...128z.
// This is achieved by placing the even samples into a single 256 deep fifo (A) and the
// odd samples into 2 128 deep FIFOs, one for the first 128 (B) and one for the second (C). The FIFOs
// are replayed in order A C B A C B ... Due to the flip of the B and C replay order B needs to be 256 deep
// to prevent overwrite. NB/TODO: There is probably a way to optimize the B waste.
#pragma HLS DATAFLOW
#pragma HLS DATA_PACK variable=input
#pragma HLS DATA_PACK variable=output
#pragma HLS INTERFACE axis port=input depth=2048 register=reverse
#pragma HLS INTERFACE axis port=output depth=2048 register=forward
#pragma HLS INTERFACE s_axilite depth=2048 port=return

	hls::stream<iqstruct_t> A("A"), B("B"), C("C");
#pragma HLS STREAM depth=256 variable=A
#pragma HLS STREAM depth=256 variable=B
#pragma HLS STREAM depth=128 variable=C
#pragma HLS RESOURCE variable=A core=FIFO_LUTRAM
#pragma HLS RESOURCE variable=B core=FIFO_LUTRAM
#pragma HLS RESOURCE variable=C core=FIFO_LUTRAM //FIFO_LUTRAM FIFO_BRAM FIFO_SRL
//#pragma HLS DATA_PACK variable=A
//#pragma HLS DATA_PACK variable=B
//#pragma HLS DATA_PACK variable=C
	sort_input(input, A, B, C);
	play_output(A,B,C, output);

}

#include "toplevel.hpp"

#ifndef __SYNTHESIS__
#include <iostream>
using namespace std;
#endif


void fir_to_fft(pfbaxisin_t input[N_LANES], pfbaxisout_t &output) {
//This takes a single PFB lane stream, consisting of 2 sets (one is delayed) of 256 TDM channels,
// and reorders them, correctly applying the required circular shift.
// e.g. 1 1z 2 2z 3 3z ... 256 256z becomes 1...256 129z...256z 1z...128z.
// This is achieved by placing the even samples into a single 256 deep fifo (A) and the
// odd samples into 2 128 deep FIFOs, one for the first 128 (B) and one for the second (C). The FIFOs
// are replayed in order A C B A C B ... Due to the flip of the B and C replay order B needs to be 256 deep
// to prevent overwrite.
#pragma HLS PIPELINE II=1
#pragma HLS DATA_PACK variable=output
#pragma HLS ARRAY_PARTITION variable=input dim=0
//#pragma HLS ARRAY_PARTITION variable=output dim=1
#pragma HLS INTERFACE axis port=input register reverse
#pragma HLS INTERFACE axis port=output register forward
#pragma HLS INTERFACE ap_ctrl_none port=return

	static bool primed, bwrite;
	static ap_uint<9> cycle, cycleout;
	static iqgroup_t A[256], B[2][128], C[128];
#pragma HLS DATA_PACK variable=A
#pragma HLS DATA_PACK variable=B
#pragma HLS DATA_PACK variable=C
#pragma HLS ARRAY_PARTITION variable=B complete dim=1

	bool mismatch[N_LANES];
#pragma HLS ARRAY_PARTITION variable=mismatch complete

	iqgroup_t groupin, groupout;
#pragma HLS DATA_PACK variable=groupin
#pragma HLS DATA_PACK variable=groupout

	for (unsigned int lane=0; lane<N_LANES; lane++) {
#pragma HLS UNROLL
		pfbaxisin_t in;
		in=input[lane];
		groupin.data[lane]=input[lane].data;
		mismatch[lane]=in.last && cycle!=511;
	}

	if (!cycle[0]) A[cycle/2]=groupin;
	if (cycle[0] && cycle < N_CHAN_PLANE ) B[bwrite][cycle/2]=groupin;
	if (cycle[0] && cycle >= N_CHAN_PLANE ) C[cycle/2-N_CHAN_PLANE/2]=groupin;

	if (primed) {
		if (cycleout < N_CHAN_PLANE) {
			groupout=A[cycleout];
		} else if (cycleout < 3*N_CHAN_PLANE/2) {
			groupout=C[cycleout-N_CHAN_PLANE];
		} else {
			groupout=B[!bwrite][cycleout-3*N_CHAN_PLANE/2];
		}
	}

//	cout<<cycle<<", "<<cycleout<<" P"<<primed<<": "<<groupout[0]<<endl;

	for (unsigned int lane=0; lane<N_LANES; lane++)
		output.data[lane]=groupout.data[lane];
	output.last=cycle==255 || cycle==511;

	if (cycle==511) bwrite=!bwrite;
	if (primed) cycleout++;
	primed|=cycle>=255;
	cycle++;
}

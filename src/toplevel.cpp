#include "toplevel.hpp"

#ifndef __SYNTHESIS__
#include <iostream>
using namespace std;
#endif


void sort_and_delay(pfbaxisin_t input[N_LANES], pfbaxisout_t &output) {

#pragma HLS PIPELINE II=1

	bool mismatch[N_LANES];
#pragma HLS ARRAY_PARTITION variable=mismatch complete

	static bool primed;
	static bool bwrite;
	static ap_uint<9> cycle, cycleout;
	static iq_t A[N_LANES][256], B[N_LANES][2][128], C[N_LANES][128];
#pragma HLS ARRAY_PARTITION variable=A complete dim=1
#pragma HLS ARRAY_PARTITION variable=B complete dim=1
#pragma HLS ARRAY_PARTITION variable=B complete dim=2
#pragma HLS ARRAY_PARTITION variable=C complete dim=1

	for (unsigned int lane=0; lane<N_LANES; lane++) {
#pragma HLS UNROLL
		pfbaxisin_t in=input[lane];
		iq_t iq=in.data;
		iq_t temp;

		mismatch[lane]|=in.last && cycle!=511;

		if (!cycle[0]) A[lane][cycle/2]=iq;
		if (cycle[0] && cycle < N_CHAN_PLANE ) B[lane][bwrite][cycle/2]=iq;
		if (cycle[0] && cycle >= N_CHAN_PLANE ) C[lane][cycle/2-N_CHAN_PLANE/2]=iq;



		if (primed) {
			if (cycleout < N_CHAN_PLANE) {
				temp=A[lane][cycleout];
			} else if (cycleout < 3*N_CHAN_PLANE/2) {
				temp=C[lane][cycleout-N_CHAN_PLANE];
			} else {
				temp=B[lane][!bwrite][cycleout-3*N_CHAN_PLANE/2];
			}
		}
		//if (lane==0) cout<<cycle<<", "<<cycleout<<" P"<<primed<<": "<<temp<<endl;
		output.data[lane]=temp;
	}
	output.last=cycleout==255 || cycleout==511;

	if (cycle==511) bwrite=!bwrite;
	if (primed) cycleout++;
	primed|=cycle>=255;
	cycle++;
}



void fir_to_fft(pfbaxisin_t input[N_LANES], pfbaxisout_t &output) {
//This takes a single PFB lane stream, consisting of 2 sets (one is delayed) of 256 TDM channels,
// and reorders them, correctly applying the required circular shift.
// e.g. 1 1z 2 2z 3 3z ... 256 256z becomes 1...256 129z...256z 1z...128z.
// This is achieved by placing the even samples into a single 256 deep fifo (A) and the
// odd samples into 2 128 deep FIFOs, one for the first 128 (B) and one for the second (C). The FIFOs
// are replayed in order A C B A C B ... Due to the flip of the B and C replay order B needs to be 256 deep
// to prevent overwrite.
#pragma HLS DATAFLOW
#pragma HLS DATA_PACK variable=output
#pragma HLS ARRAY_PARTITION variable=input dim=0
//#pragma HLS ARRAY_PARTITION variable=output dim=1
#pragma HLS INTERFACE axis port=input register reverse
#pragma HLS INTERFACE axis port=output register forward
#pragma HLS INTERFACE ap_ctrl_none port=return

	sort_and_delay(input, output);

}

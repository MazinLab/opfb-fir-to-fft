#include "toplevel.hpp"

#ifndef __SYNTHESIS__
#include <iostream>
using namespace std;
#endif


void fir_to_fft(hls::stream<opfbaxis_t> &input, hls::stream<opfbaxis_t> &output) {
//This takes a single PFB lane stream, consisting of 2 sets (one is delayed) of 256 TDM channels,
// and reorders them, correctly applying the required circular shift.
// e.g. 1 1z 2 2z 3 3z ... 256 256z becomes 1...256 129z...256z 1z...128z.
// This is achieved by placing the even samples into a single 256 deep fifo (A) and the
// odd samples into 2 128 deep FIFOs, one for the first 128 (B) and one for the second (C). The FIFOs
// are replayed in order A C B A C B ... Due to the flip of the B and C replay order B needs to be 256 deep
// to prevent overwrite.
#pragma HLS PIPELINE II=1
#pragma HLS INTERFACE axis register port=input
#pragma HLS INTERFACE axis register port=output
#pragma HLS INTERFACE ap_ctrl_none port=return

	static bool primed, bwrite;
	static ap_uint<9> cycle, cycleout;
	static iqword_t buffer[2][512];
#pragma HLS ARRAY_PARTITION variable=buffer complete dim=1

	iqword_t groupin=0, groupout=0;

	opfbaxis_t in=input.read();
	opfbaxis_t out;
	groupin=in.data;

	//N_CHAN_PLANE = 256
	// cycles 0 2 4 6 ... 510, indexes 0-255

	bool firsthalf=(cycle < N_CHAN_PLANE);
	int ndx=cycle/2+cycle[0]*(256+128*firsthalf-128*!firsthalf);
	buffer[bwrite][ndx]=groupin;
	groupout=buffer[!bwrite][cycleout];

	out.data=groupout;
	out.last=cycle==255 || cycle==511;
	output.write(out);

	if (cycle==511) bwrite=!bwrite;
	if (primed) cycleout++;
	primed|=cycle==511;
	cycle++;
}

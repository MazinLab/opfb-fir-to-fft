#include "toplevel.hpp"
#include "datatypes.hpp"
#include <iostream>
#include "hls_stream.h"
using namespace std;

#define N_CYCLES 3
//#define __PRINT_PATTERN__
#define PRINT 1

int main(){

	pfbaxisin_t lanein[N_CHAN_PLANE*N_CYCLES*2], laneout[N_CHAN_PLANE*N_CYCLES*2];
	bool fail=false;

	//Generate data
	for (int i=0; i<N_CYCLES; i++){
		for (int j=0; j<N_CHAN_PLANE*2; j+=2){
			lanein[i*N_CHAN_PLANE*2+j].data=iq_t(i*N_CHAN_PLANE*2+j,i*N_CHAN_PLANE*2+j);
			lanein[i*N_CHAN_PLANE*2+j+1].data=iq_t(i*N_CHAN_PLANE*2+j-N_CHAN_PLANE/2,
											  	   i*N_CHAN_PLANE*2+j+1);
		}
	}

	//Run the stream input
	for (int i=0; i<N_CYCLES;i++) { // Go through more than once to see the phase increment
		top(lanein+i*N_CHAN_PLANE*2, laneout+i*N_CHAN_PLANE*2);
	}

	//Compare the result
	if (PRINT) cout<<"==========================\n";
	for (int i=0; i<N_CYCLES;i++) { // Go through more than once
		for (int j=0;j<N_CHAN_PLANE*2;j++) {
			int cycle_offset=i*N_CHAN_PLANE*2;

			int predicted=cycle_offset;
			if (j<N_CHAN_PLANE) {
				predicted+=j*2;
			} else if (j-N_CHAN_PLANE<N_CHAN_PLANE/2) {
				predicted+=j*2+1-N_CHAN_PLANE;
			} else {
				predicted+=j*2+1-3*N_CHAN_PLANE;
			}
			int lanev=laneout[cycle_offset+j].data.real();
			int expected=lanein[predicted>0?predicted:0].data.real();
			if (PRINT) {
				cout<<"Cycle: "<<cycle_offset+j;
				cout<<" PNdx: "<<predicted;
				cout<<" In: "<<setw(13)<<lanein[cycle_offset+j].data;
				cout<<" Out: "<<setw(13)<<laneout[cycle_offset+j].data;
				cout<<" Expected: "<<setw(13)<<lanein[predicted>0?predicted:0].data;
				cout<<"\n";
			}
			if (expected!=lanev) {
				cout<<"FAIL CHECK\n";
				fail|=true;
			}

		}
	}
	if (PRINT) cout<<"==========================\n";

	if (!fail) cout<<"PASS!!\n";
	return fail ? 1:0;

}



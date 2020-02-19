#include "toplevel.hpp"
#include "datatypes.hpp"
#include <iostream>
#include "hls_stream.h"
using namespace std;

#define N_CYCLES 3
//#define __PRINT_PATTERN__
#define PRINT 1

int main(){

	pfbaxisin_t lanein[N_CYCLES][N_LANES][N_CHAN_PLANE*2], laneout[N_CYCLES][N_LANES][N_CHAN_PLANE*2];
	bool fail=false;

	//Generate data
	for (int i=0; i<N_CYCLES; i++){
		for (int j=0; j<N_CHAN_PLANE*2; j+=2){
			for (int k=0; k<N_LANES;k++){
				lanein[i][k][j].data=(i*N_CHAN_PLANE*2+j) | ((i*N_CHAN_PLANE*2+j)<<16);
				lanein[i][k][j+1].data=(i*N_CHAN_PLANE*2+j-N_CHAN_PLANE/2) | ((i*N_CHAN_PLANE*2+j+1)<<16);
			}
		}
	}

	//Run the stream input
	for (int i=0; i<N_CYCLES;i++) { // Go through more than once to see the phase increment
		fir_to_fftx16(lanein[i], laneout[i]);
	}

	//Compare the result
	int lane=14;
	if (PRINT) cout<<"==========================\n";
	for (int i=0; i<N_CYCLES;i++) { // Go through more than once
		for (int j=0;j<N_CHAN_PLANE*2;j++) {
			int cycle=i;
			int inputchan=0;
			if (j<N_CHAN_PLANE) {
				inputchan=j*2;
			} else if (j-N_CHAN_PLANE<N_CHAN_PLANE/2) {  //j 256-384
				inputchan=j*2+1-N_CHAN_PLANE;
			} else { //j >384
				inputchan=j*2+1-3*N_CHAN_PLANE;
			}
			int lanev=laneout[i][lane][j].data.to_uint()&0xffff;
			int expected=lanein[i][lane][inputchan].data.to_uint()&0xffff;
			if (PRINT) {
				cout<<"Clock Cycle: "<<i*N_CHAN_PLANE*2+j;
				cout<<" PNdx: "<<inputchan;
				cout<<" In: "<<setw(13)<<"("<<(lanein[i][lane][j].data.to_uint()&0xffff) <<","<<(lanein[i][lane][j].data.to_uint()>>16)<<")";
				cout<<" Out: "<<setw(13)<<"("<<(laneout[i][lane][j].data.to_uint()&0xffff) <<","<<(laneout[i][lane][j].data.to_uint()>>16)<<")";
				cout<<" Expected: "<<setw(13)<<"("<<(lanein[i][lane][inputchan].data.to_uint()&0xffff)<<","<<(lanein[i][lane][inputchan].data.to_uint()>>16)<<")";
				cout<<" Last: " << laneout[i][lane][j].last;
				cout<<"\n";
			}
			if (expected!=lanev) {
				cout<<"FAIL CHECK\n";
				fail|=true;
			}
			if (!(laneout[i][lane][j].last == (j==255 || j==511))) {
				cout<<"FAIL LAST CHECK\n";
				fail|=true;
			}

		}
	}
	if (PRINT) cout<<"==========================\n";

	if (!fail) cout<<"PASS!!\n";
	return fail ? 1:0;

}



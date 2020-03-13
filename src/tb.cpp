#include "toplevel.hpp"
#include "datatypes.hpp"
#include <iostream>
#include "hls_stream.h"
using namespace std;

#define N_CYCLES 2
//#define __PRINT_PATTERN__
#define PRINT 1

int main(){

	pfbaxisin_t lanein[N_CYCLES][N_LANES][N_CHAN_PLANE*2];
	pfbaxisout_t laneout[N_CYCLES][N_CHAN_PLANE*2];
	bool fail=false;

	//Generate data
	for (unsigned int i=0; i<N_CYCLES; i++){
		for (unsigned int j=0; j<N_CHAN_PLANE*2; j++){
			for (unsigned int k=0; k<N_LANES;k++){
				lanein[i][k][j].data=i*N_CHAN_PLANE*2+j;
				lanein[i][k][j].last=j==255||j==511;
			}
		}
	}

	//Run the stream input
	for (int i=0; i<N_CYCLES;i++) { // Go through more than once to see the phase increment
		fir_to_fft(lanein[i], laneout[i]);
	}

	//Compare the result
	int lane=0;
	if (PRINT)
		cout<<"==========================\n";

	for (int i=0; i<N_CYCLES;i++) { // Go through more than once
		for (int j=0;j<N_CHAN_PLANE*2;j++) {
			int cycle=i;
			int inputchan=0;
			if (j<N_CHAN_PLANE) {
				inputchan=j*2;
			} else if (j<3*N_CHAN_PLANE/2) {  //j 256-383
				inputchan=(j-N_CHAN_PLANE)*2+N_CHAN_PLANE+1; //1,3,5...
			} else { //j >=384
				inputchan=(j-3*N_CHAN_PLANE/2)*2+1; //j*2-3*N_CHAN_PLANE;
			}
			unsigned int lanev=laneout[i][j].data[lane].to_uint();
			unsigned int expected=lanein[i][lane][inputchan].data.to_uint();
			if (PRINT) {
				//cout<<"Clock Cycle: "<<i*N_CHAN_PLANE*2+j;
				//cout<<" PNdx: "<<inputchan;
				cout<<" In: "<<lanein[i][lane][j].data.to_uint()<<" Out: "<<lanev;
				cout<<" Expected: "<<expected;
				cout<<" Last: " << laneout[i][j].last<<endl;
			}
			if (expected!=lanev) {
				cout<<"FAIL CHECK\n";
				fail|=true;
			}
			if (!(laneout[i][j].last == (j==255 || j==511))) {
				cout<<"FAIL LAST CHECK\n";
				fail|=true;
			}

		}
	}
	if (PRINT) cout<<"==========================\n";

	if (!fail) cout<<"PASS!!\n";
	return fail ? 1:0;

}



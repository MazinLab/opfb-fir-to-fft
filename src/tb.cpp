#include "toplevel.hpp"
#include "datatypes.hpp"
#include <iostream>
#include "hls_stream.h"
using namespace std;

#define N_CYCLES 2
//#define __PRINT_PATTERN__
#define PRINT 1

#define TOTAL_CHAN N_CHAN_PLANE*2

int main(){

	pfbaxisin_t lanein[N_CYCLES][TOTAL_CHAN][N_LANES];
	pfbaxisout_t laneout[N_CYCLES*TOTAL_CHAN];
	bool fail=false;

	//Generate data
	for (unsigned int i=0; i<N_CYCLES; i++){
		for (unsigned int j=0; j<TOTAL_CHAN; j++){
			for (unsigned int k=0; k<N_LANES;k++){
				lanein[i][j][k].data=i*TOTAL_CHAN+j;
				lanein[i][j][k].last=j==255||j==511;
			}
		}
	}

	//Run the stream input
	for (int i=0; i<N_CYCLES;i++) { // Go through more than once to see the phase increment
		for (int j=0; j<TOTAL_CHAN; j++){
			int outndx=i*TOTAL_CHAN+j-N_CHAN_PLANE;
			fir_to_fft(lanein[i][j], laneout[outndx <0 ? 0: outndx]);
		}
	}

//	for (int i=0; i<N_CYCLES;i++)  // Go through more than once
//			for (int j=0;j<TOTAL_CHAN;j++) {
//				if ((i*TOTAL_CHAN+j) % 16 == 0) cout<<endl;
//				cout<<laneout[i*TOTAL_CHAN+j].data[0]<<",";
//			}

	//Compare the result
	int lane=0;
	if (PRINT)
		cout<<"==========================\n";

	for (int i=0; i<N_CYCLES;i++) { // Go through more than once
		for (int j=0;j<TOTAL_CHAN;j++) {
			if (i==N_CYCLES-1 && j>=N_CHAN_PLANE) break;
			int inputchan=0;
			if (j<N_CHAN_PLANE) {
				inputchan=j*2;
			} else if (j<3*N_CHAN_PLANE/2) {  //j 256-383
				inputchan=(j-N_CHAN_PLANE)*2+N_CHAN_PLANE+1; //1,3,5...
			} else { //j >=384
				inputchan=(j-3*N_CHAN_PLANE/2)*2+1; //j*2-3*N_CHAN_PLANE;
			}
			pfbaxisout_t out = laneout[i*TOTAL_CHAN+j];
			unsigned int lanev=out.data[lane].to_uint();
			unsigned int expected=lanein[i][inputchan][lane].data.to_uint();
			if (PRINT) {
				cout<<"Clock Cycle: "<<i*TOTAL_CHAN+j;
				cout<<" PNdx: "<<inputchan;
				cout<<" In: "<<lanein[i][j][lane].data.to_uint()<<" Out: "<<lanev;
				cout<<" Expected: "<<expected<<" Last: " << out.last<<endl;
			}
			if (expected!=lanev) {
				cout<<"FAIL CHECK\n";
				fail|=true;
			}
			if (!(out.last == (j==255 || j==511))) {
				cout<<"FAIL LAST CHECK\n";
				fail|=true;
			}

		}
	}
	if (PRINT) cout<<"==========================\n";

	if (!fail) cout<<"PASS!!\n";
	return fail ? 1:0;

}



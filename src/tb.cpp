#include "toplevel.hpp"
#include "datatypes.hpp"
#include <iostream>
#include "hls_stream.h"
using namespace std;

#define N_CYCLES 4
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
				lanein[i][j][k].data=i*N_CHAN_PLANE+j/2+128*(j%2);
				lanein[i][j][k].last=j==255||j==511;
			}
		}
	}

	//Run the stream input
	for (int i=0; i<N_CYCLES;i++) { // Go through more than once to see the phase increment
		for (int j=0; j<TOTAL_CHAN; j++){
			int outndx=(i-1)*TOTAL_CHAN+j;//-N_CHAN_PLANE;
			fir_to_fft(lanein[i][j], laneout[outndx <0 ? 0: outndx]);
			if (i==0 && j==N_CHAN_PLANE-1 && !laneout[0].last) {
				cout<<"TLAST Missing"<<endl;
				fail=true;
			}
		}
	}

//	for (int i=0; i<N_CYCLES;i++)  // Go through more than once
//			for (int j=0;j<TOTAL_CHAN;j++) {
//				if ((i*TOTAL_CHAN+j) % 16 == 0) cout<<endl;
//				cout<<laneout[i*TOTAL_CHAN+j].data[0]<<",";
//			}

	//Compare the result
	//We want to see 0-255 -128-0
	int lane=0;
	if (PRINT)
		cout<<"==========================\n";

	for (int i=0; i<N_CYCLES-1;i++) { // Go through more than once
		for (int j=0;j<TOTAL_CHAN;j++) {
			if (i==N_CYCLES-1 && j>=N_CHAN_PLANE) break;

			unsigned int ndx=i*TOTAL_CHAN+j;
			int inputchan=0;
			if (j<N_CHAN_PLANE) {
				inputchan=j*2;
			} else if (j<3*N_CHAN_PLANE/2) {  //j 256-383
				inputchan=(j-N_CHAN_PLANE)*2+N_CHAN_PLANE+1; //1,3,5...
			} else { //j >=384
				inputchan=(j-3*N_CHAN_PLANE/2)*2+1; //j*2-3*N_CHAN_PLANE;
			}
			pfbaxisout_t out = laneout[ndx];
			unsigned int lanev=out.data[lane].to_uint();
			unsigned int expected=lanein[i][inputchan][lane].data.to_uint();
			if (PRINT ){//&& ndx%128==0||ndx%128==1||ndx%128==127) {

				cout<<"Cycle "<<setw(4)<<ndx;
				//cout<<" (PNdx: "<<inputchan<<")";
				cout<<": In: "<<setw(4)<<lanein[i][j][lane].data.to_uint()<<" Out: "<<setw(4)<<lanev;
				cout<<" Expected: "<<setw(4)<<expected<<" Last: " << out.last<<endl;
			}
			if (expected!=lanev) {
				cout<<"FAIL CHECK\n";
				fail|=true;
			}
			if (!(out.last == (j==255 || j==511))) {
				cout<<"FAIL LAST CHECK\n";
				fail|=true;
			}
			if(PRINT && ndx%128==1) cout<<endl;
		}
	}
	if (PRINT) cout<<"==========================\n";

	if (!fail) cout<<"PASS!!\n";
	return fail ? 1:0;

}



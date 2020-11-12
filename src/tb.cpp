#include "toplevel.hpp"
#include "datatypes.hpp"
#include <iostream>
#include "hls_stream.h"
using namespace std;

#define N_CYCLES 6
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
				int cycle=i*TOTAL_CHAN+j;
				unsigned short ramp;
				ramp=N_LANES*(cycle-1)/2 + 8*(k%2) + k/2 - 2040*(cycle%2 == 0);
				if (i==0 && j%2==0 && j<N_CHAN_PLANE) ramp=0;
				lanein[i][j][k].data=(j/2)<<16 | ramp;
				lanein[i][j][k].last=j==255||j==511;
			}
		}
	}

	//Run the stream input
	for (int i=0; i<N_CYCLES;i++) {
		for (int j=0; j<TOTAL_CHAN; j++){
			int outndx=i*TOTAL_CHAN+j;
			pfbaxisin_t tmp[N_LANES];
			pfbaxisword_t in, out;

			for (int k=0;k<N_LANES;k++)
				in.data.range(32*(k+1)-1,32*k)=lanein[i][j][k].data;
			in.last=lanein[i][j][0].last;
			fir_to_fft(in, out);
			for (int k=0;k<N_LANES;k++) {
				tmp[k].data=out.data.range(32*(k+1)-1,32*k);
				tmp[k].last=out.last;
			}

			for (int k=0;k<N_LANES;k++) {
				laneout[outndx <0 ? 0: outndx].data[k] = tmp[k].data;
				laneout[outndx <0 ? 0: outndx].last |= tmp[k].last;
			}

			//Check tlast
			if (outndx>=0 && (j==255 || j==511)&& !laneout[outndx].last) {
				cout<<"TLAST Missing. "<<i<<","<<j<<endl;
				fail=true;
			}
		}
	}



	//Compare the result
	//We want to see 0-255 -128-0
	int lane=15;
	if (PRINT)
		cout<<"==========================\nBlock 0\n";

	for (int i=0; i<N_CYCLES-1;i++) { // Go through more than once
		for (int j=0;j<TOTAL_CHAN;j++) {
			if (i==N_CYCLES-2 && j>=N_CHAN_PLANE) break;

			unsigned int ndx=i*TOTAL_CHAN+j;

			int inputchan, tmp_i, tmp_j, tmp_ndx;
			bool reorder;
			tmp_ndx = ndx-768-256;
			tmp_i = max(tmp_ndx/512, 0);
			tmp_j = tmp_ndx-tmp_i*512;

			pfbaxisout_t out;
			bool print_cycle;
			unsigned int laneinv, lanev, expected, firin, firout, firexpect;

			out = laneout[ndx];
			laneinv=lanein[i][j][lane].data.to_uint();
			lanev=out.data[lane].to_uint();

			//This is gross
			expected=2048+4096*tmp_i+N_LANES*tmp_j + 8*(lane%2) + lane/2 - 4096*(tmp_j>383);
			expected|=((tmp_ndx+128+128*(j>255))%256)<<16;

			firin=laneinv>>16;
			firout=lanev>>16;
			firexpect=expected>>16;
			lanev&=0xffff;
			laneinv&=0xffff;
			expected&=0xffff;
			print_cycle = (ndx%128<3) || (ndx%128>125);

#define CSV 1
//			if (PRINT && print_cycle && CSV) {
//				cout<<setw(4)<<ndx;
//				//cout<<" (PNdx: "<<inputchan<<")";
//				cout<<","<<setw(5)<<laneinv<<", "<<setw(3)<<firin<<"";
//				cout<<", "<<setw(5)<<lanev<<", "<<setw(3)<<firout<<"";
//				cout<<" ,"<<setw(4)<<expected<<", "<<setw(3)<<firexpect<<"";
//				cout<<" , "<< out.last;
//				cout<<" tndx:"<<tmp_ndx<<","<<tmp_i<<","<<tmp_j;
//			}
			if (PRINT && print_cycle) {
				cout<<"Cycle "<<setw(4)<<ndx;
				//cout<<" (PNdx: "<<inputchan<<")";
				cout<<": In: "<<setw(5)<<laneinv<<" ("<<setw(3)<<firin<<")";
				cout<<"  Out: "<<setw(5)<<lanev<<" ("<<setw(3)<<firout<<")";
				cout<<" Expected: "<<setw(4)<<expected<<" ("<<setw(3)<<firexpect<<")";
				cout<<" Last: " << out.last;
				//cout<<" tndx:"<<tmp_ndx<<","<<tmp_i<<","<<tmp_j;
			}
			if (expected!=lanev && tmp_ndx>=0 ) {
				if (PRINT && print_cycle) cout<<", FAIL MATCH";
				fail|=true;
			}
			if (!(out.last == (j==255 || j==511))) {
				if (PRINT && print_cycle) cout<<", FAIL TLAST";
				fail|=true;
			}
			if (PRINT && print_cycle) cout<<endl;
			if (PRINT && (ndx+1)%256==0) cout<<"Block "<<(ndx+1)/256<<endl;
			if (PRINT && ndx%128==2) cout<<"..."<<endl;
		}
	}
	if (PRINT) cout<<"==========================\n";

	if (!fail) cout<<"PASS!!\n";
	return fail ? 1:0;

}



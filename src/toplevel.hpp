#include "datatypes.hpp"
#include "ap_shift_reg.h"
#include "hls_stream.h"
#include "ap_int.h"
#include "ap_axi_sdata.h"
#define N_CHAN_PLANE 256
#define N_LANES 16
#define N_ADC_OUT 8
#define N_GROUPS 256

typedef ap_int<32> iq_t;

typedef ap_uint<16> sample_t;

typedef ap_uint<32*N_LANES> iqword_t;

//typedef struct {
//  iqword_t data;
//  ap_uint<1> last;
//} pfbaxisword_t;

typedef struct {
  iq_t data;
  ap_uint<1> last;
} pfbaxisin_t;

typedef struct {
	iq_t data[N_LANES];
} iqgroup_t;


typedef struct {
  iq_t data[N_LANES];
  ap_uint<1> last;
} pfbaxisout_t;

typedef ap_axiu<512, 0,0,0> opfbaxis_t;

typedef ap_shift_reg<iq_t, N_CHAN_PLANE> iqChanDelay_t;
typedef ap_shift_reg<iq_t, N_CHAN_PLANE/2> iqHalfChanDelay_t;

void fir_to_fft(hls::stream<opfbaxis_t> &input, hls::stream<opfbaxis_t> &output);

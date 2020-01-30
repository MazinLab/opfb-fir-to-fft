#include "datatypes.hpp"
#include "ap_shift_reg.h"
#include "hls_stream.h"

#define N_CHAN_PLANE 256
typedef ap_shift_reg<iq_t, N_CHAN_PLANE> iqChanDelay_t;
typedef ap_shift_reg<iq_t, N_CHAN_PLANE/2> iqHalfChanDelay_t;

//void top(pfbaxisin_t &in, pfbaxisin_t &out);
void fir_to_fft(pfbaxisin_t input[N_CHAN_PLANE*2], pfbaxisin_t output[N_CHAN_PLANE*2]);
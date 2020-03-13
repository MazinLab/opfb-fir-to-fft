#include "datatypes.hpp"
#include "ap_shift_reg.h"
#include "hls_stream.h"

#define N_CHAN_PLANE 256
#define N_LANES 16
typedef ap_shift_reg<iq_t, N_CHAN_PLANE> iqChanDelay_t;
typedef ap_shift_reg<iq_t, N_CHAN_PLANE/2> iqHalfChanDelay_t;

void fir_to_fft(pfbaxisin_t input[N_LANES][N_CHAN_PLANE*2], pfbaxisout_t output[N_CHAN_PLANE*2]);

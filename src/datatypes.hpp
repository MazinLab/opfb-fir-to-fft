#ifndef __DATATYPES_HPP__
#define __DATATYPES_HPP__
#include "ap_int.h"

#define N_LANES 16
#define N_ADC_OUT 8
#define N_GROUPS 256

typedef ap_uint<32> iq_t;


typedef ap_uint<32> iqstruct_t;

typedef struct {
  iq_t       data;
  ap_uint<1>       last;
} pfbaxisin_t;


#endif

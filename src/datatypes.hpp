#ifndef __DATATYPES_HPP__
#define __DATATYPES_HPP__
#include "ap_fixed.h"
#include <complex>
#include "ap_int.h"

#define N_LANES 16
#define N_ADC_OUT 8
#define N_GROUPS 256

typedef ap_fixed<16, 1, AP_RND_CONV, AP_SAT> sample_t;
typedef short rawsample_t;

typedef std::complex<rawsample_t> iq_t;

typedef struct {
	rawsample_t i;
	rawsample_t q;
} iqstruct_t;

typedef struct {
	rawsample_t data[N_ADC_OUT];
} adcaxis_t;

typedef struct {
	iq_t data;
} pfbaxisin_t;

//typedef struct {
//	iq_t data[N_ADC_OUT];
//} iqgroup_t;


#endif

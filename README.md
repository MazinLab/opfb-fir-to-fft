# opfb-fir-to-fft
Core to reorder and stream data from the OPFB FIRs to the FFT

Inputs: 
- 16x 32bit (IQ) AXI4S of 18 bit complex equipped with TLAST

Output: 
- 16x 32bit (IQ) AXI4S of 18 bit complex equipped with TLAST

This block takes an IQ stream from each lane's FIR and reorderes them as needed to feed the FFT. It breaks the incoming
stream into even (A group) and odd samples, with the odd samples grouped into a group of the first 128 (B) and the
second 128 (C). Samples are stored in an internal pingpong buffer and sent on to the FFT in order from A, then C, then B, thereby
achieving the alternating cycle reorder required by the OPFB. The results of the are available from the C simulation of
the core. The core requires two full sets of 256 samples to prime its buffers.
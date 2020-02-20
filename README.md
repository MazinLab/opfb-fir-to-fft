# opfb-fir-to-fft
Core to reorder and stream data from the OPFB FIRs to the FFT

Inputs: 
- 16x 36bit (IQ) AXI4S of 18 bit complex equipped with TLAST

Output: 
- 16x 36bit (IQ) AXI4S of 18 bit complex equipped with TLAST

This block takes an IQ stream from each lane's FIR and reorderes them as needed to feed the FFT. It breaks the incoming
stream into even (FIFO A) and odd samples, with the odd samples grouped into a group of the first 128 (FIFO B) and the
second 128 (FIFO C). Samples are stored in internal FIFOs and sent on to the FFT in order from A, then C, then B, thereby
achieving the alternating cycle reorder required by the OPFB. The results of the are available from the C simulation of
the core.
# Create project
open_project -reset opfb-fir-to-fft

# Add source files and test bench
add_files src/datatypes.hpp
add_files src/toplevel.cpp
add_files src/toplevel.hpp
add_files -tb src/tb.cpp

# Specify the top-level function for synthesis
set_top fir_to_fftx16

# Create solution1
open_solution -reset "solution1"

# Specify Xilinx part, clock period, and export style
set_part {xczu28dr-ffvg1517-2-e}
create_clock -period 550MHz -name default
config_export -description {Reorder and shift data for OPFB FFT} -display_name "PFB to FFT" -format ip_catalog -library mkidgen3 -rtl verilog -vendor MazinLab -version 0.1

# Simulate the C Codee
csim_design

# Synethsize, verify the RTL, and produce IP
csynth_design
cosim_design
export_design
exit

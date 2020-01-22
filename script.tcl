open_project opfb-fir-to-fft
set_top top
add_files src/datatypes.hpp
add_files src/toplevel.cpp
add_files src/toplevel.hpp
add_files -tb src/tb.cpp
open_solution "solution1"
set_part {xczu28dr-ffvg1517-2-e}
create_clock -period 550MHz -name default
config_export -description {Reorder and shift data for OPFB FFT} -display_name "PFB to FFT" -format ip_catalog -library mkidgen3 -rtl verilog -vendor MazinLab -version 0.1
#source "./solution1/directives.tcl"
csim_design
csynth_design
cosim_design
export_design -flow impl -rtl verilog -format ip_catalog -description "Reorder and shift data for OPFB FFT" -vendor "MazinLab" -library "mkidgen3" -version "0.1" -display_name "PFB to FFT"

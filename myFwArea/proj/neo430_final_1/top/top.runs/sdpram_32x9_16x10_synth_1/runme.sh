#!/bin/sh

# 
# Vivado(TM)
# runme.sh: a Vivado-generated Runs Script for UNIX
# Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
# 

if [ -z "$PATH" ]; then
  PATH=/software/CAD/Xilinx/2018.1/SDK/2018.1/bin:/software/CAD/Xilinx/2018.1/Vivado/2018.1/ids_lite/ISE/bin/lin64:/software/CAD/Xilinx/2018.1/Vivado/2018.1/bin
else
  PATH=/software/CAD/Xilinx/2018.1/SDK/2018.1/bin:/software/CAD/Xilinx/2018.1/Vivado/2018.1/ids_lite/ISE/bin/lin64:/software/CAD/Xilinx/2018.1/Vivado/2018.1/bin:$PATH
fi
export PATH

if [ -z "$LD_LIBRARY_PATH" ]; then
  LD_LIBRARY_PATH=/software/CAD/Xilinx/2018.1/Vivado/2018.1/ids_lite/ISE/lib/lin64
else
  LD_LIBRARY_PATH=/software/CAD/Xilinx/2018.1/Vivado/2018.1/ids_lite/ISE/lib/lin64:$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH

HD_PWD='/usersc/ng18731/neo430_test/myFwArea/proj/neo430_final_1/top/top.runs/sdpram_32x9_16x10_synth_1'
cd "$HD_PWD"

HD_LOG=runme.log
/bin/touch $HD_LOG

ISEStep="./ISEWrap.sh"
EAStep()
{
     $ISEStep $HD_LOG "$@" >> $HD_LOG 2>&1
     if [ $? -ne 0 ]
     then
         exit
     fi
}

EAStep vivado -log sdpram_32x9_16x10.vds -m64 -product Vivado -mode batch -messageDb vivado.pb -notrace -source sdpram_32x9_16x10.tcl

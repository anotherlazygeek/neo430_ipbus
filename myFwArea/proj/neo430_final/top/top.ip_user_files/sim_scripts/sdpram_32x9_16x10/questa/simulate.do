onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib sdpram_32x9_16x10_opt

do {wave.do}

view wave
view structure
view signals

do {sdpram_32x9_16x10.udo}

run -all

quit -force

#!/usr/bin/python

import uhal
import time
import sys

uhal.setLogLevelTo(uhal.LogLevel.NOTICE)
manager = uhal.ConnectionManager("file://connections.xml")
hw_list = [manager.getDevice(i) for i in sys.argv[1:]]

if len(hw_list) == 0:
	print "No targets specified - I'm done"
	sys.exit()

for hw in hw_list:
    print hw.id()

    reg = hw.getNode("csr.ctrl.id").read()
    hw.dispatch()
    print hex(reg)


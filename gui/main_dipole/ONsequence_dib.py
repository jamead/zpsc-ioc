#!/usr/bin/env python3
#Control for Backup SR Dipole Power Supply On/Off Sequence
import sys
import epics
from epics import caput
import time

#cmd = 'lab{2}Chan1:DAC_SetPt-SP, ' 
#print(cmd)
#print(sp)

caput('lab{2}Chan1:DigOut_ON1-SP', 1) # CH1 ON1 pulse train on
time.sleep(0.5)
caput('lab{2}Chan2:DigOut_Park-SP', 0) # unpark PS1 voltage loop
caput('lab{2}Chan3:DigOut_Park-SP', 0) # unpark PS2 voltage loop
time.sleep(0.5)
caput('lab{2}Chan1:DAC_SetPt-SP', 0.1) # put current loop setpoint to 0.1 A
time.sleep(1)
caput('lab{2}Chan1:DigOut_Park-SP', 0) # unpark current loop





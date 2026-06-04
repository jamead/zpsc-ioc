#Control for Backup SR Dipole Power Supply On/Off Sequence
import sys
import epics
from epics import caput
import time

cmd = sys.argv[1]

#cmd = 'lab{2}Chan1:DAC_SetPt-SP, ' 
#print(cmd)
#print(sp)

#turning on
if cmd == "on":
	caput('lab{2}Chan1:DigOut_ON1-SP', 1) # CH1 ON1 pulse train on
	time.sleep(0.5)
	caput('lab{2}Chan2:DigOut_Park-SP', 0) # unpark PS1 voltage loop
	caput('lab{2}Chan3:DigOut_Park-SP', 0) # unpark PS2 voltage loop
	time.sleep(0.5)
	caput('lab{2}Chan1:DAC_SetPt-SP', 0.1) # put current loop setpoint to 0.1 A
	time.sleep(1)
	caput('lab{2}Chan1:DigOut_Park-SP', 0) # unpark current loop


#turning off
if cmd == "off":
	caput('lab{2}Chan1:DigOut_Park-SP', 1) # park current loop setpoint
	time.sleep(0.5)
	caput('lab{2}Chan1:DAC_SetPt-SP', 0) # put current loop setpoint to 0 A
	time.sleep(1)
	caput('lab{2}Chan2:DigOut_Park-SP', 1) # park PS1 voltage loop
	caput('lab{2}Chan3:DigOut_Park-SP', 1) # park PS2 voltage loop
	time.sleep(0.5)
	caput('lab{2}Chan1:DigOut_ON1-SP', 0) # CH1 ON1 pulse train off

	
	






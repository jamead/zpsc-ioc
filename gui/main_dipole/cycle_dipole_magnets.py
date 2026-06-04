#!/usr/bin/env python3
#Control for Backup SR Dipole Power Supply On/Off Sequence
import sys
import epics
from epics import caput
import time


caput('lab{1}Chan1:SF:AmpsperSec-SP', 20)
time.sleep(2)

#sp = [220, 0.1, 220, 0.1, 220, 0.1, 220, 0.1, 200]
sp = [380, 0.2, 380, 0.2, 380, 0.2, 380, 0.2, 380, 0.2, 380, 0.2, 380, 0.2]
#sp = [22, 0.1, 22, 0.1, 22, 0.1, 22, 0.1, 20]
#sp1=sp/10

for i in sp:
	caput('lab{1}Chan1:DAC_SetPt-SP', i)
	print(f'Setpoint set to {i}')
	time.sleep(15)


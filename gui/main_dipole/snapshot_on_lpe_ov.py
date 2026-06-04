#take snapshot on all 4 channels when changing setpoint

import sys
import epics
from epics import caget, caput

#sp = float(sys.argv[1])

#cmd = 'lab{2}Chan1:DAC_SetPt-SP, ' 
#print(cmd)
#print(sp)
pv1 = 'lab{1}Chan2:Gnd-Wfm'
pv2 = 'lab{1}Chan3:Gnd-Wfm'
pv3 = 'lab{1}Chan1:DigIn-I.B0'
print(f'Now monitoring {pv1}, {pv2}, {pv3}')
untripped = True

try:
	while untripped:
		pv1_rslt = caget(pv1)
		pv2_rslt = caget(pv2)
		flt_rslt = caget(pv3)
		#if ((pv1_rslt.any() >= 11) or (pv2_rslt.any() >= 11) or (pv3 == 1)):
		if (flt_rslt == 1):
			untripped = False
	if untripped == False:
		caput('lab{1}Chan1:SS:Trig:Usr', 1)
		caput('lab{1}Chan2:SS:Trig:Usr', 1)
		caput('lab{1}Chan3:SS:Trig:Usr', 1)
		caput('lab{1}Chan4:SS:Trig:Usr', 1)
		caput('lab{2}Chan1:SS:Trig:Usr', 1)
		caput('lab{2}Chan2:SS:Trig:Usr', 1)
		caput('lab{2}Chan3:SS:Trig:Usr', 1)
		caput('lab{2}Chan4:SS:Trig:Usr', 1)
		
	print(f'(pv1_rslt = {pv1_rslt}, pv2_rslt = {pv2_rslt}, flt_rslt = {flt_rslt}')
	print('Snapshot Captured, script ending')
except KeyboardInterrupt:
	print(f'(pv1_rslt = {pv1_rslt}, pv2_rslt = {pv2_rslt}, flt_rslt = {flt_rslt}')
	print('Keyboard Interrupted')
#caput('lab{2}Chan1:DAC_SetPt-SP', sp)
#caput('lab{1}Chan1:SS:Trig:Usr', 1)
#caput('lab{1}Chan2:SS:Trig:Usr', 1)
#caput('lab{1}Chan3:SS:Trig:Usr', 1)
#caput('lab{1}Chan4:SS:Trig:Usr', 1)
#caput('lab{2}Chan1:SS:Trig:Usr', 1)
#caput('lab{2}Chan2:SS:Trig:Usr', 1)
#caput('lab{2}Chan3:SS:Trig:Usr', 1)
#caput('lab{2}Chan4:SS:Trig:Usr', 1)

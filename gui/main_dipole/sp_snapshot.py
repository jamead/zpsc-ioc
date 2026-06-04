#take snapshot on all 4 channels when changing setpoint

import sys
import epics
from epics import caput

#sp = float(sys.argv[1])

#cmd = 'lab{2}Chan1:DAC_SetPt-SP, ' 
#print(cmd)
#print(sp)

#caput('lab{2}Chan1:DAC_SetPt-SP', sp)
caput('lab{1}Chan1:SS:Trig:Usr', 1)
caput('lab{1}Chan2:SS:Trig:Usr', 1)
caput('lab{1}Chan3:SS:Trig:Usr', 1)
caput('lab{1}Chan4:SS:Trig:Usr', 1)
caput('lab{2}Chan1:SS:Trig:Usr', 1)
caput('lab{2}Chan2:SS:Trig:Usr', 1)
caput('lab{2}Chan3:SS:Trig:Usr', 1)
caput('lab{2}Chan4:SS:Trig:Usr', 1)

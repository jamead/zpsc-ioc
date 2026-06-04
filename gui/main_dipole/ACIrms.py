import epics
from epics import caget, caput
from epics import PV
import sys
from datetime import datetime
import time
import numpy as np
from matplotlib import pyplot as pl

while('True'):
	ACI1 = caget('lab{2}Chan1:INJ:Volt-Wfm')
	ACI2 = caget('lab{2}Chan1:INJ:Gnd-Wfm')
	ACI3 = caget('lab{2}Chan1:INJ:Spare-Wfm')
	ACI4 = caget('lab{2}Chan2:INJ:Volt-Wfm')
	ACI5 = caget('lab{2}Chan2:INJ:Gnd-Wfm')
	ACI6 = caget('lab{2}Chan2:INJ:Spare-Wfm')

	N = len(ACI1)
	#print(N)
	print()
	print()

	rms1 = np.sqrt(np.mean(ACI1[0:7970]**2))
	rms2 = np.sqrt(np.mean(ACI2[0:7970]**2))
	rms3 = np.sqrt(np.mean(ACI3[0:7970]**2))
	rms4 = np.sqrt(np.mean(ACI4[0:7970]**2))
	rms5 = np.sqrt(np.mean(ACI5[0:7970]**2))
	rms6 = np.sqrt(np.mean(ACI6[0:7970]**2))
		
	print("%3.1f" % rms1)
	print("%3.1f" % rms2)
	print("%3.1f" % rms3)
	print("%3.1f" % rms4)
	print("%3.1f" % rms5)
	print("%3.1f" % rms6)

	time.sleep(1)

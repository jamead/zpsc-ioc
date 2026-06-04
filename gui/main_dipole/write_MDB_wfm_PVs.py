import epics
from epics import caget
from epics import PV
import sys


#psc = sys.argv[1]
#chan = sys.argv[2]
#string1 = 'lab{' + psc + '}Chan' + chan + ':USR:'
string1 = 'lab{1}Chan1:USR:'
print(string1)

A = caget(string1 + 'DCCT1-Wfm')
B = caget(string1 + 'DCCT2-Wfm')
C = caget(string1 + 'DAC-Wfm')
D = caget(string1 + 'Reg-Wfm')
E = caget(string1 + 'Gnd-Wfm')
F = caget(string1 + 'Error-Wfm')
G = caget(string1 + 'Volt-Wfm')
H = caget(string1 + 'Spare-Wfm')

recsize = len(C)
print(recsize)
	
filename = "/home/psctester/PSC1CH1.txt"		
fp = open(filename, 'w')
fp.write("Backup Dipole PS CH1\n" )
fp.write("Total number of PVs : 8\n")
fp.write("Total number of rows: %s\n" % (recsize) )
fp.write("DCCT1  DCCT2   DAC  RegOut  Ignd  Error   Vout    Spare\n")
fp.write("END Header\n")

for x in range(recsize):
    string = ("%5.5f,%5.5f,%5.5f,%5.5f,%5.5f,%5.5f,%5.5f,%5.5f\n") \
    % (A[x], B[x], C[x], D[x], E[x], F[x], G[x], H[x])
    fp.write(string)
fp.close()







string1 = 'lab{1}Chan2:USR:'
print(string1)

A = caget(string1 + 'DCCT1-Wfm')
B = caget(string1 + 'DCCT2-Wfm')
C = caget(string1 + 'DAC-Wfm')
D = caget(string1 + 'Reg-Wfm')
E = caget(string1 + 'Gnd-Wfm')
F = caget(string1 + 'Error-Wfm')
G = caget(string1 + 'Volt-Wfm')
H = caget(string1 + 'Spare-Wfm')

recsize = len(C)
print(recsize)
	
filename = "/home/psctester/PSC1CH2.txt"		
fp = open(filename, 'w')
fp.write("Backup Dipole PS CH2\n" )
fp.write("Total number of PVs : 8\n")
fp.write("Total number of rows: %s\n" % (recsize) )
fp.write("PSVout  -   -  Series Pass Control  LPE Vdrop  Error   Liquablade Vout    -\n")
fp.write("END Header\n")

for x in range(recsize):
    string = ("%5.5f,%5.5f,%5.5f,%5.5f,%5.5f,%5.5f,%5.5f,%5.5f\n") \
    % (A[x], B[x], C[x], D[x], E[x], F[x], G[x], H[x])
    fp.write(string)
fp.close()





string1 = 'lab{1}Chan3:USR:'
print(string1)

A = caget(string1 + 'DCCT1-Wfm')
B = caget(string1 + 'DCCT2-Wfm')
C = caget(string1 + 'DAC-Wfm')
D = caget(string1 + 'Reg-Wfm')
E = caget(string1 + 'Gnd-Wfm')
F = caget(string1 + 'Error-Wfm')
G = caget(string1 + 'Volt-Wfm')
H = caget(string1 + 'Spare-Wfm')

recsize = len(C)
print(recsize)
	
filename = "/home/psctester/PSC1CH3.txt"		
fp = open(filename, 'w')
fp.write("Backup Dipole PS CH3\n" )
fp.write("Total number of PVs : 8\n")
fp.write("Total number of rows: %s\n" % (recsize) )
fp.write("PSVout  -   -  Series Pass Control  LPE Vdrop  Error   Liquablade Vout    -\n")
fp.write("END Header\n")

for x in range(recsize):
    string = ("%5.5f,%5.5f,%5.5f,%5.5f,%5.5f,%5.5f,%5.5f,%5.5f\n") \
    % (A[x], B[x], C[x], D[x], E[x], F[x], G[x], H[x])
    fp.write(string)
fp.close()




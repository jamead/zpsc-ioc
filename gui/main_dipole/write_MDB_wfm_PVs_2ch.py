import epics
from epics import caget, caput
from epics import PV
import sys
from datetime import datetime
import time

last_value = 0
last_ac_flt = 0
last_ps_flt = 0

psc1_flt_string = ['lab{1}Chan1:FLT:', 'lab{1}Chan2:FLT:', 'lab{1}Chan3:FLT:', 'lab{1}Chan4:FLT:']
psc1_wfm_string = ['DAC-Wfm', 'DCCT1-Wfm', 'DCCT2-Wfm', 'Error-Wfm', 'Reg-Wfm', 'Volt-Wfm', 'Gnd-Wfm', 'Spare-Wfm']

psc2_flt_string = ['lab{2}Chan1:FLT:', 'lab{2}Chan2:FLT:', 'lab{2}Chan3:FLT:']
psc2_wfm_string = ['Volt-Wfm', 'Gnd-Wfm', 'Spare-Wfm']

def save_ss1():
	global psc1_flt_string, psc1_wfm_string
	print('PSC1 Snapshot Function has begun!')
	dt_dec = bytes(caget('lab{1}Chan1:FltTrigTime-I.VALA')).decode('ascii').rstrip('\x00')
	dt = datetime.strptime(dt_dec,"%Y-%m-%d %H:%M:%S")
	print(f'timestamp: {dt}')
	time.sleep(5)
	
	c1w1 = caget(psc1_flt_string[0] + psc1_wfm_string[0])
	c1w2 = caget(psc1_flt_string[0] + psc1_wfm_string[1])
	c1w3 = caget(psc1_flt_string[0] + psc1_wfm_string[2])
	c1w4 = caget(psc1_flt_string[0] + psc1_wfm_string[3])
	c1w5 = caget(psc1_flt_string[0] + psc1_wfm_string[4])
	c1w6 = caget(psc1_flt_string[0] + psc1_wfm_string[5])
	c1w7 = caget(psc1_flt_string[0] + psc1_wfm_string[6])
	c1w8 = caget(psc1_flt_string[0] + psc1_wfm_string[7])
	
	c2w1 = caget(psc1_flt_string[1] + psc1_wfm_string[0])
	c2w2 = caget(psc1_flt_string[1] + psc1_wfm_string[1])
	c2w3 = caget(psc1_flt_string[1] + psc1_wfm_string[2])
	c2w4 = caget(psc1_flt_string[1] + psc1_wfm_string[3])
	c2w5 = caget(psc1_flt_string[1] + psc1_wfm_string[4])
	c2w6 = caget(psc1_flt_string[1] + psc1_wfm_string[5])
	c2w7 = caget(psc1_flt_string[1] + psc1_wfm_string[6])
	c2w8 = caget(psc1_flt_string[1] + psc1_wfm_string[7])
	
	c3w1 = caget(psc1_flt_string[2] + psc1_wfm_string[0])
	c3w2 = caget(psc1_flt_string[2] + psc1_wfm_string[1])
	c3w3 = caget(psc1_flt_string[2] + psc1_wfm_string[2])
	c3w4 = caget(psc1_flt_string[2] + psc1_wfm_string[3])
	c3w5 = caget(psc1_flt_string[2] + psc1_wfm_string[4])
	c3w6 = caget(psc1_flt_string[2] + psc1_wfm_string[5])
	c3w7 = caget(psc1_flt_string[2] + psc1_wfm_string[6])
	c3w8 = caget(psc1_flt_string[2] + psc1_wfm_string[7])
	
	c4w1 = caget(psc1_flt_string[3] + psc1_wfm_string[0])
	c4w2 = caget(psc1_flt_string[3] + psc1_wfm_string[1])
	c4w3 = caget(psc1_flt_string[3] + psc1_wfm_string[2])
	c4w4 = caget(psc1_flt_string[3] + psc1_wfm_string[3])
	c4w5 = caget(psc1_flt_string[3] + psc1_wfm_string[4])
	c4w6 = caget(psc1_flt_string[3] + psc1_wfm_string[5])
	c4w7 = caget(psc1_flt_string[3] + psc1_wfm_string[6])
	c4w8 = caget(psc1_flt_string[3] + psc1_wfm_string[7])
	
	print('Writing to PSC1 file...')
	filename = "/home/psctester/flts/PSC1_SS_"+str(dt)+".txt"
	fp = open(filename, 'w')
	fp.write("Backup Dipole PSC1\n" )
	fp.write("Total number of PVs : 24\n")
	recsize = len(c1w1)
	fp.write("Total number of rows: %s\n" % (recsize))
	fp.write("CH1 DAC,CH1 DCCT1,CH1 DCCT2,CH1 ERROR,CH1 REGULATOR,CH1 PS VOUT,CH1 iGND,CH1 SPARE,\
	CH2 SPARE,CH2 PS VOUT,CH2 SPARE,CH2 ERROR,CH2 REGULATOR,CH2 LIQUABLADE VOUT,CH2 SERIES PASS VDROP,CH2 SPARE,\
	CH3 SPARE,CH3 PS VOUT,CH3 SPARE,CH3 ERROR,CH3 REGULATOR,CH3 LIQUABLADE VOUT,CH3 SERIES PASS VDROP,CH3 SPARE,\
	CH4 SPARE,CH4 PS VOUT,CH4 SPARE,CH4 ERROR,CH4 REGULATOR,CH4 LIQUABLADE VOUT,CH4 SERIES PASS VDROP,CH4 SPARE,\
	\n")
	# fp.write("END Header\n")

	for x in range(recsize):
		string = ("%5.5f,%5.5f,%5.5f,%5.5f,%5.5f,%5.5f,%5.5f,%5.5f,\
		%5.5f,%5.5f,%5.5f,%5.5f,%5.5f,%5.5f,%5.5f,%5.5f,\
		%5.5f,%5.5f,%5.5f,%5.5f,%5.5f,%5.5f,%5.5f,%5.5f,\
		%5.5f,%5.5f,%5.5f,%5.5f,%5.5f,%5.5f,%5.5f,%5.5f\
		\n") \
		% (c1w1[x], c1w2[x], c1w3[x], c1w4[x], c1w5[x], c1w6[x], c1w7[x], c1w8[x],\
		c2w1[x], c2w2[x], c2w3[x], c2w4[x], c2w5[x], c2w6[x], c2w7[x], c2w8[x],\
		c3w1[x], c3w2[x], c3w3[x], c3w4[x], c3w5[x], c3w6[x], c3w7[x], c3w8[x],\
		c4w1[x], c4w2[x], c4w3[x], c4w4[x], c4w5[x], c4w6[x], c4w7[x], c4w8[x])
		fp.write(string)
	fp.close()
	print('Finished writing to PSC1 file!')

def save_ss2():
	global psc2_flt_string, psc2_wfm_string

	print('PSC1 Snapshot Function has begun!')
	dt_dec = bytes(caget('lab{2}Chan3:FltTrigTime-I.VALA')).decode('ascii').rstrip('\x00')
	dt = datetime.strptime(dt_dec,"%Y-%m-%d %H:%M:%S")
	print(f'timestamp: {dt}')
	#time.sleep(10)
	
	A = caget(psc2_flt_string[0] + psc2_wfm_string[0])
	B = caget(psc2_flt_string[0] + psc2_wfm_string[1])
	C = caget(psc2_flt_string[0] + psc2_wfm_string[2])
	D = caget(psc2_flt_string[1] + psc2_wfm_string[0])
	E = caget(psc2_flt_string[1] + psc2_wfm_string[1])
	F = caget(psc2_flt_string[1] + psc2_wfm_string[2])
	G = caget(psc2_flt_string[2] + psc2_wfm_string[0])
	H = caget(psc2_flt_string[2] + psc2_wfm_string[1])
	I = caget(psc2_flt_string[2] + psc2_wfm_string[2])
	
	print('Writing to PSC2 file...')
	filename = "/home/psctester/flts/PSC2_SS_"+str(dt)+".txt"
	fp = open(filename, 'w')
	fp.write("Backup Dipole PSC2\n" )
	fp.write("Total number of PVs : 9\n")
	recsize = len(C)
	fp.write("Total number of rows: %s\n" % (recsize))
	fp.write("IAC PS1 Ph-A,IAC PS1 Ph-B,IAC PS1 Ph-C,IAC PS2 Ph-A,IAC PS2 Ph-B,IAC PS2 Ph-C,VAC Ph-AB,VAC Ph-BC,VAC Ph-AC\n")
	# fp.write("END Header\n")

	for x in range(recsize):
		string = ("%5.5f,%5.5f,%5.5f,%5.5f,%5.5f,%5.5f,%5.5f,%5.5f,%5.5f\n") \
		% (D[x], E[x], F[x], A[x], B[x], C[x], G[x], H[x], I[x])
		fp.write(string)
	fp.close()
	print('Finished writing to PSC2 file!')
		


def main():
	global last_ac_flt, last_ps_flt
	print('Entering loop...')
	while True:
		try:
			# #curr_value = int(caget('lab{1}Chan1:FltTrigActive-I'))
			# # Comment out for weekend with forced fault condition
			# # curr_value = int(caget('lab{1}Chan1:FaultsLat-I.B7')) | int(caget('lab{1}Chan1:FaultsLive-I.B8'))
			# curr_value = int(caget('lab{1}Chan1:FaultsLive-I.B8'))
			# if curr_value not in(0, 1):
				# continue
			# # curr_value = caget('lab{2}Chan3:UsrTrigActive-I')
			# if curr_value == 1 and last_value == 0:
				# print('Rising edge!')
				# # last_value = curr_value
				# print('Calling functions')
				# save_ss1()
				# save_ss2()
			# elif curr_value == 0 and last_value == 1:
				# print('Falling edge')
				# # # last_value = curr_value
				# # print('Resetting Latched Faults on zPSCs...')
				# # time.sleep(1)
				# # if caget('lab{1}Chan1:FaultsLat-I') != 0:
					# # print(f'PSC1 CH1 Sum Fault resetting...')
					# # caput('lab{1}Chan1:FaultClear-SP', 1)
					# # print(f'PSC1 CH1 Sum Fault finished reset!')
				# # if caget('lab{1}Chan2:FaultsLat-I') != 0:
					# # print(f'PSC1 CH2 Sum Fault resetting...')
					# # caput('lab{1}Chan2:FaultClear-SP', 1)
					# # print(f'PSC1 CH2 Sum Fault finished reset!')
				# # if caget('lab{1}Chan3:FaultsLat-I') != 0:
					# # print(f'PSC1 CH3 Sum Fault resetting...')
					# # caput('lab{1}Chan3:FaultClear-SP', 1)
					# # print(f'PSC1 CH3 Sum Fault finished reset!')
				# # if caget('lab{1}Chan4:FaultsLat-I') != 0:
					# # print(f'PSC1 CH4 Sum Fault resetting...')
					# # caput('lab{1}Chan4:FaultClear-SP', 1)
					# # print(f'PSC1 CH4 Sum Fault finished reset!')
					
				# # if caget('lab{2}Chan1:FaultsLat-I') != 0:
					# # print(f'PSC2 CH1 Sum Fault resetting...')
					# # caput('lab{2}Chan1:FaultClear-SP', 1)
					# # print(f'PSC2 CH1 Sum Fault finished reset!')
				# # if caget('lab{2}Chan2:FaultsLat-I') != 0:
					# # print(f'PSC2 CH2 Sum Fault resetting...')
					# # caput('lab{2}Chan2:FaultClear-SP', 1)
					# # print(f'PSC2 CH2 Sum Fault finished reset!')
				# # if caget('lab{2}Chan3:FaultsLat-I') != 0:
					# # print(f'PSC2 CH3 Sum Fault resetting...')
					# # caput('lab{2}Chan3:FaultClear-SP', 1)
					# # print(f'PSC2 CH3 Sum Fault finished reset!')
				
				# # print('Finished resetting latched faults!')
			# last_value = curr_value
			# print(f'  curr_value: {curr_value}, last_value: {last_value}')
			# print('Sleeping...')
			# time.sleep(3)
			
			
			#curr_value = int(caget('lab{1}Chan1:FltTrigActive-I'))
			# Comment out for weekend with forced fault condition
			# curr_value = int(caget('lab{1}Chan1:FaultsLat-I.B7')) | int(caget('lab{1}Chan1:FaultsLive-I.B8'))
			curr_ac_flt = int(caget('lab{1}Chan1:FaultsLive-I.B8'))
			if curr_ac_flt not in(0, 1):
				continue
			if curr_ac_flt == 1 and last_ac_flt == 0:
				print('Rising edge for AC flt!')
				print('Calling PSC1 and PSC2 Function')
				save_ss1()
				save_ss2()
			elif curr_ac_flt == 0 and last_ac_flt == 1:
				print('Falling edge for AC flt')
			
			# PS Flt Det
			curr_ps_flt = int(caget('lab{1}Chan1:FaultsLat-I.B7'))
			if curr_ps_flt not in(0, 1):
				continue
			if curr_ps_flt == 1 and last_ps_flt == 0:
				print('Rising edge for PS flt!')
				print('Calling PSC1 Function')
				save_ss1()
			elif curr_ps_flt == 0 and last_ps_flt == 1:
				print('Falling edge for PS flt')
				# # last_value = curr_value
				# print('Resetting Latched Faults on zPSCs...')
				# time.sleep(1)
				# if caget('lab{1}Chan1:FaultsLat-I') != 0:
					# print(f'PSC1 CH1 Sum Fault resetting...')
					# caput('lab{1}Chan1:FaultClear-SP', 1)
					# print(f'PSC1 CH1 Sum Fault finished reset!')
				# if caget('lab{1}Chan2:FaultsLat-I') != 0:
					# print(f'PSC1 CH2 Sum Fault resetting...')
					# caput('lab{1}Chan2:FaultClear-SP', 1)
					# print(f'PSC1 CH2 Sum Fault finished reset!')
				# if caget('lab{1}Chan3:FaultsLat-I') != 0:
					# print(f'PSC1 CH3 Sum Fault resetting...')
					# caput('lab{1}Chan3:FaultClear-SP', 1)
					# print(f'PSC1 CH3 Sum Fault finished reset!')
				# if caget('lab{1}Chan4:FaultsLat-I') != 0:
					# print(f'PSC1 CH4 Sum Fault resetting...')
					# caput('lab{1}Chan4:FaultClear-SP', 1)
					# print(f'PSC1 CH4 Sum Fault finished reset!')
					
				# if caget('lab{2}Chan1:FaultsLat-I') != 0:
					# print(f'PSC2 CH1 Sum Fault resetting...')
					# caput('lab{2}Chan1:FaultClear-SP', 1)
					# print(f'PSC2 CH1 Sum Fault finished reset!')
				# if caget('lab{2}Chan2:FaultsLat-I') != 0:
					# print(f'PSC2 CH2 Sum Fault resetting...')
					# caput('lab{2}Chan2:FaultClear-SP', 1)
					# print(f'PSC2 CH2 Sum Fault finished reset!')
				# if caget('lab{2}Chan3:FaultsLat-I') != 0:
					# print(f'PSC2 CH3 Sum Fault resetting...')
					# caput('lab{2}Chan3:FaultClear-SP', 1)
					# print(f'PSC2 CH3 Sum Fault finished reset!')
				
				# print('Finished resetting latched faults!')
			#last_value = curr_value
			last_ac_flt = curr_ac_flt
			last_ps_flt = curr_ps_flt
			print(f'  curr_ac_flt: {curr_ac_flt}, last_ac_flt: {last_ac_flt}')
			print(f'  curr_ps_flt: {curr_ps_flt}, last_ps_flt: {last_ps_flt}')
			print('Sleeping...')
			time.sleep(3)
			
		except KeyboardInterrupt:
			print('\nKeyboard Interrupt Detected, ending program.')
			break
		except Exception as e:
			print(f'\nFound Exception "{e}". ')
			break
			
	
if __name__ == "__main__":
	main()

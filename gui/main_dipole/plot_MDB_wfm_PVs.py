import sys, time
import matplotlib
import matplotlib.pyplot as plt
import numpy as np
from scipy.signal import resample

filepath = '/home/psctester/ac_dips/'

try:
    wfm_file = sys.argv[1]
    #print (wfm_file)
except IndexError as e:
	print('User did not specify PV wfm file to plot!')
	wfm_file = input('wfm filename: ')
	
print(f'Processing {wfm_file} in directory {filepath}...')

# Get headers
with open(filepath+wfm_file, "r") as f:
    for _ in range(3):
        next(f)
    headers = next(f).strip().split(",")
# Get data
data = np.genfromtxt(filepath+wfm_file,delimiter=',',skip_header=4)

print(data[0:10], len(data), type(data))

x = np.arange(data.shape[0])

groups = [
    data[:, 0:3],   # PS1 currents
    data[:, 3:6],   # PS2 currents
    data[:, 6:9]    # Voltages
]

print(f'Len: {len(data)}, Type: {type(data)}')
print(f'{data}')


fs_in = 9961.722
fs_out = 9960

N_in = data.shape[0]

N_out = int(N_in * fs_out / fs_in)

# Resample all 9 columns at once
data_resampled = resample(data, N_out, axis=0)




N = len(data)
rms = np.zeros((N-200,9))
for j in range(9):
	for i in range(N-200):
		rms[i,j] = np.sqrt(np.mean(data_resampled[i:i+166,j]**2))
		#rms[i,j] = np.sqrt(np.mean(data[i:i+166,j]**2))

titles = ["PS1 Currents", "PS2 Currents", "Voltages"]
labels = [
    headers[0:3],
    headers[3:6],
    headers[6:9]
]

fig, axes = plt.subplots(3, 1, figsize=(10, 8), sharex=True)
print(f'RMS: {rms}')



for i, ax in enumerate(axes):
    for j in range(3):
        ax.plot(x, groups[i][:, j], label=labels[i][j])
        #ax.plot(x, rms[:, j], label=labels[i][j])
		
    
    ax.set_title(titles[i])
    ax.grid(True)
    ax.legend()
    
plt.figure(2)
plt.plot(rms[:, 7])

axes[-1].set_xlabel("#Point at 10kHZ")
plt.tight_layout()
plt.show()
	


# Program to generate fault plots based on snapshot data
# Michael Charumaneeroj & David Bergman

import sys, time
import matplotlib
import matplotlib.pyplot as plt
import numpy as np
from scipy.signal import resample

filepath = '/home/psctester/flts/'

try:
    wfm1_file = sys.argv[1]
    wfm2_file = sys.argv[2]
except IndexError as e:
	print('User did not specify PV wfm files to plot!')
	wfm1_file = input('PSC1 filename: ')
	wfm2_file = input('PSC2 filename: ')
print(f'Processing {wfm1_file}, {wfm2_file} in directory {filepath}...')

def load_wfm(filename):

    fullpath = filepath + filename
    with open(fullpath, "r") as f:

        for _ in range(3):
            next(f)

        headers = [
            h.strip()
            for h in next(f).split(",")
            if h.strip()
        ]
    data = np.genfromtxt(
        fullpath,
        delimiter=',',
        skip_header=4
    )
    print(f'{filename}')
    print(f'Headers : {len(headers)}')
    print(f'Data    : {data.shape}')

    signals = {}
    num_cols = min(len(headers), data.shape[1])

    for i in range(num_cols):
        signals[headers[i]] = data[:, i]

    return headers, data, signals

headers1, data1, psc1 = load_wfm(wfm1_file)
headers2, data2, psc2 = load_wfm(wfm2_file)


fs_in = 9961.722
fs_out = 9960

N_in = data2.shape[0]

N_out = int(N_in * fs_out / fs_in)

# Resample all 9 columns at once
data2_resampled = resample(data2, N_out, axis=0)
data1_resampled = resample(data1, N_out, axis=0)

# Optional resampled dictionaries
psc1_r = {}
psc2_r = {}

for i, header in enumerate(headers1):
    psc1_r[header] = data1_resampled[:, i]

for i, header in enumerate(headers2):
    psc2_r[header] = data2_resampled[:, i]

window = 166

rms = {}

for i, header in enumerate(headers2):

    values = data2_resampled[:, i]

    rms_values = np.zeros(len(values) - window)

    for j in range(len(values) - window):
        rms_values[j] = np.sqrt(
            np.mean(values[j:j+window]**2)
        )

    rms[header] = rms_values


# titles = ["PS1 Currents", "PS2 Currents", "Voltages"]
# fig, axes = plt.subplots(3, 1, figsize=(10, 8), sharex=True)

# for i, ax in enumerate(axes):
    # print(f'i: {i}, ax: {ax}')
    # for j in range(3):
        # ax.plot(x2, groups2[i][:, j], label=labels2[i][j])
        # print(f'groups2[i][:, j]: {groups2[i][:, j]}, label=labels2[i][j]: {labels2[i][j]}')
        # #ax.plot(x, rms[:, j], label=labels[i][j])
		
    
    # ax.set_title(titles[i])
    # ax.grid(True)
    # ax.legend()
    
# plt.figure(2)
# plt.plot(rms[:, 7])

# axes[-1].set_xlabel("#Point at 10kHZ")
# plt.tight_layout()
# plt.show()

fig, axes = plt.subplots(2, 1, figsize=(10, 8), sharex=True)

axes[0].plot(psc2["VAC Ph-AB"], label="Ph-AB")
axes[0].plot(psc2["VAC Ph-BC"], label="Ph-BC")
axes[0].plot(psc2["VAC Ph-AC"], label="Ph-AC")
axes[0].set_title("VAC")
axes[0].grid(True)
axes[0].legend()

axes[1].plot(rms["VAC Ph-AB"], label="Ph-AB")
axes[1].plot(rms["VAC Ph-BC"], label="Ph-BC")
axes[1].plot(rms["VAC Ph-AC"], label="Ph-AC")
axes[1].set_title("VRMS")
axes[1].grid(True)
axes[1].legend()

axes[1].set_xlabel("Samples")

plt.tight_layout()
# plt.show()



fig, axes = plt.subplots(2, 3, figsize=(20, 8), sharex=True)

axes[0,0].plot(psc2["VAC Ph-AB"], label="Ph-AB")
axes[0,0].plot(psc2["VAC Ph-BC"], label="Ph-BC")
axes[0,0].plot(psc2["VAC Ph-AC"], label="Ph-AC")
axes[0,0].set_title("VAC")
axes[0,0].grid(True)
axes[0,0].legend()

axes[1,0].plot(rms["VAC Ph-AB"], label="Ph-AB")
axes[1,0].plot(rms["VAC Ph-BC"], label="Ph-BC")
axes[1,0].plot(rms["VAC Ph-AC"], label="Ph-AC")
axes[1,0].set_title("VRMS")
axes[1,0].grid(True)
axes[1,0].legend()

axes[0,1].plot(psc2["IAC PS2 Ph-A"], label="Ph-A")
axes[0,1].plot(psc2["IAC PS2 Ph-B"], label="Ph-B")
axes[0,1].plot(psc2["IAC PS2 Ph-C"], label="Ph-C")
axes[0,1].set_title("PS2 IAC")
axes[0,1].grid(True)
axes[0,1].legend()

axes[1,1].plot(rms["IAC PS2 Ph-A"], label="Ph-A")
axes[1,1].plot(rms["IAC PS2 Ph-B"], label="Ph-B")
axes[1,1].plot(rms["IAC PS2 Ph-C"], label="Ph-C")
axes[1,1].set_title("PS2 IRMS")
axes[1,1].grid(True)
axes[1,1].legend()

axes[0,2].plot(psc2["IAC PS1 Ph-A"], label="Ph-A")
axes[0,2].plot(psc2["IAC PS1 Ph-B"], label="Ph-B")
axes[0,2].plot(psc2["IAC PS1 Ph-C"], label="Ph-C")
axes[0,2].set_title("PS1 IAC")
axes[0,2].grid(True)
axes[0,2].legend()

axes[1,2].plot(rms["IAC PS1 Ph-A"], label="Ph-A")
axes[1,2].plot(rms["IAC PS1 Ph-B"], label="Ph-B")
axes[1,2].plot(rms["IAC PS1 Ph-C"], label="Ph-C")
axes[1,2].set_title("PS1 IRMS")
axes[1,2].grid(True)
axes[1,2].legend()

fig, axes = plt.subplots(2, 3, figsize=(20, 8), sharex=True)

plt.tight_layout()
plt.show()


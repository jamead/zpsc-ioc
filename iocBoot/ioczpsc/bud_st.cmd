#!../../bin/linux-x86_64/zpsc
##!./bin/linux-x86_64/zpsc

#- You may have to change zpsc to something else
#- everywhere it appears in this file

< envPaths

epicsEnvSet("IOCNAME", "lab")

# PSC IP address
epicsEnvSet("PSC1_IP", "192.168.0.11"); 
epicsEnvSet("PSC2_IP", "192.168.0.12"); 


epicsEnvSet("BLEN",100000);        # Snapshot DMA Length

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/zpsc.dbd"
dbLoadDatabase("dbd/seq.dbd")

zpsc_registerRecordDeviceDriver pdbbase

## Load record instances for PSC1
dbLoadRecords("db/lstats.db", "P=$(IOCNAME), NO=1")
dbLoadRecords("db/status10hz.db", "P=$(IOCNAME), NO=1, OFFSET=100, BUFLEN=$(BLEN)")
dbLoadRecords("db/control_glob.db", "P=$(IOCNAME), NO=1")
dbLoadRecords("db/control_chan.db", "P=$(IOCNAME), NO=1, CHAN=1")
dbLoadRecords("db/control_chan.db", "P=$(IOCNAME), NO=1, CHAN=2")
dbLoadRecords("db/control_chan.db", "P=$(IOCNAME), NO=1, CHAN=3")
dbLoadRecords("db/control_chan.db", "P=$(IOCNAME), NO=1, CHAN=4")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=1, TYPE=USR, CHAN=1, MSGID=60, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=1, TYPE=USR, CHAN=2, MSGID=61, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=1, TYPE=USR, CHAN=3, MSGID=62, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=1, TYPE=USR, CHAN=4, MSGID=63, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=1, TYPE=FLT, CHAN=1, MSGID=70, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=1, TYPE=FLT, CHAN=2, MSGID=71, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=1, TYPE=FLT, CHAN=3, MSGID=72, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=1, TYPE=FLT, CHAN=4, MSGID=73, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=1, TYPE=ERR, CHAN=1, MSGID=80, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=1, TYPE=ERR, CHAN=2, MSGID=81, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=1, TYPE=ERR, CHAN=3, MSGID=82, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=1, TYPE=ERR, CHAN=4, MSGID=83, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=1, TYPE=INJ, CHAN=1, MSGID=90, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=1, TYPE=INJ, CHAN=2, MSGID=91, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=1, TYPE=INJ, CHAN=3, MSGID=92, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=1, TYPE=INJ, CHAN=4, MSGID=93, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=1, TYPE=EVR, CHAN=1, MSGID=100, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=1, TYPE=EVR, CHAN=2, MSGID=101, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=1, TYPE=EVR, CHAN=3, MSGID=102, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=1, TYPE=EVR, CHAN=4, MSGID=103, BUFLEN=$(BLEN)")
dbLoadRecords("db/wfmstats.db", "P=$(IOCNAME), PSC=1")
#dbLoadRecords("db/asub_test.db")

## Load record instances for PSC2
dbLoadRecords("db/lstats.db", "P=$(IOCNAME), NO=2")
dbLoadRecords("db/status10hz.db", "P=$(IOCNAME), NO=2, OFFSET=100, BUFLEN=$(BLEN)")
dbLoadRecords("db/control_glob.db", "P=$(IOCNAME), NO=2")
dbLoadRecords("db/control_chan.db", "P=$(IOCNAME), NO=2, CHAN=1")
dbLoadRecords("db/control_chan.db", "P=$(IOCNAME), NO=2, CHAN=2")
dbLoadRecords("db/control_chan.db", "P=$(IOCNAME), NO=2, CHAN=3")
dbLoadRecords("db/control_chan.db", "P=$(IOCNAME), NO=2, CHAN=4")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=2, TYPE=USR, CHAN=1, MSGID=60, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=2, TYPE=USR, CHAN=2, MSGID=61, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=2, TYPE=USR, CHAN=3, MSGID=62, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=2, TYPE=USR, CHAN=4, MSGID=63, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=2, TYPE=FLT, CHAN=1, MSGID=70, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=2, TYPE=FLT, CHAN=2, MSGID=71, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=2, TYPE=FLT, CHAN=3, MSGID=72, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=2, TYPE=FLT, CHAN=4, MSGID=73, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=2, TYPE=ERR, CHAN=1, MSGID=80, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=2, TYPE=ERR, CHAN=2, MSGID=81, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=2, TYPE=ERR, CHAN=3, MSGID=82, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=2, TYPE=ERR, CHAN=4, MSGID=83, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=2, TYPE=INJ, CHAN=1, MSGID=90, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=2, TYPE=INJ, CHAN=2, MSGID=91, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=2, TYPE=INJ, CHAN=3, MSGID=92, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=2, TYPE=INJ, CHAN=4, MSGID=93, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=2, TYPE=EVR, CHAN=1, MSGID=100, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=2, TYPE=EVR, CHAN=2, MSGID=101, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=2, TYPE=EVR, CHAN=3, MSGID=102, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=2, TYPE=EVR, CHAN=4, MSGID=103, BUFLEN=$(BLEN)")
dbLoadRecords("db/wfmstats.db", "P=$(IOCNAME), PSC=2")
#dbLoadRecords("db/asub_test.db")

## Load record instances for PSC3
dbLoadRecords("db/lstats.db", "P=$(IOCNAME), NO=3")
dbLoadRecords("db/status10hz.db", "P=$(IOCNAME), NO=3, OFFSET=100, BUFLEN=$(BLEN)")
dbLoadRecords("db/control_glob.db", "P=$(IOCNAME), NO=3")
dbLoadRecords("db/control_chan.db", "P=$(IOCNAME), NO=3, CHAN=1")
dbLoadRecords("db/control_chan.db", "P=$(IOCNAME), NO=3, CHAN=2")
dbLoadRecords("db/control_chan.db", "P=$(IOCNAME), NO=3, CHAN=3")
dbLoadRecords("db/control_chan.db", "P=$(IOCNAME), NO=3, CHAN=4")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=3, TYPE=USR, CHAN=1, MSGID=60, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=3, TYPE=USR, CHAN=2, MSGID=61, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=3, TYPE=USR, CHAN=3, MSGID=62, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=3, TYPE=USR, CHAN=4, MSGID=63, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=3, TYPE=FLT, CHAN=1, MSGID=70, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=3, TYPE=FLT, CHAN=2, MSGID=71, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=3, TYPE=FLT, CHAN=3, MSGID=72, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=3, TYPE=FLT, CHAN=4, MSGID=73, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=3, TYPE=ERR, CHAN=1, MSGID=80, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=3, TYPE=ERR, CHAN=2, MSGID=81, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=3, TYPE=ERR, CHAN=3, MSGID=82, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=3, TYPE=ERR, CHAN=4, MSGID=83, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=3, TYPE=INJ, CHAN=1, MSGID=90, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=3, TYPE=INJ, CHAN=2, MSGID=91, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=3, TYPE=INJ, CHAN=3, MSGID=92, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=3, TYPE=INJ, CHAN=4, MSGID=93, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=3, TYPE=EVR, CHAN=1, MSGID=100, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=3, TYPE=EVR, CHAN=2, MSGID=101, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=3, TYPE=EVR, CHAN=3, MSGID=102, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=3, TYPE=EVR, CHAN=4, MSGID=103, BUFLEN=$(BLEN)")
dbLoadRecords("db/wfmstats.db", "P=$(IOCNAME), PSC=3")
#dbLoadRecords("db/asub_test.db")

## Load record instances for PSC4
dbLoadRecords("db/lstats.db", "P=$(IOCNAME), NO=4")
dbLoadRecords("db/status10hz.db", "P=$(IOCNAME), NO=4, OFFSET=100, BUFLEN=$(BLEN)")
dbLoadRecords("db/control_glob.db", "P=$(IOCNAME), NO=4")
dbLoadRecords("db/control_chan.db", "P=$(IOCNAME), NO=4, CHAN=1")
dbLoadRecords("db/control_chan.db", "P=$(IOCNAME), NO=4, CHAN=2")
dbLoadRecords("db/control_chan.db", "P=$(IOCNAME), NO=4, CHAN=3")
dbLoadRecords("db/control_chan.db", "P=$(IOCNAME), NO=4, CHAN=4")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=4, TYPE=USR, CHAN=1, MSGID=60, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=4, TYPE=USR, CHAN=2, MSGID=61, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=4, TYPE=USR, CHAN=3, MSGID=62, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=4, TYPE=USR, CHAN=4, MSGID=63, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=4, TYPE=FLT, CHAN=1, MSGID=70, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=4, TYPE=FLT, CHAN=2, MSGID=71, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=4, TYPE=FLT, CHAN=3, MSGID=72, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=4, TYPE=FLT, CHAN=4, MSGID=73, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=4, TYPE=ERR, CHAN=1, MSGID=80, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=4, TYPE=ERR, CHAN=2, MSGID=81, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=4, TYPE=ERR, CHAN=3, MSGID=82, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=4, TYPE=ERR, CHAN=4, MSGID=83, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=4, TYPE=INJ, CHAN=1, MSGID=90, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=4, TYPE=INJ, CHAN=2, MSGID=91, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=4, TYPE=INJ, CHAN=3, MSGID=92, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=4, TYPE=INJ, CHAN=4, MSGID=93, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=4, TYPE=EVR, CHAN=1, MSGID=100, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=4, TYPE=EVR, CHAN=2, MSGID=101, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=4, TYPE=EVR, CHAN=3, MSGID=102, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=4, TYPE=EVR, CHAN=4, MSGID=103, BUFLEN=$(BLEN)")
dbLoadRecords("db/wfmstats.db", "P=$(IOCNAME), PSC=4")
#dbLoadRecords("db/asub_test.db")

## Load record instances for PSC5
dbLoadRecords("db/lstats.db", "P=$(IOCNAME), NO=5")
dbLoadRecords("db/status10hz.db", "P=$(IOCNAME), NO=5, OFFSET=100, BUFLEN=$(BLEN)")
dbLoadRecords("db/control_glob.db", "P=$(IOCNAME), NO=5")
dbLoadRecords("db/control_chan.db", "P=$(IOCNAME), NO=5, CHAN=1")
dbLoadRecords("db/control_chan.db", "P=$(IOCNAME), NO=5, CHAN=2")
dbLoadRecords("db/control_chan.db", "P=$(IOCNAME), NO=5, CHAN=3")
dbLoadRecords("db/control_chan.db", "P=$(IOCNAME), NO=5, CHAN=4")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=5, TYPE=USR, CHAN=1, MSGID=60, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=5, TYPE=USR, CHAN=2, MSGID=61, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=5, TYPE=USR, CHAN=3, MSGID=62, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=5, TYPE=USR, CHAN=4, MSGID=63, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=5, TYPE=FLT, CHAN=1, MSGID=70, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=5, TYPE=FLT, CHAN=2, MSGID=71, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=5, TYPE=FLT, CHAN=3, MSGID=72, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=5, TYPE=FLT, CHAN=4, MSGID=73, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=5, TYPE=ERR, CHAN=1, MSGID=80, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=5, TYPE=ERR, CHAN=2, MSGID=81, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=5, TYPE=ERR, CHAN=3, MSGID=82, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=5, TYPE=ERR, CHAN=4, MSGID=83, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=5, TYPE=INJ, CHAN=1, MSGID=90, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=5, TYPE=INJ, CHAN=2, MSGID=91, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=5, TYPE=INJ, CHAN=3, MSGID=92, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=5, TYPE=INJ, CHAN=4, MSGID=93, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=5, TYPE=EVR, CHAN=1, MSGID=100, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=5, TYPE=EVR, CHAN=2, MSGID=101, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=5, TYPE=EVR, CHAN=3, MSGID=102, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=5, TYPE=EVR, CHAN=4, MSGID=103, BUFLEN=$(BLEN)")
dbLoadRecords("db/wfmstats.db", "P=$(IOCNAME), PSC=5")
#dbLoadRecords("db/asub_test.db")

## Load record instances for PSC6
dbLoadRecords("db/lstats.db", "P=$(IOCNAME), NO=6")
dbLoadRecords("db/status10hz.db", "P=$(IOCNAME), NO=6, OFFSET=100, BUFLEN=$(BLEN)")
dbLoadRecords("db/control_glob.db", "P=$(IOCNAME), NO=6")
dbLoadRecords("db/control_chan.db", "P=$(IOCNAME), NO=6, CHAN=1")
dbLoadRecords("db/control_chan.db", "P=$(IOCNAME), NO=6, CHAN=2")
dbLoadRecords("db/control_chan.db", "P=$(IOCNAME), NO=6, CHAN=3")
dbLoadRecords("db/control_chan.db", "P=$(IOCNAME), NO=6, CHAN=4")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=6, TYPE=USR, CHAN=1, MSGID=60, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=6, TYPE=USR, CHAN=2, MSGID=61, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=6, TYPE=USR, CHAN=3, MSGID=62, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=6, TYPE=USR, CHAN=4, MSGID=63, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=6, TYPE=FLT, CHAN=1, MSGID=70, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=6, TYPE=FLT, CHAN=2, MSGID=71, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=6, TYPE=FLT, CHAN=3, MSGID=72, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=6, TYPE=FLT, CHAN=4, MSGID=73, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=6, TYPE=ERR, CHAN=1, MSGID=80, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=6, TYPE=ERR, CHAN=2, MSGID=81, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=6, TYPE=ERR, CHAN=3, MSGID=82, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=6, TYPE=ERR, CHAN=4, MSGID=83, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=6, TYPE=INJ, CHAN=1, MSGID=90, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=6, TYPE=INJ, CHAN=2, MSGID=91, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=6, TYPE=INJ, CHAN=3, MSGID=92, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=6, TYPE=INJ, CHAN=4, MSGID=93, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=6, TYPE=EVR, CHAN=1, MSGID=100, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=6, TYPE=EVR, CHAN=2, MSGID=101, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=6, TYPE=EVR, CHAN=3, MSGID=102, BUFLEN=$(BLEN)")
dbLoadRecords("db/snapshots.db", "P=$(IOCNAME), NO=6, TYPE=EVR, CHAN=4, MSGID=103, BUFLEN=$(BLEN)")
dbLoadRecords("db/wfmstats.db", "P=$(IOCNAME), PSC=6")
#dbLoadRecords("db/asub_test.db")





var(PSCDebug, 2)	#5 full debug

#psc1 Create the PSC
createPSC("PSC1", $(PSC1_IP), 3000, 0)
createPSC("PSC2", $(PSC2_IP), 3000, 0)
createPSC("PSC3", $(PSC3_IP), 3000, 0)
createPSC("PSC4", $(PSC4_IP), 3000, 0)
createPSC("PSC5", $(PSC5_IP), 3000, 0)
createPSC("PSC6", $(PSC6_IP), 3000, 0)



cd "${TOP}/iocBoot/${IOC}"
iocInit

## Start any sequence programs

#For Back-Up Dipole
seq bud_fsm,"M0=lab{1},M1=Chan1"

#Initialization
epicsThreadSleep(8.0)
#Lab1 Channel 1
dbpf lab{1}Chan1:FaultMask:B12-SP 0
dbpf lab{1}Chan1:FaultMask:B11-SP 0
dbpf lab{1}Chan1:FaultMask:B10-SP 1
dbpf lab{1}Chan1:FaultMask:B9-SP 1
dbpf lab{1}Chan1:FaultMask:B8-SP 1
dbpf lab{1}Chan1:FaultMask:B7-SP 1
dbpf lab{1}Chan1:FaultMask:B6-SP 1
dbpf lab{1}Chan1:FaultMask:B5-SP 1
dbpf lab{1}Chan1:FaultMask:B4-SP 1
dbpf lab{1}Chan1:FaultMask:B3-SP 1
dbpf lab{1}Chan1:FaultMask:B2-SP 1
dbpf lab{1}Chan1:FaultMask:B1-SP 1
dbpf lab{1}Chan1:FaultMask:B0-SP 1
#Lab1 Channel 2
dbpf lab{1}Chan2:FaultMask:B12-SP 0
dbpf lab{1}Chan2:FaultMask:B11-SP 0
dbpf lab{1}Chan2:FaultMask:B10-SP 0
dbpf lab{1}Chan2:FaultMask:B9-SP 0
dbpf lab{1}Chan2:FaultMask:B8-SP 0
dbpf lab{1}Chan2:FaultMask:B7-SP 1
dbpf lab{1}Chan2:FaultMask:B6-SP 0
dbpf lab{1}Chan2:FaultMask:B5-SP 1
dbpf lab{1}Chan2:FaultMask:B4-SP 1
dbpf lab{1}Chan2:FaultMask:B3-SP 1
dbpf lab{1}Chan2:FaultMask:B2-SP 0
dbpf lab{1}Chan2:FaultMask:B1-SP 0
dbpf lab{1}Chan2:FaultMask:B0-SP 1
#Lab1 Channel 3
dbpf lab{1}Chan3:FaultMask:B12-SP 0
dbpf lab{1}Chan3:FaultMask:B11-SP 0
dbpf lab{1}Chan3:FaultMask:B10-SP 0
dbpf lab{1}Chan3:FaultMask:B9-SP 0
dbpf lab{1}Chan3:FaultMask:B8-SP 0
dbpf lab{1}Chan3:FaultMask:B7-SP 1
dbpf lab{1}Chan3:FaultMask:B6-SP 0
dbpf lab{1}Chan3:FaultMask:B5-SP 1
dbpf lab{1}Chan3:FaultMask:B4-SP 1
dbpf lab{1}Chan3:FaultMask:B3-SP 1
dbpf lab{1}Chan3:FaultMask:B2-SP 0
dbpf lab{1}Chan3:FaultMask:B1-SP 0
dbpf lab{1}Chan3:FaultMask:B0-SP 1
#Lab1 Channel 4
dbpf lab{1}Chan4:FaultMask:B12-SP 0
dbpf lab{1}Chan4:FaultMask:B11-SP 0
dbpf lab{1}Chan4:FaultMask:B10-SP 0
dbpf lab{1}Chan4:FaultMask:B9-SP 0
dbpf lab{1}Chan4:FaultMask:B8-SP 0
dbpf lab{1}Chan4:FaultMask:B7-SP 1
dbpf lab{1}Chan4:FaultMask:B6-SP 0
dbpf lab{1}Chan4:FaultMask:B5-SP 1
dbpf lab{1}Chan4:FaultMask:B4-SP 1
dbpf lab{1}Chan4:FaultMask:B3-SP 1
dbpf lab{1}Chan4:FaultMask:B2-SP 0
dbpf lab{1}Chan4:FaultMask:B1-SP 0
dbpf lab{1}Chan4:FaultMask:B0-SP 1

#Lab2 Channel 1
dbpf lab{2}Chan1:FaultMask:B12-SP 0
dbpf lab{2}Chan1:FaultMask:B11-SP 0
dbpf lab{2}Chan1:FaultMask:B10-SP 0
dbpf lab{2}Chan1:FaultMask:B9-SP 0
dbpf lab{2}Chan1:FaultMask:B8-SP 0
dbpf lab{2}Chan1:FaultMask:B7-SP 1
dbpf lab{2}Chan1:FaultMask:B6-SP 0
dbpf lab{2}Chan1:FaultMask:B5-SP 0
dbpf lab{2}Chan1:FaultMask:B4-SP 0
dbpf lab{2}Chan1:FaultMask:B3-SP 0
dbpf lab{2}Chan1:FaultMask:B2-SP 0
dbpf lab{2}Chan1:FaultMask:B1-SP 0
dbpf lab{2}Chan1:FaultMask:B0-SP 0

#Lab2 Channel 2
dbpf lab{2}Chan2:FaultMask:B12-SP 0
dbpf lab{2}Chan2:FaultMask:B11-SP 0
dbpf lab{2}Chan2:FaultMask:B10-SP 0
dbpf lab{2}Chan2:FaultMask:B9-SP 0
dbpf lab{2}Chan2:FaultMask:B8-SP 0
dbpf lab{2}Chan2:FaultMask:B7-SP 1
dbpf lab{2}Chan2:FaultMask:B6-SP 0
dbpf lab{2}Chan2:FaultMask:B5-SP 0
dbpf lab{2}Chan2:FaultMask:B4-SP 0
dbpf lab{2}Chan2:FaultMask:B3-SP 0
dbpf lab{2}Chan2:FaultMask:B2-SP 0
dbpf lab{2}Chan2:FaultMask:B1-SP 0
dbpf lab{2}Chan2:FaultMask:B0-SP 0

#Lab2 Channel 3
dbpf lab{2}Chan3:FaultMask:B12-SP 0
dbpf lab{2}Chan3:FaultMask:B11-SP 0
dbpf lab{2}Chan3:FaultMask:B10-SP 0
dbpf lab{2}Chan3:FaultMask:B9-SP 0
dbpf lab{2}Chan3:FaultMask:B8-SP 0
dbpf lab{2}Chan3:FaultMask:B7-SP 1
dbpf lab{2}Chan3:FaultMask:B6-SP 0
dbpf lab{2}Chan3:FaultMask:B5-SP 0
dbpf lab{2}Chan3:FaultMask:B4-SP 0
dbpf lab{2}Chan3:FaultMask:B3-SP 0
dbpf lab{2}Chan3:FaultMask:B2-SP 0
dbpf lab{2}Chan3:FaultMask:B1-SP 0
dbpf lab{2}Chan3:FaultMask:B0-SP 0

#Lab2 Channel 3
dbpf lab{2}Chan4:FaultMask:B12-SP 0
dbpf lab{2}Chan4:FaultMask:B11-SP 0
dbpf lab{2}Chan4:FaultMask:B10-SP 0
dbpf lab{2}Chan4:FaultMask:B9-SP 0
dbpf lab{2}Chan4:FaultMask:B8-SP 0
dbpf lab{2}Chan4:FaultMask:B7-SP 1
dbpf lab{2}Chan4:FaultMask:B6-SP 0
dbpf lab{2}Chan4:FaultMask:B5-SP 0
dbpf lab{2}Chan4:FaultMask:B4-SP 0
dbpf lab{2}Chan4:FaultMask:B3-SP 0
dbpf lab{2}Chan4:FaultMask:B2-SP 0
dbpf lab{2}Chan4:FaultMask:B1-SP 0
dbpf lab{2}Chan4:FaultMask:B0-SP 0

epicsThreadSleep(1.0)









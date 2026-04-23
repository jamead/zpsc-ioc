#!../../bin/linux-x86_64/zpsc

#- You may have to change zpsc to something else
#- everywhere it appears in this file

< envPaths

epicsEnvSet("IOCNAME", "lab")


#epicsEnvSet("EPICS_CAS_INTF_ADDR_LIST", "10.0.142.51")
#epicsEnvSet("EPICS_CAS_AUTO_ADDR_LIST", "NO")




# PSC IP address
epicsEnvSet("PSC1_IP", "192.168.0.11"); 

epicsEnvSet("BLEN",100000);        # Snapshot DMA Length

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/zpsc.dbd"
#dbLoadDatabase("dbd/seq.dbd")

zpsc_registerRecordDeviceDriver pdbbase



## Load record instances for PSC1
dbLoadRecords("db/lstats.db", "P=$(IOCNAME), NO=1")
dbLoadRecords("db/status10hz.db", "P=$(IOCNAME), NO=1, OFFSET=100, BUFLEN=10000")
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




var(PSCDebug, 2)	#5 full debug

#psc1 Create the PSC
createPSC("PSC1", $(PSC1_IP), 3000, 0)
setPSCSendBlockSize("PSC1", 1100, 512)

cd "${TOP}/iocBoot/${IOC}"
iocInit



## Start any sequence programs
seq ch_fsm,"M0=lab{1},M1=Chan1"
seq ch_fsm,"M0=lab{1},M1=Chan2"
seq ch_fsm,"M0=lab{1},M1=Chan3"
seq ch_fsm,"M0=lab{1},M1=Chan4"



epicsThreadSleep(1.0)


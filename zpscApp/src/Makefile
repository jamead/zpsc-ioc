TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

# Enable Sequencer support
#USR_SEQ = YES
#SNCFLAGS += +r
#zpsc_SNC_SRCS += reset_digout.st

#=============================
# Build the IOC application

PROD_IOC = zpsc
# zpsc.dbd will be created and installed
DBD += zpsc.dbd


# zpsc.dbd will be made up from these files:
zpsc_DBD += base.dbd

zpsc_DBD += ch_fsm.dbd
zpsc_DBD += bud_fsm.dbd


# Include dbd files from all support applications:
zpsc_DBD += pscCore.dbd
zpsc_DBD += scaleWaveform.dbd
zpsc_DBD += epoch2string.dbd
zpsc_DBD += devRollingBuf.dbd
zpsc_DBD += devRollingBuf_varlen.dbd
zpsc_DBD += readRampTable.dbd
zpsc_DBD += sumTwoFloats.dbd

# Add all the support libraries needed by this IOC
zpsc_LIBS += pscCore
#zpsc_LIBS += seq pv

# Add your custom C source here:
zpsc_SRCS += scaleWaveform.c  
zpsc_SRCS += epoch2string.c 
zpsc_SRCS += devRollingBuf.c
zpsc_SRCS += devRollingBuf_varlen.c
zpsc_SRCS += readRampTable.c
zpsc_SRCS += sumTwoFloats.c

# zpsc_registerRecordDeviceDriver.cpp derives from zpsc.dbd
zpsc_SRCS += zpsc_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
zpsc_SRCS_DEFAULT += zpscMain.cpp
zpsc_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#zpsc_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary
zpsc_SRCS += ch_fsm.st
zpsc_SRCS += bud_fsm.st


# Finally link to the EPICS Base libraries
zpsc_LIBS += $(EPICS_BASE_IOC_LIBS)
zpsc_LIBS += seq pv

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE


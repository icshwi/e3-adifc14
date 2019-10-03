###############################################################################
#
# System   : ADC3117 demo system
# Location : lab
#
###############################################################################

# location of the system (section-subsection)
# lab example
epicsEnvSet("RACKROW",                      "LAB-090Row")
epicsEnvSet("SECTION",                      "LAB-010")

# PBI device name (discipline-device-index)
epicsEnvSet("SLOT1",                        "Ctrl-CPU-002")
# system name (SECTION:SLOT)
epicsEnvSet("SYSTEM1",                      "$(SECTION):$(SLOT1)")
# Note: above values should come from ESS Naming service

# IF1410 device index (from the MTCA slot - see dmesg)
epicsEnvSet("ACQ_DEVID",                    "4")

# acquisition sub unit logical name
epicsEnvSet("ACQ_UNIT",                     "Ctrl-DAQ-002")

# maximum number of samples to acquire
# for ADC3117 4 channels, maximum is 4096
epicsEnvSet("ACQ_SAMPLES",                  "4096")

# EVR device PCI ID (from lspci)
epicsEnvSet("EVR_DEVID",                    "0b:00.0")

# EVR unit logical name (make compatible with E3-MRFIOC)
epicsEnvSet("EVR_DISDEV", "TS-EVR")
epicsEnvSet("EVR_INDEX",  "002")

# AUTOSAVE folder to store sav files
epicsEnvSet("AS_TOP", "$(E3_CMD_TOP)")

# Timestamp event code (14 for internal 14hz or 10 for external event)
epicsEnvSet("TSTAMPEVT", "14")

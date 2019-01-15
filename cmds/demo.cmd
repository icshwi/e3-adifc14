require asyn,4.33.0
require ADCore,3.3.2
require adifc14,develop

errlogInit(20000)

epicsEnvSet("EPICS_DB_INCLUDE_PATH",        "$(ADCORE)/db:$(ADIFC14)/db")
epicsEnvSet("EPICS_CA_MAX_ARRAY_BYTES",     "10000000")

epicsEnvSet("PREFIX",        "IFC1410DEMO:")
epicsEnvSet("PORT",          "IFC1410")
epicsEnvSet("ACQ_SAMPLES",   "4096")
epicsEnvSet("HOLD_SAMPLES",  "200")

epicsEnvSet("XSIZE",         "$(ACQ_SAMPLES)")
epicsEnvSet("YSIZE",         "1")
epicsEnvSet("TSPOINTS",      "$(HOLD_SAMPLES)")
epicsEnvSet("QSIZE",         "20")
epicsEnvSet("NCHANS",        "100")
epicsEnvSet("CBUFFS",        "500")
epicsEnvSet("MAX_THREADS",   "4")

# Create a IFC14xx driver
# ifc1400Configure(const char *portName, const int ifccard, const int fmc1,
#        int numSamples, int extraPorts, int maxBuffers, int maxMemory,
#        int priority, int stackSize)
ifc1400Configure("$(PORT)", 0, 1, $(ACQ_SAMPLES), 0, 0)

dbLoadRecords("ifc1400.template","P=$(PREFIX),R=,PORT=$(PORT),ADDR=0,TIMEOUT=1,MAX_SAMPLES=$(ACQ_SAMPLES),PREFIX=$(PREFIX),CH_GRP_ID=AI0")
#dbLoadRecords("asynRecord.db","P=$(PREFIX),R=asyn1,PORT=$(PORT),ADDR=0,OMAX=80,IMAX=80")

#asynSetTraceMask("$(PORT)",0,0x31)
asynSetTraceMask("$(PORT)",0,0)

iocInit()

asynSetTraceMask("$(PORT)",0,0)

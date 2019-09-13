require busy,1.7.0
require asyn,4.33.0
require ADCore,3.3.2
require adifc14,develop

errlogInit(20000)

#epicsEnvSet("EPICS_DB_INCLUDE_PATH",        "$(ADCORE)/db:$(ADIFC14)/db")
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


epicsEnvSet("AICH0",      "AI0")
epicsEnvSet("AICH1",      "AI1")
epicsEnvSet("AICH2",      "AI2")
epicsEnvSet("AICH3",      "AI3")
epicsEnvSet("AICH4",      "AI4")
epicsEnvSet("AICH5",      "AI5")
epicsEnvSet("AICH6",      "AI6")
epicsEnvSet("AICH7",      "AI7")
epicsEnvSet("AICH8",      "AI8")
epicsEnvSet("AICH9",      "AI9")


# Create a IFC14xx driver
# ifc1400Configure(const char *portName, const int ifccard, const int fmc1,
#        int numSamples, int extraPorts, int maxBuffers, int maxMemory,
#        int priority, int stackSize)
ifc1400Configure("$(PORT)", 0, 1, $(ACQ_SAMPLES), 0, 0)

dbLoadRecords("ifc1400.template","P=$(PREFIX),R=,PORT=$(PORT),ADDR=0,TIMEOUT=1,MAX_SAMPLES=$(ACQ_SAMPLES),PREFIX=$(PREFIX),CH_GRP_ID=AI0")
dbLoadRecords("asynRecord.db","P=$(PREFIX),R=asyn1,PORT=$(PORT),ADDR=0,OMAX=80,IMAX=80")

# Create a standard arrays plugin, set it to get data from SIS8300 driver.
NDStdArraysConfigure("Channel0", 3, 0, "$(PORT)", 0)
dbLoadRecords("NDStdArrays.template", "P=$(PREFIX),R=Channel0:,PORT=Channel0,ADDR=0,TIMEOUT=1,NDARRAY_PORT=$(PORT),TYPE=Float64,FTVL=DOUBLE,NELEMENTS=$(ACQ_SAMPLES)")

NDStdArraysConfigure("Channel1", 3, 0, "$(PORT)", 1)
dbLoadRecords("NDStdArrays.template", "P=$(PREFIX),R=Channel1:,PORT=Channel1,ADDR=0,TIMEOUT=1,NDARRAY_PORT=$(PORT),TYPE=Float64,FTVL=DOUBLE,NELEMENTS=$(ACQ_SAMPLES)")




# Time series plugin for converted AI data
#NDTimeSeriesConfigure("TS0", $(QSIZE), 0, "$(PORT)", 0, 10)
#dbLoadRecords("NDTimeSeries.template",  "P=$(PREFIX),R=TS0:,   PORT=TS0,ADDR=0,TIMEOUT=1,NDARRAY_PORT=$(PORT),NDARRAY_ADDR=0,NCHANS=$(TSPOINTS),TIME_LINK=,ENABLED=1")
#dbLoadRecords("NDTimeSeriesN.template", "P=$(PREFIX),R=TS0:0:, PORT=TS0,ADDR=0,TIMEOUT=1,NCHANS=$(TSPOINTS),NAME=$(AICH0)")
#dbLoadRecords("NDTimeSeriesN.template", "P=$(PREFIX),R=TS0:1:, PORT=TS0,ADDR=1,TIMEOUT=1,NCHANS=$(TSPOINTS),NAME=$(AICH1)")
#dbLoadRecords("NDTimeSeriesN.template", "P=$(PREFIX),R=TS0:2:, PORT=TS0,ADDR=2,TIMEOUT=1,NCHANS=$(TSPOINTS),NAME=$(AICH2)")
#dbLoadRecords("NDTimeSeriesN.template", "P=$(PREFIX),R=TS0:3:, PORT=TS0,ADDR=3,TIMEOUT=1,NCHANS=$(TSPOINTS),NAME=$(AICH3)")
#dbLoadRecords("NDTimeSeriesN.template", "P=$(PREFIX),R=TS0:4:, PORT=TS0,ADDR=4,TIMEOUT=1,NCHANS=$(TSPOINTS),NAME=$(AICH4)")
#dbLoadRecords("NDTimeSeriesN.template", "P=$(PREFIX),R=TS0:5:, PORT=TS0,ADDR=5,TIMEOUT=1,NCHANS=$(TSPOINTS),NAME=$(AICH5)")
#dbLoadRecords("NDTimeSeriesN.template", "P=$(PREFIX),R=TS0:6:, PORT=TS0,ADDR=6,TIMEOUT=1,NCHANS=$(TSPOINTS),NAME=$(AICH6)")
#dbLoadRecords("NDTimeSeriesN.template", "P=$(PREFIX),R=TS0:7:, PORT=TS0,ADDR=7,TIMEOUT=1,NCHANS=$(TSPOINTS),NAME=$(AICH7)")
#dbLoadRecords("NDTimeSeriesN.template", "P=$(PREFIX),R=TS0:8:, PORT=TS0,ADDR=8,TIMEOUT=1,NCHANS=$(TSPOINTS),NAME=$(AICH8)")
#dbLoadRecords("NDTimeSeriesN.template", "P=$(PREFIX),R=TS0:9:, PORT=TS0,ADDR=9,TIMEOUT=1,NCHANS=$(TSPOINTS),NAME=$(AICH9)")


iocInit()

asynSetTraceMask("$(PORT)",0,0);


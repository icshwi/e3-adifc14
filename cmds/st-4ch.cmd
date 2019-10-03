########################################
#        IOC startup entry point       #
########################################

# Dynamic loading of the necessary modules
require busy,1.7.2
require asyn,4.33.0
require autosave,5.10.0
require iocStats,3.1.16
require ADCore,3.3.2

require mrfioc2,2.2.0-rc5
require nds3epics,1.0.0

require admisc,develop
require adifc14,develop

# instance.cmd defines all variables that differe between instances of this
# IOC. For example hardware IDs, Naming service names,..
iocshLoad("instance-4ch.cmd")

errlogInit(20000)

# EPICS_CA_MAX_ARRAY_BYTES: 10 MB max CA request
epicsEnvSet("EPICS_CA_MAX_ARRAY_BYTES",     "10000000")

# acquisition (SIS8300) setup
iocshLoad("$(adifc14_DIR)/acq-4ch.setup")

# timing (MRF EVR) setup
iocshLoad("$(adifc14_DIR)/evr.setup")

# autosave setup
iocshLoad("$(adifc14_DIR)/autosave.setup")

iocInit()

# comment out if no special need 
iocshLoad("acq.init")

# comment out if no EVR 
iocshLoad("$(adifc14_DIR)/evr_standalone.init")

# comment out if timestamping is not used 
iocshLoad("$(adifc14_DIR)/evr_timestamping.init")

# end initialization after iocBoot()
#
# IOC running!
#

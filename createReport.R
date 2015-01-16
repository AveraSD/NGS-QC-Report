########################################
# Next Generation Sequencing QC Report
# Runtime Script
#
# Original author:
# Tobias Meissner
#
# License:
# MIT
#
########################################
args <- commandArgs(TRUE)

rootDir <- args[0]
sampleID <- args[1]
sampleMeta <- args[2]

print(args)
Sweave('rnaseqqc_clia.Rnw')


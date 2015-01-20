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
args <- commandArgs(trailingOnly=TRUE)

rootDir <- args[1]
sampleID <- args[2]
sampleMeta <- args[3]

# Input files >> can be made commandline arguments if needed..
file1 <- paste(rootDir,'QC/',sampleID,'_1/',sampleID,'_1_fastqc.zip',sep='')
file2 <- paste(rootDir,'QC/',sampleID,'_2/',sampleID,'_2_fastqc.zip',sep='')
fileStar <- paste(rootDir,'star/',sampleID,'/Log.final.out',sep='')
file3 <- paste(rootDir,'QC/',sampleID,'/rnaseqmetrics',sep='')
file4 <- paste(rootDir,'QC/',sampleID,'/insertSize.txt',sep='')
fileHT <- paste(rootDir,'counts/',sampleID,'_counts.txt',sep='')
fileCLoci <- paste(rootDir, 'variants/', sampleID, '/callable_loci.txt', sep='')

# create tex file
Sweave('rnaseqqc_clia.Rnw')

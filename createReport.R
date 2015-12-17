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

# input arguments:
# 1: sampleID
# 2: DNA / RNA
# 3: rootDir
# 4: metainfo
# 5: base space access token

sampleID <- args[1]
type <- args[2]
rootDir <- args[3]
sampleMeta <- args[4]
accessToken <- args[5]

# Input files >> can be made commandline arguments if needed..
if(type=='DNA') {
  
}
if(type=='RNA') {
  fastqc1File <- paste(rootDir,'/fastqc/',sampleID, '/', sampleID,'_1_fastqc.zip',sep='')
  fastqc2File <- paste(rootDir,'/fastqc/',sampleID, '/', sampleID,'_2_fastqc.zip',sep='')
  starFile <- paste(rootDir,'/alignments/',sampleID,'/', sampleID, '_Log.final.out' ,sep='')
  qualimapFile <- paste(rootDir,'/qualimap/',sampleID,'/genome_results.txt',sep='')
  countsFile <- paste(rootDir,'/alignments/',sampleID,'/', sampleID, '_ReadsPerGene.out.tab' ,sep='')
}

# create tex file
Sweave('rnaseqqc_clia.Rnw')

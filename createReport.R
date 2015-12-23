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

patID <- args[1]
runnum <- args[2]
rootDir <- args[3]
sampleMeta <- args[4]
accessToken <- args[5]
bsi <- args[6]

# get all dna / rna data associate with this sample
sets <- c(
  paste0(patID,'-B',runnum,'-DNA'),
  paste0(patID,'-T',runnum,'-DNA'),
  paste0(patID,'-T',runnum,'-RNA')
)

#bsi data and sample meta info
library(yaml)
sample <- yaml.load_file(sampleMeta)[[patID]]
bsiData <- read.csv2(bsi, sep=',', stringsAsFactors=F, skip = 1)
bsi$ID <- paste0('CCD', gsub('01-', '', bsiData$Subject.ID))
bsiSample <- bsiData[match(patID, bsi$ID), ]

if(dir.exists(paste0(rootDir,'alignments/',sets[1]))) {
  sampleID <- sets[1]
  fastqc1File <- paste(rootDir,'/fastqc/',sampleID, '/', sampleID,'_1_fastqc.zip',sep='')
  fastqc2File <- paste(rootDir,'/fastqc/',sampleID, '/', sampleID,'_2_fastqc.zip',sep='')
  qualimapText <- paste(rootDir,'/qualimap/',sampleID,'/genome_results.txt',sep='')
  qualimapHTML <- paste(rootDir,'/qualimap/',sampleID,'/qualimapReport.html',sep='')
  
  # create tex file
  Sweave('dnaseqqc_clia.Rnw')
}
if(dir.exists(paste0(rootDir,'alignments/',sets[1]))) {
  sampleID <- sets[2]
  fastqc1File <- paste(rootDir,'/fastqc/',sampleID, '/', sampleID,'_1_fastqc.zip',sep='')
  fastqc2File <- paste(rootDir,'/fastqc/',sampleID, '/', sampleID,'_2_fastqc.zip',sep='')
  qualimapText <- paste(rootDir,'/qualimap/',sampleID,'/genome_results.txt',sep='')
  qualimapHTML <- paste(rootDir,'/qualimap/',sampleID,'/qualimapReport.html',sep='')
  
  # create tex file
  Sweave('dnaseqqc_clia.Rnw') 
}
if(dir.exists(paste0(rootDir,'alignments/',sets[1]))) {
  sampleID <- sets[3]
  fastqc1File <- paste(rootDir,'/fastqc/',sampleID, '/', sampleID,'_1_fastqc.zip',sep='')
  fastqc2File <- paste(rootDir,'/fastqc/',sampleID, '/', sampleID,'_2_fastqc.zip',sep='')
  starFile <- paste(rootDir,'/alignments/',sampleID,'/', sampleID, '_Log.final.out' ,sep='')
  qualimapText <- paste(rootDir,'/qualimap/',sampleID,'/genome_results.txt',sep='')
  qualimapHTML <- paste(rootDir,'/qualimap/',sampleID,'/qualimapReport.html',sep='')
  countsFile <- paste(rootDir,'/alignments/',sampleID,'/', sampleID, '_ReadsPerGene.out.tab' ,sep='')  
  
  # create tex file
  Sweave('rnaseqqc_clia.Rnw')
}


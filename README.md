# NGS-QC-Report

Creates a PDF-based NGS QC report for RNA-Seq and DNA-Seq.

## Input
### Required Input RNA-Seq:

* FastQC: .zip results folder
* STAR: Log.final.out
* PICARD: rnaseqmetrics & insert size
* HTSeq: count table
* CallableLoci: summary file
* .yaml config file

### Required Input DNA-Seq:
The DNA-Seq module is made to handle two types of similar input.

The First is a full run
* .bam - binary sequencing reads - requires proper header info
* .yaml - config file containing specific structured information regarding the sequencing run

The normal process is that QC tools will be run on the bam file to generate the metrics for the report along with the original .yaml file.

The Second is a modified run and the standard second step, using output from the tools
* .html - output from qualimap bamqc
* .sum - a summary file from the GATK tool DepthOfCoverage, run on a bam file and (optionally) a bed file

## How to run

Create the .tex file:

```
Rscript createReport.R --args $rootDataDir $sampleName $patientMeta.yaml
```

Create the PDF:

```
pdflatex -interaction=nonstopmode rnaseqqc_clia.tex
```




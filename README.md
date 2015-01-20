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

*
* .yaml config file

## How to run:

Create the .tex file:

```
Rscript createReport.R --args $rootDataDir $sampleName $patientMeta.yaml
```

Create the PDF:

```
pdflatex -interaction=nonstopmode rnaseqqc_clia.tex
```




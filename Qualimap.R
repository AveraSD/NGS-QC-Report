library(XML)
samples <- list.files("~/AWS/storage/patients/qualimap/")

parseCoverage <- function(coverage) {
  paste0(gsub("%", "", strsplit(as.character(coverage), " ")[[1]][9]), "%")
}

bamQCReport <- function(sample) {
  sample <- gsub("_", "-", sample)
  text <- paste("~/AWS/storage/patients/qualimap", sample, "genome_results.txt", sep="/")
  html <- paste("~/AWS/storage/patients/qualimap", sample, "qualimapReport.html", sep="/")
  text.df <- read.csv(text, sep="\t")
  totalReads <- as.numeric(gsub(",", "", strsplit(as.character(text.df[10,]), " = ")[[1]][2]))
  html.df <- readHTMLTable(html, header=TRUE)
  stats <- list(
    `Total Reads` = totalReads,
    `Duplication Rate` = paste0(as.character(round(100*(as.numeric(gsub(",", "", strsplit(as.character(text.df[15,]), " = ")[[1]][2]))/totalReads)), 2), "%"),
    `Mapped reads, both in pair` = strsplit(as.character(html.df[[4]][7,][[2]]), " / ")[[1]][2],
    `Mapped reads, both in pair, inside of regions` = strsplit(as.character(html.df[[5]][4,][[2]]), " / ")[[1]][2],
    `GC Content` = strsplit(as.character(text.df[28,]), " = ")[[1]][2],
    `Median Insert Size` = strsplit(as.character(text.df[19,]), " = ")[[1]][2],
    `Mean Coverage` = paste0(gsub("X", "", strsplit(as.character(text.df[38,]), " = ")[[1]][2]), "X"),
    `StdDev Coverage` = paste0(gsub("X", "", strsplit(as.character(text.df[39,]), " = ")[[1]][2]), "X"),
    `1X` = parseCoverage(text.df[40,]),
    `10X` = parseCoverage(text.df[49,]),
    `20X` = parseCoverage(text.df[59,]),
    `50X` = parseCoverage(text.df[89,]))
  cbind(Patient=substr(sample, 1, 6), Sample=sample, data.frame(stats, check.names=FALSE))
  
}

reports <- do.call(rbind, lapply(samples, bamQCReport))
write.table(reports, "Bam_QC_report.txt", sep="\t", row.names=FALSE, quote=FALSE)
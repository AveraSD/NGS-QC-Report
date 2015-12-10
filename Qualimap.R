samples <- list.files("~/AWS/storage/patients/alignments/qualimap/")

parseCoverage <- function(coverage) {
  paste0(gsub("%", "", strsplit(as.character(coverage), " ")[[1]][9]), "%")
}

bamQCReport <- function(sample) {
  sample <- gsub("_", "-", sample)
  report <- paste("~/AWS/storage/patients/alignments/qualimap", sample, "genome_results.txt", sep="/")
  q <- read.csv(report, sep="\t")
  totalReads <- as.numeric(gsub(",", "", strsplit(as.character(q[10,]), " = ")[[1]][2]))
  stats <- list(
    `Total Reads` = totalReads,
    `Duplication Rate` = paste0(as.character(round(100*(as.numeric(gsub(",", "", strsplit(as.character(q[15,]), " = ")[[1]][2]))/totalReads)), 2), "%"),
    `GC Content` = strsplit(as.character(q[28,]), " = ")[[1]][2],
    `Median Insert Size` = strsplit(as.character(q[19,]), " = ")[[1]][2],
    `Mean Coverage` = paste0(gsub("X", "", strsplit(as.character(q[38,]), " = ")[[1]][2]), "X"),
    `StdDev Coverage` = paste0(gsub("X", "", strsplit(as.character(q[39,]), " = ")[[1]][2]), "X"),
    `1X` = parseCoverage(q[40,]),
    `10X` = parseCoverage(q[49,]),
    `20X` = parseCoverage(q[59,]),
    `50X` = parseCoverage(q[89,]))
  cbind(Sample=sample, data.frame(stats, check.names=FALSE))
}

reports <- do.call(rbind, lapply(samples, bamQCReport))
write.table(reports, "Bam_QC_report.txt", sep="\t", row.names=FALSE, quote=FALSE)
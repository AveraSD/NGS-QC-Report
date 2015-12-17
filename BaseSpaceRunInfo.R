library(httr)
library(jsonlite)

getSampleReads <- function(URL, accessToken, seqStats) {
  headers <- c("x-access-token" = accessToken)
  res <- GET(URL, config=add_headers(headers))
  json <- httr::content(res, "text")
  reads <- fromJSON(json)$Response
  cbind(data.frame(`Total Reads` = reads$TotalReadsRaw,
                   `Sample` = gsub("_", "-", reads$SampleId), check.names=FALSE),
        seqStats)
}
getRunSummary <- function(runId, accessToken){
  headers <- c("x-access-token" = accessToken)
  apiServer <- "https://api.basespace.illumina.com/"
  URL <- paste(apiServer, "/v1pre3/runs/", runId, sep="")
  res <- GET(URL, config=add_headers(headers))
  json <- httr::content(res, "text")
  df <- fromJSON(json)$Response
  sample.ids <- df$Properties$Items$Items[[1]]$Id
  sampleURLS <- paste0(apiServer, "v1pre3/samples/", sample.ids)
  seqStats <- data.frame(`Name`=df$ExperimentName,
                         `Run Id`=runId,
                         `Date Started`=df$DateUploadStarted,
                         `Date Completed`=df$DateUploadCompleted,
                         `Yield`=df$SequencingStats$YieldTotal, 
                         `Percent Aligned`=df$SequencingStats$PercentAligned,
                         `Error Rate`=df$SequencingStats$ErrorRate,
                         `Percent Q30`=df$SequencingStats$PercentGtQ30,
                         check.names = FALSE)
  do.call(rbind, lapply(sampleURLS, getSampleReads, accessToken, seqStats))
}
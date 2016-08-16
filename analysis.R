## Scrape Sports-Reference for swimming data

# Environment settings
rm(list=ls())
setwd("~/projects/oly-swim")

# Libraries
lapply(c('rvest','dplyr','pipeR', 'data.table', 'plyr'), library, character.only = T)

# Functions
source("ScrapeSwim.R")

# Matrix of arguments
events <- read.csv("data/events.csv")

# mapply
results <- rbindlist(mapply(
  ScrapeSwim, events[,1], events[,2], events[,3], events[,4], events[,5], SIMPLIFY=FALSE))
write.csv(results, "data/results.csv")

# Analysis start
by.swim <- results[, tally(group_by(event, distance)), athlete]
by.swim.wide <- dcast(by.swim, athlete ~ x, value.var = "freq")

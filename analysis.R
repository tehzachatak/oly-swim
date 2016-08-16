# Scrape Sports-Reference for swimming data

# Environment
rm(list=ls()) # Clear
setwd("~/projects/oly-swim")

# Libraries
packages <- c('rvest','dplyr','pipeR', 'data.table', 'plyr')
lapply(packages, library, character.only = T)
rm("packages")

# Functions
source("ScrapeSwim.R")

# Matrix of arguments
events <- read.csv("data/events.csv")

# mapply
results <- rbindlist(mapply(ScrapeSwim, events[,1], events[,2], events[,3], events[,4], SIMPLIFY=FALSE))
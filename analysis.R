# Scrape Sports-Reference for swimming data
rm(list=ls())
# Environment
setwd("~/projects/oly-swim")

# Libraries
packages <- c('rvest','dplyr','pipeR', 'data.table')
lapply(packages, library, character.only = T)
rm("packages")

# Functions
source("ScrapeSwim.R")

# Mens 100 free
# Scrape (Should convert this to lapplys)
f1988 <- ScrapeSwim("1988", "mens", "100", "freestyle-final")
f1992 <- ScrapeSwim("1992", "mens", "100", "freestyle-final")
f1996 <- ScrapeSwim("1996", "mens", "100", "freestyle-final")
f2000 <- ScrapeSwim("2000", "mens", "100", "freestyle-final")
f2004 <- ScrapeSwim("2004", "mens", "100", "freestyle-final")
f2008 <- ScrapeSwim("2008", "mens", "100", "freestyle-final")
f2012 <- ScrapeSwim("2012", "mens", "100", "freestyle-final")
# Combine
m_100m_free_fin <- rbind(f1988, f1992, f1996, f2000, f2004, f2008, f2012)
# Clean up
rm(f1988, f1992, f1996, f2000, f2004, f2008, f2012)
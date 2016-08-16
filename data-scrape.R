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

# Scrape events
m_100m_1988_fin <- ScrapeSwim("1988", "mens", "100", "freestyle-final")
m_100m_1992_fin <- ScrapeSwim("1992", "mens", "100", "freestyle-final")

# Combine datasets
m_100m_fin <- rbind(m_100m_1988_fin, m_100m_1992_fin)
rm(m_100m_1988_fin, m_100m_1992_fin)
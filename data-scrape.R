# Scrape Sports-Reference for swimming data

# Libraries
packages <- c('rvest','dplyr','pipeR', 'data.table')
lapply(packages, library, character.only = T)
rm("packages")

# Scrape Function (Ugly)
ScrapeSwim <- function(year, event, distance, gender) {
  # Scrapes swimming data from Sports-Reference to usable form
  # e.g., 10.1 is replaced with 10.33
  #
  # Args:
  #   x: URL to scrape
  #   y: Cleaned object name
  # Returns:
  #   Cleaned object
  url <- paste0("http://www.sports-reference.com/olympics/summer/", year, 
                "/SWI/", gender, "-", distance, "-metres-", event, ".html")
  '.stats_table' -> css_page
  url %>>%
    read_html %>>%
    html_nodes(css_page) %>>%
    html_table(header = F) %>>%
    data.frame() %>>%
    tbl_df() -> total_table
  total_table %>>%
    filter(X1 == 'Rank') %>>% as.character -> names
  'Rank' %>>% grep(x = total_table$X1) -> row_of_header
  names %>>% tolower -> names(total_table)
  (row_of_header + 1) %>>% (total_table[.:nrow(total_table),]) -> total_table
}

# Scrape events
m_100m_1988_fin <- ScrapeSwim("1988", "freestyle-final", "100", "mens")
m_100m_1988_fin <- m_100m_1988_fin[1:6]
m_100m_1988_fin$year <- 1988
m_100m_1992_fin <- ScrapeSwim("1992", "freestyle-final", "100", "mens")
m_100m_1992_fin <- m_100m_1992_fin[1:6]
m_100m_1992_fin$year <- 1992
m_100m_1996_fin <- ScrapeSwim("1996", "freestyle-final", "100", "mens")
m_100m_1996_fin <- m_100m_1996_fin[1:6]
m_100m_1996_fin$year <- 1996
m_100m_2000_fin <- ScrapeSwim("2000", "freestyle-final", "100", "mens")
m_100m_2000_fin <- m_100m_2000_fin[1:6]
m_100m_2000_fin$year <- 2000
m_100m_2004_fin <- ScrapeSwim("2004", "freestyle-final", "100", "mens")
m_100m_2004_fin <- m_100m_2004_fin[1:6]
m_100m_2004_fin$year <- 2004
m_100m_2008_fin <- ScrapeSwim("2008", "freestyle-final", "100", "mens")
m_100m_2008_fin <- m_100m_2008_fin[1:6]
m_100m_2008_fin$year <- 2008
m_100m_2012_fin <- ScrapeSwim("2012", "freestyle-final", "100", "mens")
m_100m_2012_fin <- m_100m_2012_fin[1:6]
m_100m_2012_fin$year <- 2012
# Combine
m_100m_fin <- rbind(m_100m_1988_fin, m_100m_1992_fin, m_100m_1996_fin, 
                    m_100m_2000_fin, m_100m_2004_fin, m_100m_2008_fin,
                    m_100m_2012_fin)
rm(m_100m_1988_fin, m_100m_1992_fin, m_100m_1996_fin, 
    m_100m_2000_fin, m_100m_2004_fin, m_100m_2008_fin,
    m_100m_2012_fin)
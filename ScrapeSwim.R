# Scrape Function
ScrapeSwim <- function(year, gender, distance, event, round) {
  # Scrapes swimming data from Sports-Reference to usable form
  #
  # Args:
  #   year: year of event
  #   gender: mens or womens
  #   distance: distance of event (metres)
  #   event: event name
  #   round: event round
  # Returns:
  #   Cleaned table
  url <- paste0("http://www.sports-reference.com/olympics/summer/", year, 
                "/SWI/", gender, "-", distance, "-metres-", event, "-", round, ".html")
  '.stats_table' -> css_page
  url %>>%
    read_html %>>%
    html_nodes(css_page) %>>%
    html_table(header = F) %>>%
    data.frame() -> total_table
  total_table <- total_table[1:6]
  total_table %>>%
    filter(X1 == 'Rank') %>>% as.character -> names
  names[7:11] <- c("year", "gender", "event", "distance", "round")
  'Rank' %>>% grep(x = total_table$X1) -> row_of_header
  (row_of_header + 1) %>>% (total_table[.:nrow(total_table),]) -> total_table
  total_table[7] <- year
  total_table[8] <- gender
  total_table[9] <- event
  total_table[10] <- distance
  total_table[11] <- round
  names %>>% tolower -> names(total_table)
  setDT(total_table)
  return(total_table)
}
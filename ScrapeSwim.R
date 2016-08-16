# Scrape Function
ScrapeSwim <- function(year, gender, distance, event) {
  # Scrapes swimming data from Sports-Reference to usable form
  #
  # Args:
  #   gender: mens or womens
  #   event: event name
  #   year: year of event
  #   distance: distance of event (metres)
  # Returns:
  #   Cleaned table
  url <- paste0("http://www.sports-reference.com/olympics/summer/", year, 
                "/SWI/", gender, "-", distance, "-metres-", event, ".html")
  '.stats_table' -> css_page
  url %>>%
    read_html %>>%
    html_nodes(css_page) %>>%
    html_table(header = F) %>>%
    data.frame() %>>%
    tbl_df() -> total_table
  total_table <- total_table[1:6]
  total_table %>>%
    filter(X1 == 'Rank') %>>% as.character -> names
  names[7:10] <- c("gender", "year", "event", "distance")
  'Rank' %>>% grep(x = total_table$X1) -> row_of_header
  (row_of_header + 1) %>>% (total_table[.:nrow(total_table),]) -> total_table
  total_table[7] <- gender
  total_table[8] <- year
  total_table[9] <- event
  total_table[10] <- distance
  names %>>% tolower -> names(total_table)
  return(total_table)
}
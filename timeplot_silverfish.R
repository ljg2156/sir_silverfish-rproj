#' # Laurin Gagné
#' ## This script is loading and plotting silverfish data

#' # Load libraries
library("tibble")
library("foreign")
library("dplyr")
library("ggplot2")
library("googlesheets")
library("tidyverse")
 
#' # Load in googlesheets data / clean up file
silverfish_ws <- gs_title("silverfish_dat")
silverfish_dat <- gs_read(ss = silverfish_ws)
# only use ss, when put ws for some reason it says it doesn't exist. 
# maybe it's because there's only one sheet on that document?
silverfish_df <- as.data.frame(silverfish_dat)

silverfish_df <- silverfish_df %>%
  # cannot plot because dates are characters, must convert
  dplyr::mutate(date_formatted = as.Date(silverfish_df$date, "%m/%d/%Y")) %>%
  dplyr::group_by(date_formatted, num) %>%
  # when plotting, was only showing 1s, wasn't counting occurrences so need to also create new column with counts 
  dplyr::mutate(daily_count = n())

# create df with 0s for complete dates
full_dates <- seq(min(silverfish_df$date_formatted), max(silverfish_df$date_formatted), 
                  by = "1 day")
full_dates <- data.frame(date_formatted = full_dates,
                         # made everything nans, so have to figure out how to insert 0s
                         size = 0,
                         daily_count = 0)

## merge dfs 
full_sf_df <- full_join(silverfish_df, full_dates,
                          all.x = FALSE)

#' # Plot timecourse occurrences
ggplot(full_sf_df, aes(x = date_formatted, y = daily_count)) +
  geom_line()

#' # Plot timecourse occurrences w/ vertical lines for traps, DE in diff colors
ggplot(full_sf_df, aes(x = date_formatted, y = daily_count)) +
  geom_line() +
  geom_vline(xintercept = as.numeric(as.Date("0019-02-19")), color = "red")

#' # Plot timecourse occurrences w/ vertical lines for traps, DE in diff colors, and change mancer size based on bug size
ggplot(full_sf_df, aes(x = date_formatted, y = daily_count)) +
  geom_line() +
  ggtitle("Silverfish sightings in Halle's Office") +
  xlab("Date seen") +
  ylab("Daily count") +
  geom_vline(xintercept = as.numeric(as.Date("0019-02-19")), color = "red") +
  geom_text(aes(label = "Diatomaceous Earth placement"), x = as.numeric(as.Date("0019-02-17")), y = 1.5, angle = 90, text = element_text(size = 3))


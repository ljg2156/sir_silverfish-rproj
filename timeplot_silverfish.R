#' # Laurin Gagné
#' ## This script is loading and plotting silverfish data

#' # Load libraries
library("tibble")
library("foreign")
library("dplyr")
library("ggplot2")
library("googlesheets")
 
#' # Load in googlesheets data / clean up file
silverfish_ws <- gs_title("silverfish_dat")
silverfish_dat <- gs_read(ss = silverfish_ws)
# only use ss, when put ws for some reason it says it doesn't exist. 
# maybe it's because there's only one sheet on that document?
silverfish_df <- as.data.frame (silverfish_dat)

#' # Plot timecourse occurrences
ggplot(silverfish_dat, aes(x = "Date", y = "Size (according to pinky)")) +
  geom_line() +
  scale_x_date("%b-%Y") +
  scale_x_date(date_labels = "%d-%b-%Y")
  

#' # Plot timecourse occurrences w/ vertical lines for traps, DE in diff colors

#' # Plot timecourse occurrences w/ vertical lines for traps, DE in diff colors, and change mancer size based on bug size


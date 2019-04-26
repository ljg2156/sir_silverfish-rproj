#' # Laurin Gagné
#' ## This script is loading and plotting silverfish data

#' # Load libraries
library("tibble")
library("foreign")
library("dplyr")
library("ggplot2")
library("googlesheets")
 
#' # Load in googlesheets data
silverfish_ws <- gs_title("silverfish_dat")
silverfish_dat <- gs_read(ss = silverfish_ws)
silverfish_df <- as.data.frame (silverfish_dat)
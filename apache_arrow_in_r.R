# Apache Arrow in R workshop tutorial
# Last updated 2022-08-30

# Load packages ----

library(arrow)
library(here)

# Download and unzip the data ----

download.file(
  url = "https://github.com/djnavarro/arrow-user2022/releases/download/v0.1/nyc-taxi-tiny.zip",
  destfile = here::here("data/nyc-taxi-tiny.zip")
)

unzip(
  zipfile = here::here("data/nyc-taxi-tiny.zip"), 
  exdir = here::here("data")
)

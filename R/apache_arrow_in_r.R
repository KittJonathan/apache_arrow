# Apache Arrow in R workshop tutorial
# Last updated 2022-08-30

# Load packages ----

library(arrow)
library(dplyr)
library(dbplyr)
library(duckdb)
library(stringr)
library(lubridate)
library(palmerpenguins)
library(tictoc)
library(scales)
library(janitor)
library(fs)
library(here)
library(ggplot2)
library(ggrepel)
library(sf)

# Download and unzip the "tiny" data ----

download.file(
  url = "https://github.com/djnavarro/arrow-user2022/releases/download/v0.1/nyc-taxi-tiny.zip",
  destfile = here::here("data/nyc-taxi-tiny.zip")
)

unzip(
  zipfile = here::here("data/nyc-taxi-tiny.zip"), 
  exdir = here::here("data")
)

# The full NYC taxi data set ----

copy_files(
  from = s3_bucket("ursa-labs-taxi-data-v2"),
  to = "data/nyc-taxi"
)

download.file(
  url = "https://github.com/djnavarro/arrow-user2022/releases/download/v0.1/nyc-taxi-tiny.zip",
  destfile = here::here("data/nyc-taxi-tiny.zip")
)

unzip(
  zipfile = here::here("data/nyc-taxi-tiny.zip"), 
  exdir = here::here("data")
)

nyc_taxi <- open_dataset("data/nyc-taxi-tiny/")

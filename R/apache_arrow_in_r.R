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
# 
# download.file(
#   url = "https://github.com/djnavarro/arrow-user2022/releases/download/v0.1/nyc-taxi-tiny.zip",
#   destfile = here::here("data/nyc-taxi-tiny.zip")
# )
# 
# unzip(
#   zipfile = here::here("data/nyc-taxi-tiny.zip"), 
#   exdir = here::here("data")
# )
# 
# nyc_taxi <- open_dataset("data/nyc-taxi-tiny/")

# Import the tiny data set ----

nyc_taxi <- open_dataset("data/nyc-taxi-tiny/")
list.files("data/nyc-taxi-tiny/", recursive = TRUE)

zones <- read_csv_arrow("data/taxi_zone_lookup.csv")
zones

shapefile <- "data/taxi_zones/taxi_zones.shp"
shapedata <- read_sf(shapefile)

shapedata |>
  ggplot(aes(fill = LocationID)) +
  geom_sf(size = .1) +
  theme_bw() +
  theme(panel.grid = element_blank())

# Loading the data ----

nyc_taxi
nrow(nyc_taxi)

zone_counts <- nyc_taxi |>
  count(dropoff_location_id) |>
  arrange(desc(n)) |>
  collect()

zone_counts

tic()
nyc_taxi |>
  count(dropoff_location_id) |>
  arrange(desc(n)) |>
  collect() |>
  invisible()
toc()

left_join(
  x = shapedata, 
  y = zone_counts, 
  by = c("LocationID" = "dropoff_location_id")
) |> 
  ggplot(aes(fill = n)) + 
  geom_sf(size = .1) + 
  scale_fill_distiller(
    name = "Number of trips",
    limits = c(0, 17000000), 
    labels = label_comma(),
    direction = 1
  ) + 
  theme_bw() + 
  theme(panel.grid = element_blank())

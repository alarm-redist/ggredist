library(dplyr)
library(sf)
library(tigris)
library(stringr)
library(rmapshaper)

raw <- as_tibble(maps::us.cities)

raw$geometry <- st_as_sf(data.frame(X=raw$long, Y=raw$lat), coords=c("X", "Y")) %>%
  st_set_crs(4269) %>%
  pull(geometry)

cities <- transmute(raw,
                 name = str_trim(str_remove(name, country.etc)),
                 state = country.etc,
                 pop_2006 = pop,
                 capital = (capital == 2),
                 geometry = geometry) %>%
  st_as_sf()

usethis::use_data(cities, overwrite=TRUE, compress="xz")

library(alarmdata)
library(redist)
library(sf)
library(dplyr)
library(stringr)

or_map = alarm_50state_map("OR")

oregon = or_map %>%
  as_tibble() %>%
  st_as_sf() %>%
  filter(area_water / (area_land + area_water) < 0.95) %>%
  `attr<-`("analysis_name", NULL) %>%
  `attr<-`("pop_col", NULL) %>%
  `attr<-`("adj_col", NULL) %>%
  `attr<-`("existing_col", NULL) %>%
  `attr<-`("pop_bounds", NULL) %>%
  mutate(across(pop:pop_black, as.integer),
         tract = str_sub(GEOID, 3)) %>%
  select(GEOID, county, cd_2020, pop, pop_white, ndv, nrv, geometry) %>%
  rmapshaper::ms_simplify(keep=0.03, weighting=0.5, keep_shapes=TRUE)

usethis::use_data(oregon, overwrite = TRUE, compress="xz")

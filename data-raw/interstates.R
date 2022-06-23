library(dplyr)
library(sf)
library(tigris)
library(stringr)
library(rmapshaper)

roads <- primary_roads(2020) %>%
  filter(RTTYP=="I") %>%
  group_by(FULLNAME) %>%
  summarize(is_coverage=TRUE) %>%
  st_make_valid()

roads <- roads %>%
  mutate(FULLNAME = str_trim(str_to_upper(FULLNAME))) %>%
  filter(!str_ends(FULLNAME, "( E|W| N| S|HOV\\)?|LANES?\\)?|BUS| B|BYP|LP|TOLL)"),
         !str_starts(FULLNAME, "(E|W|N|S) "))

roads <- ms_simplify(roads, 0.0005)

interstates <- rename(roads, name=FULLNAME)

usethis::use_data(interstates, overwrite=TRUE, compress="xz")


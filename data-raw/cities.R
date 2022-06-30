library(dplyr)
library(sf)
library(tigris)
library(stringr)
library(rmapshaper)

x <- purrr::map_dfr(c(state.abb, 'DC'),
                    function(st) {
                      tidycensus::get_decennial('place', 'P2_001N', year = 2020, state = st, geometry = TRUE) %>%
                        dplyr::mutate(geometry = st_centroid(geometry)) %>%
                        dplyr::arrange(desc(value)) %>%
                        dplyr::slice(1:40) %>%
                        dplyr::mutate(state = st) %>%
                        dplyr::select(-variable) %>%
                        dplyr::rename(pop_2020 = value)
                    })

x <- x %>%
  dplyr::arrange(desc(pop_2020)) %>%
  dplyr::slice(1:1000)

x <- x %>%
  dplyr::select(
    name = NAME, state, GEOID, pop_2020, geometry
  )

cities <- x %>%
  dplyr::mutate(name = sapply(strsplit(x$name, ','), `[`, 1))

usethis::use_data(cities, overwrite=TRUE, compress="xz")



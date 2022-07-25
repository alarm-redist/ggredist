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
y <- x %>%
  filter(NAME %in% c('Frankfort city, Kentucky', 'Augusta city, Maine', 'Helena city, Montana', 'Pierre city, South Dakota', 'Montpelier city, Vermont'))

x <- x %>%
  dplyr::arrange(desc(pop_2020)) %>%
  dplyr::slice(1:1000)

x <- bind_rows(x, y)

x <- x %>%
  dplyr::select(
    name = NAME, state, GEOID, pop_2020, geometry
  )

cities <- x %>%
  dplyr::mutate(name = sapply(strsplit(x$name, ','), `[`, 1))

# c('(Honolulu County)', '(Baltimore County)', '(balance)', 'city and borough', 'city', 'borough', 'town', 'township', 'CDP', 'county', 'village',  'municipality')
cities <- cities %>%
  mutate(
    name = ifelse(endsWith(str_to_lower(name), str_to_lower('(Honolulu County)')), str_sub(name, 1, -18), name),
    name = ifelse(endsWith(str_to_lower(name), str_to_lower('(Baltimore County)')), str_sub(name, 1, -19), name),
    name = ifelse(endsWith(str_to_lower(name), str_to_lower('(balance)')), str_sub(name, 1, -10), name),
    name = ifelse(endsWith(str_to_lower(name), str_to_lower('city and borough')), str_sub(name, 1, -17), name),
    name = ifelse(endsWith(str_to_lower(name), str_to_lower('city')), str_sub(name, 1, -5), name),
    name = ifelse(endsWith(str_to_lower(name), str_to_lower('borough')), str_sub(name, 1, -8), name),
    name = ifelse(endsWith(str_to_lower(name), str_to_lower('town')), str_sub(name, 1, -5), name),
    name = ifelse(endsWith(str_to_lower(name), str_to_lower('township')), str_sub(name, 1, -9), name),
    name = ifelse(endsWith(str_to_lower(name), str_to_lower('CDP')), str_sub(name, 1, -4), name),
    name = ifelse(endsWith(str_to_lower(name), str_to_lower('county')), str_sub(name, 1, -7), name),
    name = ifelse(endsWith(str_to_lower(name), str_to_lower('village')), str_sub(name, 1, -8), name),
    name = ifelse(endsWith(str_to_lower(name), str_to_lower('municipality')), str_sub(name, 1, -13), name),
    name = ifelse(endsWith(str_to_lower(name), str_to_lower('government ')), str_sub(name, 1, -12), name),
    name = ifelse(endsWith(str_to_lower(name), str_to_lower('city')), str_sub(name, 1, -6), name),
    name = str_squish(name))

cities <- cities %>%
  mutate(
    name = case_when(
      name == 'Urban Honolulu' & state == 'HI' ~ 'Honolulu',
      name == 'Boise City' & state == 'ID' ~ 'Boise',
      name == 'Indianapolis city' & state == 'IN'  ~  'Indianapolis',
      name == 'St. Paul' & state == 'MN'  ~  'Saint Paul',
      name == 'Carson' & state == 'NV'  ~  'Carson City',
      name == 'Nashville-Davidson metropolitan' & state == 'TN'  ~  'Nashville',
      TRUE ~ name
    )
  )

capitals <- structure(
  list(
    state_name = c("Alabama", "Alaska", "Arizona",
                   "Arkansas", "California", "Colorado", "Connecticut", "Delaware",
                   "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana",
                   "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland",
                   "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri",
                   "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey",
                   "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio",
                   "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina",
                   "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia",
                   "Washington", "West Virginia", "Wisconsin", "Wyoming", 'District of Columbia'),
    state = c("AL",
              "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "ID",
              "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN",
              "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND",
              "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT",
              "VA", "WA", "WV", "WI", "WY", 'DC'),
    capital = c("Montgomery", "Juneau",
                "Phoenix", "Little Rock", "Sacramento", "Denver", "Hartford",
                "Dover", "Tallahassee", "Atlanta", "Honolulu", "Boise", "Springfield",
                "Indianapolis", "Des Moines", "Topeka", "Frankfort", "Baton Rouge",
                "Augusta", "Annapolis", "Boston", "Lansing", "Saint Paul", "Jackson",
                "Jefferson City", "Helena", "Lincoln", "Carson City", "Concord",
                "Trenton", "Santa Fe", "Albany", "Raleigh", "Bismarck", "Columbus",
                "Oklahoma City", "Salem", "Harrisburg", "Providence", "Columbia",
                "Pierre", "Nashville", "Austin", "Salt Lake City", "Montpelier",
                "Richmond", "Olympia", "Charleston", "Madison", "Cheyenne", 'Washington')
  ),
  class = "data.frame",
  row.names = c(NA, -51L)
)

cities <- cities %>%
  left_join(capitals) %>%
  mutate(capital = capital == name) %>%
  relocate(geometry, .after = everything())

usethis::use_data(cities, overwrite=TRUE, compress="xz")

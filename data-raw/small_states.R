library(tidyverse)
library(sf)
s <- tinytiger::tt_states()

small_states <- rmapshaper::ms_simplify(s, keep = 0.0005)
small_states %>% ggplot() + geom_sf()

usethis::use_data(small_states, internal = TRUE)

crop_to <- function(subset, data, ...) {
  subset = rlang::eval_tidy(rlang::enquo(subset), data)
  bbox = sf::st_bbox(data[subset, ])
  ggplot2::coord_sf(xlim=c(bbox["xmin"], bbox["xmax"]), ylim=c(bbox["ymin"], bbox["ymax"]), ...)
}

view_box <- function(subset, data) {
  subset = rlang::eval_tidy(rlang::enquo(subset), data)
  bbox = sf::st_bbox(data[subset, ])
  ggplot2::annotate("rect", xmin=bbox["xmin"], xmax=bbox["xmax"], ymin=bbox["ymin"], ymax=bbox["ymax"],
                    fill="transparent", color="black")
}

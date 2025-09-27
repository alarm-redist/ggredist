#' Zoom in to a subset of a plot
#'
#' Provides `crop_to()` to zoom in to a subset of a data frame, and `view_box()`
#' to annotate the zoomed-in region on the full plot.
#'
#' @param subset An indexing expression to select rows from `data`.
#'   Tidy-evaluted in the context of `data`.
#' @param data An `sf` data frame.
#'
#' @returns `crop_to()` returns a `coord_sf()` object to be added to a ggplot.
#'   `view_box()` returns a `geom_rect()` layer to be added to a ggplot.
#'
#' @examples
#' library(ggplot2)
#' data(oregon)
#'
#' ggplot(oregon, aes(fill = ndv / (ndv + nrv))) +
#'     geom_sf(size = 0) +
#'     scale_fill_538(name = "") +
#'     view_box(county == "Multnomah", oregon) +
#'     theme_map()
#'
#' ggplot(oregon, aes(fill = ndv / (ndv + nrv))) +
#'     geom_sf(size = 0) +
#'     scale_fill_538(name = "") +
#'     crop_to(county == "Multnomah", oregon) +
#'     theme_map()
#' @export
#' @name zoom
crop_to <- function(subset, data, ...) {
  subset = rlang::eval_tidy(rlang::enquo(subset), data)
  bbox = sf::st_bbox(data[subset, ])
  ggplot2::coord_sf(xlim=c(bbox["xmin"], bbox["xmax"]), ylim=c(bbox["ymin"], bbox["ymax"]), ...)
}

#' @rdname zoom
#' @export
view_box <- function(subset, data) {
  subset = rlang::eval_tidy(rlang::enquo(subset), data)
  bbox = sf::st_bbox(data[subset, ])
  ggplot2::annotate("rect", xmin=bbox["xmin"], xmax=bbox["xmax"], ymin=bbox["ymin"], ymax=bbox["ymax"],
                    fill="transparent", color="black")
}

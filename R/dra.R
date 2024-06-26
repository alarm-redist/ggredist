#' Dave's Redistricting App classic scale for `ggplot2`
#'
#' @param ... Arguments passed on to [ggplot2::discrete_scale()]
#'
#' @return ggplot scale function
#'
#' @examples
#' library(ggplot2)
#' data(oregon)
#'
#' ggplot(oregon, aes(group = county, fill=county)) +
#'     geom_district() +
#'     scale_fill_dra() +
#'     theme_map()
#'
#' @concept colors
#' @rdname scale_dra
#' @export
scale_fill_dra <- function(...) {
  ggplot2::discrete_scale(aesthetics = 'fill', scale_name = 'dra',
                          palette = palette::palette_function(ggredist$dra), ...)
}


#' @rdname scale_dra
#' @concept colors
#' @export
scale_color_dra <- function(...) {
  ggplot2::discrete_scale(aesthetics = 'color', scale_name = 'dra',
                          palette = palette::palette_function(ggredist$dra), ...)
}
#' @rdname scale_dra
#' @concept colors
#' @export
scale_colour_dra <- scale_color_dra

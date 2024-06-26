#' Rand-McNally and National Geographic Color Scales for `ggplot2`
#'
#' @param ... Arguments passed on to [ggplot2::discrete_scale()]
#'
#' @return ggplot scale function
#'
#' @examples
#' library(ggplot2)
#' data(oregon)
#'
#' ggplot(oregon, aes(group = county)) +
#'     geom_district() +
#'     scale_fill_randmcnally() +
#'     theme_map()
#'
#' ggplot(oregon, aes(group = county)) +
#'     geom_district() +
#'     scale_fill_natgeo() +
#'     theme_map()
#'
#' @concept colors
#' @rdname scale_polimap
#' @export
scale_fill_randmcnally <- function(...) {
  ggplot2::discrete_scale(aesthetics = 'fill', scale_name = 'randmcnally',
                          palette = palette::palette_function(ggredist$randmcnally), ...)
}

#' @rdname scale_polimap
#' @concept colors
#' @export
scale_color_randmcnally <- function(...) {
  ggplot2::discrete_scale(aesthetics = 'color', scale_name = 'randmcnally',
                          palette = palette::palette_function(ggredist$randmcnally), ...)
}
#' @rdname scale_polimap
#' @concept colors
#' @export
scale_colour_randmcnally = scale_color_randmcnally


#' @rdname scale_polimap
#' @concept colors
#' @export
scale_fill_natgeo <- function(...) {
  ggplot2::discrete_scale(aesthetics = 'fill', scale_name = 'natgeo',
                          palette = palette::palette_function(ggredist$natgeo), ...)
}

#' @rdname scale_polimap
#' @concept colors
#' @export
scale_color_natgeo <- function(...) {
  ggplot2::discrete_scale(aesthetics = 'color', scale_name = 'natgeo',
                          palette = palette::palette_function(ggredist$natgeo), ...)
}
#' @rdname scale_polimap
#' @concept colors
#' @export
scale_colour_natgeo = scale_color_natgeo

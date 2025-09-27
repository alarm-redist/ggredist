#' Nature-derived Color Scales for `ggplot2`
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
#'     scale_fill_coast() +
#'     theme_map()
#'
#' ggplot(oregon, aes(group = county)) +
#'     geom_district() +
#'     scale_fill_larch() +
#'     theme_map()
#'
#' @concept colors
#' @rdname scale_nature
#' @export
scale_fill_coast <- function(...) {
  ggplot2::discrete_scale(aesthetics = 'fill', scale_name = 'coast',
                          palette = palette::palette_function(ggredist$coast), ...)
}

#' @rdname scale_nature
#' @concept colors
#' @export
scale_color_coast <- function(...) {
  ggplot2::discrete_scale(aesthetics = 'color', scale_name = 'coast',
                          palette = palette::palette_function(ggredist$coast), ...)
}
#' @rdname scale_nature
#' @concept colors
#' @export
scale_colour_coast = scale_color_coast

#' @rdname scale_nature
#' @concept colors
#' @export
scale_fill_larch <- function(...) {
  ggplot2::discrete_scale(aesthetics = 'fill', scale_name = 'larch',
                          palette = palette::palette_function(ggredist$larch), ...)
}

#' @rdname scale_nature
#' @concept colors
#' @export
scale_color_larch <- function(...) {
  ggplot2::discrete_scale(aesthetics = 'color', scale_name = 'larch',
                          palette = palette::palette_function(ggredist$larch), ...)
}
#' @rdname scale_nature
#' @concept colors
#' @export
scale_colour_larch = scale_color_larch

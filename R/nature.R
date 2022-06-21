#' Nature-derived Color Scales for `ggplot2`
#'
#' @param ... Arguments passed on to [ggplot2::discrete_scale()
#'
#' @examples
#' library(ggplot2)
#' data(oregon)
#'
#' ggplot(oregon, aes(group = county)) +
#'     geom_districts() +
#'     scale_fill_coast() +
#'     theme_map()
#'
#' ggplot(oregon, aes(group = county)) +
#'     geom_districts() +
#'     scale_fill_larch() +
#'     theme_map()
#'
#' @concept colors
#' @rdname scale_nature
#' @export
scale_fill_coast <- function(...) {
  ggplot2::discrete_scale(aesthetics = 'fill', scale_name = 'coast',
                          palette = rot_pal(ggredist$coast))
}

#' @rdname scale_nature
#' @concept colors
#' @export
scale_color_coast <- function(...) {
  ggplot2::discrete_scale(aesthetics = 'color', scale_name = 'coast',
                          palette = rot_pal(ggredist$coast))
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
                          palette = rot_pal(ggredist$larch))
}

#' @rdname scale_nature
#' @concept colors
#' @export
scale_color_larch <- function(...) {
  ggplot2::discrete_scale(aesthetics = 'color', scale_name = 'larch',
                          palette = rot_pal(ggredist$larch))
}
#' @rdname scale_nature
#' @concept colors
#' @export
scale_colour_larch = scale_color_larch

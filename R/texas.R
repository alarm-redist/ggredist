#' Texas Color Scales for `ggplot2`
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
#'     scale_fill_texas() +
#'     theme_map()
#'
#' @concept colors
#' @rdname scale_texas
#' @export
scale_fill_texas <- function(...) {
  ggplot2::discrete_scale(aesthetics = 'fill', scale_name = 'texas',
                          palette = palette::palette_function(ggredist$texas), ...)
}

#' @rdname scale_texas
#' @concept colors
#' @export
scale_color_texas <- function(...) {
  ggplot2::discrete_scale(aesthetics = 'color', scale_name = 'texas',
                          palette = palette::palette_function(ggredist$texas), ...)
}
#' @rdname scale_texas
#' @concept colors
#' @export
scale_colour_texas = scale_color_texas

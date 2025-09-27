#' Washington Redistricting Commission Color Scales for `ggplot2`
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
#'     scale_fill_washington() +
#'     theme_map()
#'
#' @concept colors
#' @rdname scale_washington
#' @export
scale_fill_washington <- function(...) {
  ggplot2::discrete_scale(aesthetics = 'fill', scale_name = 'washington',
                          palette = palette::palette_function(ggredist$washington), ...)
}

#' @rdname scale_washington
#' @concept colors
#' @export
scale_color_washington <- function(...) {
  ggplot2::discrete_scale(aesthetics = 'color', scale_name = 'washington',
                          palette = palette::palette_function(ggredist$washington), ...)
}
#' @rdname scale_washington
#' @concept colors
#' @export
scale_colour_washington = scale_color_washington

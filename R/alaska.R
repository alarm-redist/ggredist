#' Alaska Color Scales for `ggplot2`
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
#'     scale_fill_alaska() +
#'     theme_map()
#'
#' @concept colors
#' @rdname scale_alaska
#' @export
scale_fill_alaska <- function(...) {
  ggplot2::discrete_scale(aesthetics = 'fill', scale_name = 'alaska',
                          palette = palette::palette_function(ggredist$alaska), ...)
}

#' @rdname scale_alaska
#' @concept colors
#' @export
scale_color_alaska <- function(...) {
  ggplot2::discrete_scale(aesthetics = 'color', scale_name = 'alaska',
                          palette = palette::palette_function(ggredist$alaska), ...)
}
#' @rdname scale_alaska
#' @concept colors
#' @export
scale_colour_alaska = scale_color_alaska

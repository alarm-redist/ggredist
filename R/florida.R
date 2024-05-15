#' Jacksonville and Florida Color Scales for `ggplot2`
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
#'     scale_fill_jacksonville() +
#'     theme_map()
#'
#' ggplot(oregon, aes(group = county)) +
#'     geom_district() +
#'     scale_fill_florida() +
#'     theme_map()
#'
#' @concept colors
#' @rdname scale_florida
#' @export
scale_fill_jacksonville <- function(...) {
  ggplot2::discrete_scale(aesthetics = 'fill', scale_name = 'jacksonville',
                          palette = palette::palette_function(ggredist$jacksonville), ...)
}

#' @rdname scale_florida
#' @concept colors
#' @export
scale_color_jacksonville <- function(...) {
  ggplot2::discrete_scale(aesthetics = 'color', scale_name = 'jacksonville',
                          palette = palette::palette_function(ggredist$jacksonville), ...)
}
#' @rdname scale_florida
#' @concept colors
#' @export
scale_colour_jacksonville = scale_color_jacksonville


#' @rdname scale_florida
#' @concept colors
#' @export
scale_fill_florida <- function(...) {
  ggplot2::discrete_scale(aesthetics = 'fill', scale_name = 'florida',
                          palette = palette::palette_function(ggredist$florida), ...)
}

#' @rdname scale_florida
#' @concept colors
#' @export
scale_color_florida <- function(...) {
  ggplot2::discrete_scale(aesthetics = 'color', scale_name = 'florida',
                          palette = palette::palette_function(ggredist$florida), ...)
}
#' @rdname scale_florida
#' @concept colors
#' @export
scale_colour_florida = scale_color_florida

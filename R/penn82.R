#' Historical Pennsylvania Color Scale for `ggplot2`
#'
#' @param ... Arguments passed on to [ggplot2::discrete_scale()]
#'
#' @examples
#' library(ggplot2)
#' data(oregon)
#'
#' ggplot(oregon, aes(group = county)) +
#'     geom_district() +
#'     scale_fill_penn82() +
#'     theme_map()
#'
#' @concept colors
#' @rdname scale_penn82
#' @export
scale_fill_penn82 <- function(...) {
  ggplot2::discrete_scale(aesthetics = 'fill', scale_name = 'penn82',
                          palette = rot_pal(ggredist$penn82), ...)
}

#' @rdname scale_penn82
#' @concept colors
#' @export
scale_color_penn82 <- function(...) {
  ggplot2::discrete_scale(aesthetics = 'color', scale_name = 'penn82',
                          palette = rot_pal(ggredist$penn82), ...)
}
#' @rdname scale_penn82
#' @concept colors
#' @export
scale_colour_penn82 = scale_color_penn82

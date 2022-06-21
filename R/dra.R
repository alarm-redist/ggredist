#' Dave's Redistricting App classic scale for `ggplot2`
#'
#' @param ... Arguments passed on to [ggplot2::discrete_scale()
#'
#' @examples
#' library(ggplot2)
#' data(oregon)
#'
#' ggplot(oregon, aes(fill = factor(cd_2020))) +
#'     geom_sf(size = 0) +
#'     scale_fill_dra() +
#'     theme_map()
#'
#' @concept colors
#' @rdname scale_dra
#' @export
scale_fill_dra <- function(...) {
  ggplot2::discrete_scale(aesthetics = 'fill', scale_name = 'dra',
                          palette = rot_pal(ggredist$dra))
}


#' @rdname scale_dra
#' @concept colors
#' @export
scale_color_dra <- function(...) {
  ggplot2::discrete_scale(aesthetics = 'color', scale_name = 'dra',
                          palette = rot_pal(ggredist$dra))
}
#' @rdname scale_dra
#' @concept colors
#' @export
scale_colour_dra = scale_color_dra

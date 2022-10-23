#' Map Theme
#'
#' Theme for maps which uses the `'Times'` family and has a transparent background.
#'
#' @param ... additional parameters
#'
#' @return ggplot2 theme
#' @export
#' @concept theme
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
theme_map <- function(...) {
  ggplot2::theme_void(base_family = 'Times', base_size = 12) +
    ggplot2::theme(panel.background = ggplot2::element_rect(
      fill = 'transparent',
      color = NA
    ), ...)
}

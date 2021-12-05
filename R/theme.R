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
theme_map <- function(...) {
  ggplot2::theme_void(base_family = 'Times', base_size = 12) +
    ggplot2::theme(panel.background = ggplot2::element_rect(fill = "transparent",
                                                   color = NA), ...)
}

#' Plot Theme from Redistricting 2021 Blog
#'
#' @param ...
#'
#' @return ggplot2 theme
#' @export
#' @concept theme
#'
#' @examples
theme_r21 <- function(...) {
  ggplot2::theme_bw(base_family = 'Times', base_size = 12, ...)
}

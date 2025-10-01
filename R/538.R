#' FiveThirtyEight scales for `ggplot2`
#'
#' @rdname scale_538
#'
#' @param ... additional arguments to `ggplot::scale_*` functions
#'
#' @return ggplot scale function
#'
#' @examples
#' library(ggplot2)
#' data(oregon)
#'
#' ggplot(oregon, aes(fill = ndv / (ndv + nrv))) +
#'     geom_sf(size = 0) +
#'     scale_fill_538(name = '') +
#'     theme_map()
#' @concept colors
#' @export
scale_fill_538 <- function(...) {
  breaks <- c(0, 0.35, 0.45, 0.55, 0.65, 1)
  limits <- c(0.25, 0.75)
  ivals <-  scales::rescale(breaks, from = limits)
  ggplot2::binned_scale('fill',
                        palette = function(x) {
                          ggredist$fivethirtyeight[
                            findInterval(x, ivals, all.inside = TRUE, rightmost.closed = TRUE)
                          ]
                        },
                        breaks = breaks,
                        limits = limits,
                        oob = scales::squish,
                        guide = 'colourbar',
                        ...
  )
}

#' @rdname scale_538
#' @concept colors
#' @export
scale_color_538 <- function(...) {
  ggplot2::binned_scale('color', '538',
                        palette = function(x) {
                            if (length(x) > 5) {
                                stop("`scale_fill_538()` supports up to 5 bins")
                            }
                            ggredist$fivethirtyeight[seq_along(x)]
                        },
                        breaks = c(0.35, 0.45, 0.55, 0.65),
                        limits = c(.25, .75),
                        oob = scales::squish,
                        guide = 'colourbar',
                        ...
  )
}


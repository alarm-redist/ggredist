#' Party scales for `ggplot2`
#'
#' @rdname scale_party
#' @export
#' @concept scales
#'
#' @param name name for scale. Default is `"Democratic share"`.
#' @param midpoint Scale midpoint value. Default is `0.5`.
#' @param limits Lower and upper limits for scale. Default is `0:1`.
#' @param labels function to adjust scale labels. Default is `scales::percent`.
#' @param oob function to deal with out of bounds. Default is `scales::squish()`.
#' @param ... additional arguments to `ggplot::scale_*` functions
#'
#'
#' @md
#' @examples
#' # TODO
#'
scale_fill_party_c <- function(name = "Democratic share", midpoint = 0.5, limits = 0:1,
                               labels = scales::percent, oob = scales::squish, ...,
                               reverse = FALSE) {
  ggplot2::scale_fill_gradient2(
    name = name, ..., low = GOP_DEM[1], high = GOP_DEM[15],
    midpoint = midpoint, limits = limits, labels = labels, oob = oob
  )
}

#' @rdname scale_party
#' @export
scale_fill_party_d <- function(...) {
  ggplot2::scale_fill_manual(...,
                     values = c(GOP_DEM[2], GOP_DEM[14]),
                     labels = c("Rep.", "Dem.")
  )
}

#' @rdname scale_party
#' @export
scale_color_party_c <- function(name = "Democratic share", midpoint = 0.5, limits = 0:1,
                                labels = scales::percent, oob = scales::squish, ...) {
  ggplot2::scale_color_gradient2(
    name = name, ..., low = GOP_DEM[1], high = GOP_DEM[15],
    midpoint = midpoint, limits = limits, labels = labels, oob = oob
  )
}

#' @rdname scale_party
#' @export
scale_color_party_d <- function(...) {
  ggplot2::scale_color_manual(...,
    values = c(GOP_DEM[2], GOP_DEM[14]),
    labels = c("Rep.", "Dem.")
  )
}

#' @rdname scale_party
#' @export
scale_color_party_b <- function(...) {
  ggplot2::binned_scale('color', 'party',
               palette = grDevices::colorRampPalette(GOP_DEM),
               ...)
}

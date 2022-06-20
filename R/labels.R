

#' Label Partisan Margins
#'
#' For example, a 55% Democratic vote share becomes "D+10".
#'
#' @param midpoint Either 0.5, the default, or 0. If zero, scale will not be
#'   doubled (0.05 becomes "D+5" with `midpoint=0`, while 0.55 becomes
#'   "D+10" with `midpoint=0.5)
#' @param reverse If `TRUE`, reverse "D" and "R".
#' @param accuracy As with [scales::number_format]
#'
#' @return A labeling function
#' @examples
#' labeler = label_margin(accuracy=0.1)
#' labeler(c(0.3, 0.5, 0.543))
#'
#' @export
label_margin = function(midpoint = 0.5, reverse = FALSE, accuracy=1) {
  mult = ifelse(midpoint == 0.5, 200, 100)
  function(x) {
    ifelse(x == midpoint, "Even",
           paste0(ifelse(x < 0.5, "R+", "D+"),
                  scales::number(mult * abs(x - midpoint), accuracy)))
  }
}


# TODO suggest deleing `percent_no_dec`

#' Label Percentages with No Decimal
#'
#' @param ... additional arguments to pass to `scales::label_percent`
#'
#' @return returns a labelling function
#' @export
#'
#' @examples
#' # TODO
#'
percent_no_dec <- function(...) {
  scales::label_percent(accuracy = 1L, ...)
}

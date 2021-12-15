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

#' Label Partisan Vote Shares
#'
#' For example, a 45% Democratic vote share becomes "R+10" or "55% R".
#'
#' @param midpoint Either 0.5, the default, or 0. For `label_party_margin()`, if
#'   zero, scale will not be doubled (0.05 becomes "D+5" with `midpoint=0`,
#'   while 0.55 becomes "D+10" with `midpoint=0.5)
#' @param reverse If `TRUE`, reverse "D" and "R".
#' @param accuracy As with [scales::number_format]
#'
#' @return A labeling function
#' @examples
#' labeler = label_party_margin(accuracy=0.1)
#' labeler(c(0.3, 0.5, 0.543))

#' labeler = label_party_margin(reverse=TRUE)
#' labeler(c(0.3, 0.5, 0.543))
#'
#' @concept labels
#' @rdname label_party
#' @export
label_party_margin = function(midpoint = 0.5, reverse = FALSE, accuracy=1) {
  mult = ifelse(midpoint == 0.5, 200, 100)
  lbls = c("R+", "D+")
  if (reverse) lbls = rev(lbls)

  function(x) {
    ifelse(x == midpoint, "Even",
           paste0(ifelse(x < midpoint, lbls[1], lbls[2]),
                  scales::number(mult * abs(x - midpoint), accuracy)))
  }
}

#' @concept labels
#' @rdname label_party
#' @export
label_party_pct = function(midpoint = 0.5, reverse = FALSE, accuracy=1) {
  mult = ifelse(midpoint == 0.5, 200, 100)
  lbls = c("R", "D")
  if (reverse) lbls = rev(lbls)

  function(x) {
    ifelse(x == midpoint, "Even",
           paste(scales::percent(midpoint + abs(x - midpoint), accuracy),
                 ifelse(x < midpoint, lbls[1], lbls[2])))
  }
}

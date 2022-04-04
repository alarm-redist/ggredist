#' Dave's Redistricting App classic scale for `ggplot2`
#'
#' @rdname scale_dra
#' @export
#' @concept scales
#'
#' @param ... Arguments passed on to [ggplot2::discrete_scale()
#'
#' @md
#' @examples
#' scale_fill_dra()
scale_fill_dra <- function(...) {
  ggplot2::discrete_scale(
    aesthetics = 'fill',
    scale_name = 'dra',
    palette = function(n) {
      if (n <= 12) {
        dra[seq_len(n)]
      } else {
        rep(dra, ceiling(n / 12))[seq_len(n)]
      }
    }
  )
}

#' Ye Olde Pennsylvania scales for `ggplot2`
#'
#' @rdname scale_penn82
#' @export
#' @concept scales
#'
#' @param ... Arguments passed on to [ggplot2::discrete_scale()
#'
#' @md
#' @examples
#' # TODO
scale_fill_penn82 <- function(...) {
  ggplot2::discrete_scale(
    aesthetics = 'fill',
    scale_name = 'penn82',
    palette = function(n) {
      if (n <= 6) {
        ggredist$penn82[seq_len(n)]
      } else {
        grDevices::colorRamp(c('#FCFCF4', '#BFA95E'))
      }
    }
  )
}

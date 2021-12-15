#' Ye Olde Pennsylvania scales for `ggplot2`
#'
#' @rdname scale_ye_olde_pa
#' @export
#' @concept scales
#'
#' @param ... Arguments passed on to [ggplot2::discrete_scale()
#'
#' @md
#' @examples
#' # TODO
scale_fill_ye_olde_pa <- function(...) {
  ggplot2::discrete_scale(
    aesthetics = 'fill',
    scale_name = 'ye_olde_pa',
    palette = function(n) {
      if (n <= 6) {
        ye_olde_pa[seq_len(n)]
      } else {
        grDevices::colorRamp(c('#FCFCF4', '#BFA95E'))
      }
    }
  )
}

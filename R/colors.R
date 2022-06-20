#' Redistricting Color Palettes
#'
#' Included palettes:
#' - **partisan**, a perceptually uniform red-white-blue scale
#' - **dra**, the Dave's Redistricting App classic color palette
#' - **penn82**, Historic categorical color palette from the 1982 published Pennsylvania
#' congressional district map
#'
#' @format list of character vectors of type `palette` (which supports a
#'   `plot()` generic for visualization)
#'
#' @examples
#' plot(ggredist$partisan)
#' plot(ggredist$dra)
#' plot(ggredist$penn82)
#'
#' @export
ggredist = list(
  partisan = structure(c('#A0442C', '#B25D4C', '#C27568', '#D18E84', '#DFA8A0',
                         '#EBC2BC', '#F6DCD9', '#F9F9F9', '#DAE2F4', '#BDCCEA',
                         '#9FB6DE', '#82A0D2', '#638BC6', '#3D77BB', '#0063B1'),
                       class="palette"),
  dra = structure(c('#7070ff', '#70B870', '#BE70BE', '#FF7070', '#FFE970',
                    '#70B8B8', '#E6AB80', '#ABA2E3', '#70FFFF', '#FF7BC2',
                    '#B7FF70', '#A8C4F5', '#F3C4B4'), class="palette"),
  penn82 = structure(c('#EEEF3F', '#FAD49C', '#AD8A5A', '#FDFCB1',
                       '#EAA414', '#F7DA6A'), class="palette"),
  fivethirtyeight = structure(c('#5768AC', '#A1A9ED', '#EAE3EB',
                                '#FF998A', '#FA5A50'), class="palette")
)


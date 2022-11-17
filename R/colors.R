#' Redistricting Color Palettes
#'
#' Included palettes:
#' - **partisan**, a perceptually uniform red-white-blue scale
#' - **dra**, the Dave's Redistricting App classic color palette
#' - **penn82**, historic categorical color palette from the 1982 published
#' Pennsylvania congressional district map
#' - **randmcnally** and **natgeo**, colors taken from Rand-McNally and National
#' Geographic political maps
#' - **coast** and **larch**, inspired by natural scenery
#'
#' @format list of character vectors of type `palette` (which supports a
#'   `plot()` generic for visualization)
#'
#' @examples
#' plot(ggredist$partisan)
#' plot(ggredist$dra)
#' plot(ggredist$penn82)
#' plot(ggredist$randmcnally)
#' plot(ggredist$natgeo)
#' plot(ggredist$coast)
#' plot(ggredist$larch)
#'
#' @concept colors
#' @export
ggredist = list(
  partisan = structure(c('#A0442C', '#B25D4C', '#C27568', '#D18E84', '#DFA8A0',
                         '#EBC2BC', '#F6DCD9', '#F9F9F9', '#DAE2F4', '#BDCCEA',
                         '#9FB6DE', '#82A0D2', '#638BC6', '#3D77BB', '#0063B1'),
                       class="palette"),
  dra = structure(c('#7070ff', '#70B870', '#BE70BE', '#FF7070', '#FFE970',
                    '#70B8B8', '#E6AB80', '#ABA2E3', '#70FFFF', '#FF7BC2',
                    '#B7FF70', '#A8C4F5', '#F3C4B4', '#BEBE7E'), class="palette"),
  penn82 = structure(c('#EDEF3F', '#FED09E', '#A7825A', '#FFF8B7',
                       '#E2A414', '#ECD166'), class="palette"),
  randmcnally = structure(c("#f4c450", "#e79274", "#d3a7ae", "#fcf092",
                            "#98b791", "#c7d4da", "#e8ba8f"), class="palette"),
  natgeo = structure(c("#abafd0", "#e8b3a5", "#fded7e", "#b6c572",
                       "#efc965", "#fcf3e2"), class="palette"),
  coast = structure(c("#D4B46E", "#84AFA2", "#547286",
                      "#7F7C74", "#B2BCD6", "#526042"), class="palette"),
  larch = structure(c("#D0A75F", "#626B5D", "#8C8F9E",
                      "#858753", "#A4BADA", "#CDB7AA"), class="palette"),
  fivethirtyeight = structure(c('#5768AC', '#A1A9ED', '#EAE3EB',
                                '#FF998A', '#FA5A50'), class="palette")
)


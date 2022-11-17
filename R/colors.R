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
#' @format list of character vectors of hex colors
#'
#' @examples
#' scales::show_col(ggredist$partisan)
#' scales::show_col(ggredist$dra)
#' scales::show_col(ggredist$penn82)
#' scales::show_col(ggredist$randmcnally)
#' scales::show_col(ggredist$natgeo)
#' scales::show_col(ggredist$coast)
#' scales::show_col(ggredist$larch)
#'
#' @concept colors
#' @export
ggredist = list(
  partisan = c('#A0442C', '#B25D4C', '#C27568', '#D18E84', '#DFA8A0',
                         '#EBC2BC', '#F6DCD9', '#F9F9F9', '#DAE2F4', '#BDCCEA',
                         '#9FB6DE', '#82A0D2', '#638BC6', '#3D77BB', '#0063B1'),
  dra = c('#7070ff', '#70B870', '#BE70BE', '#FF7070', '#FFE970',
                    '#70B8B8', '#E6AB80', '#ABA2E3', '#70FFFF', '#FF7BC2',
                    '#B7FF70', '#A8C4F5', '#F3C4B4', '#BEBE7E'),
  penn82 = c('#EDEF3F', '#FED09E', '#A7825A', '#FFF8B7',
                       '#E2A414', '#ECD166'),
  randmcnally = c("#f4c450", "#e79274", "#d3a7ae", "#fcf092",
                            "#98b791", "#c7d4da", "#e8ba8f"),
  natgeo = c("#abafd0", "#e8b3a5", "#fded7e", "#b6c572",
                       "#efc965", "#fcf3e2"),
  coast = c("#D4B46E", "#84AFA2", "#547286",
                      "#7F7C74", "#B2BCD6", "#526042"),
  larch = c("#D0A75F", "#626B5D", "#8C8F9E",
                      "#858753", "#A4BADA", "#CDB7AA"),
  fivethirtyeight = c('#5768AC', '#A1A9ED', '#EAE3EB',
                                '#FF998A', '#FA5A50')
)


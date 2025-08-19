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
#' - **fivethirtyeight**, FiveThirtyEight-inspired color palette
#' - **wiki_dem_pres**: Wikipedia Presidential Democratic palette
#' - **wiki_rep_pres**: Wikipedia Presidential Republican palette
#' - **wiki_dem**: Wikipedia downballot Democratic palette
#' - **wiki_rep**: Wikipedia downballot Republican palette
#' - **wiki_proposal**: Wikipedia proposal support palette
#' - **jacksonville**, Jacksonville, FL inspired color palette
#' - **florida**, Florida inspired color palette
#' - **washington**, Washington Redistricting Commission inspired color palette
#' - **alaska**, Alaska inspired color palette
#'
#' For details on Wikipedia-based colors, see
#' <https://en.wikipedia.org/wiki/Wikipedia:WikiProject_Elections_and_Referendums/USA_legend_colors>.
#'
#' @format list of character vectors of type [palette::palette] (which supports a
#'   `plot()`, `print()`, and `pillar` generics for visualization)
#'
#' @examples
#' plot(ggredist$partisan)
#' plot(ggredist$dra)
#' plot(ggredist$penn82)
#' plot(ggredist$randmcnally)
#' plot(ggredist$natgeo)
#' plot(ggredist$coast)
#' plot(ggredist$larch)
#' plot(ggredist$fivethirtyeight)
#' plot(ggredist$wiki_dem_pres)
#' plot(ggredist$wiki_rep_pres)
#' plot(ggredist$wiki_dem)
#' plot(ggredist$wiki_rep)
#' plot(ggredist$wiki_proposal)
#' plot(ggredist$jacksonville)
#' plot(ggredist$florida)
#' plot(ggredist$washington)
#' plot(ggredist$alaska)
#'
#' @concept colors
#' @export
ggredist = list(
  partisan = palette::palette(c('#A0442C', '#B25D4C', '#C27568', '#D18E84', '#DFA8A0',
                         '#EBC2BC', '#F6DCD9', '#F9F9F9', '#DAE2F4', '#BDCCEA',
                         '#9FB6DE', '#82A0D2', '#638BC6', '#3D77BB', '#0063B1')),
  dra = palette::palette(c('#7070ff', '#70B870', '#BE70BE', '#FF7070', '#FFE970',
                    '#70B8B8', '#E6AB80', '#ABA2E3', '#70FFFF', '#FF7BC2',
                    '#B7FF70', '#A8C4F5', '#F3C4B4', '#BEBE7E')),
  penn82 = palette::palette(c('#EDEF3F', '#FED09E', '#A7825A', '#FFF8B7',
                       '#E2A414', '#ECD166')),
  randmcnally = palette::palette(c("#f4c450", "#e79274", "#d3a7ae", "#fcf092",
                            "#98b791", "#c7d4da", "#e8ba8f")),
  natgeo = palette::palette(c("#abafd0", "#e8b3a5", "#fded7e", "#b6c572",
                       "#efc965", "#fcf3e2")),
  coast = palette::palette(c("#D4B46E", "#84AFA2", "#547286",
                      "#7F7C74", "#B2BCD6", "#526042")),
  larch = palette::palette(c("#D0A75F", "#626B5D", "#8C8F9E",
                      "#858753", "#A4BADA", "#CDB7AA")),
  fivethirtyeight = palette::palette(c('#FA5A50', '#FF998A', '#EAE3EB', '#A1A9ED', '#5768AC')),
  wiki_dem_pres = palette::palette(c('#E1EFFF', '#D3E7FF', '#B9D7FF', '#86B6F2', '#4389E3',
                              '#1666CB', '#0645B4', '#002B84')),
  wiki_rep_pres = palette::palette(c('#FFDFE1', '#FFCCD0', '#F2B3BE', '#E27F90', '#CC2F4A',
                              '#D40000', '#AA0000', '#800000')),
  wiki_dem = palette::palette(c('#EBF2FF', '#DFEEFF', '#BDD3FF', '#A5B0FF', '#7996E2',
                         '#6674DE', '#584CDE', '#3933E5', '#0D0596')),
  wiki_rep = palette::palette(c('#FFF0F5', '#FFE0EA', '#FFC8CD', '#FFB2B2', '#E27F7F',
                         '#D75D5D', '#D72F30', '#C21B18', '#A80000')),
  wiki_proposal = palette::palette(c('#2B2457', '#28497C', '#47729E', '#7D9CBB', '#B6C8D9',
                              '#EBEEED', '#DEDEBD', '#BCBC83', '#8B8B54', '#5D5D2D', '#32320C')),
  jacksonville = palette::palette(c('#609CA7', '#E4874F', '#6FF87F', '#B770E6', '#5052DD',
                             '#92B340', '#93EDCA', '#83516A', '#85A6F7', '#448047',
                             '#3F3E80', '#CA4D6D', '#DCE592', '#918259')),
  florida = palette::palette(c('#F7FDB1', '#D1FDBC', '#FEBBD5', '#C6FEE0', '#C5CAFF',
                        '#F0C2FD', '#FEC6C9', '#B4FDBF', '#FDF4C4', '#BAB5FD',
                        '#FFB5B3', '#BDF8FE', '#FFBEF3', '#B6FDCF', '#FDF1D5',
                        '#C7D8FE', '#FED5E2', '#E4B3FD', '#E0FDD6', '#FDE3B1',
                        '#FDCFBB', '#DEC8FE', '#D7EFFF', '#DFFDF2', '#FED5FC',
                        '#B5FFF1', '#B4E5FE', '#EFFDC6')),
  washington = palette::palette(c('#993A5B', '#1E5769', '#D98B79', '#D9CC46', '#2AA99C',
                           '#F1C1B8', '#533742', '#ABD2C5', '#976C81', '#239C78',
                           '#A36D02', '#2A3944')),
  alaska = palette::palette(c("#8FAD6A", "#A66A8F", "#82BBB4", "#7383BA",
                              "#C6A46B", "#C4DC94", "#6691AD", "#A87C78",
                              "#C8867A", "#4DD7FF", "#A17CB8", "#BF6884",
                              "#A89264", "#BB6FC8", "#ADBA83"
  ))
)


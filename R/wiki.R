#' Wikipedia Election Map scales for `ggplot2`
#'
#' @rdname scale_wiki
#'
#' @param ... additional arguments to `ggplot::scale_*` functions
#'
#' @return ggplot scale function
#'
#' @examples
#' scale_fill_wiki_rep()
#' scale_fill_wiki_rep()
#' scale_fill_wiki_dem()
#' scale_fill_wiki_dem()
#' scale_fill_wiki_rep_pres()
#' scale_fill_wiki_rep_pres()
#' scale_fill_wiki_dem_pres()
#' scale_fill_wiki_dem_pres()
#' @concept colors
#' @export
scale_fill_wiki_rep <- function(...) {
  ggplot2::binned_scale('fill', 'wiki_rep',
                        palette = function(x) ggredist$wiki_rep,
                        breaks = seq(0, 1, by = 0.1),
                        limits = c(.1, .9),
                        oob = scales::squish,
                        guide = 'colourbar',
                        ...
  )
}

#' @rdname scale_wiki
#'
#' @concept colors
#' @export
scale_color_wiki_rep <- function(...) {
  ggplot2::binned_scale('color', 'wiki_rep',
                        palette = function(x) ggredist$wiki_rep,
                        breaks = seq(0, 1, by = 0.1),
                        limits = c(.1, .9),
                        oob = scales::squish,
                        guide = 'colourbar',
                        ...
  )
}

#' @rdname scale_wiki
#'
#' @concept colors
#' @export
scale_fill_wiki_dem <- function(...) {
  ggplot2::binned_scale('fill', 'wiki_dem',
                        palette = function(x) ggredist$wiki_dem,
                        breaks = seq(0, 1, by = 0.1),
                        limits = c(.1, .9),
                        oob = scales::squish,
                        guide = 'colourbar',
                        ...
  )
}

#' @rdname scale_wiki
#'
#' @concept colors
#' @export
scale_color_wiki_dem <- function(...) {
  ggplot2::binned_scale('color', 'wiki_dem',
                        palette = function(x) ggredist$wiki_dem,
                        breaks = seq(0, 1, by = 0.1),
                        limits = c(.1, .9),
                        oob = scales::squish,
                        guide = 'colourbar',
                        ...
  )
}

#' @rdname scale_wiki
#'
#' @concept colors
#' @export
scale_fill_wiki_rep_pres <- function(...) {
  ggplot2::binned_scale('fill', 'wiki_rep_pres',
                        palette = function(x) ggredist$wiki_rep_pres,
                        breaks = c(0, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1),
                        limits = c(.2, .9),
                        oob = scales::squish,
                        guide = 'colourbar',
                        ...
  )
}

#' @rdname scale_wiki
#'
#' @concept colors
#' @export
scale_color_wiki_rep_pres <- function(...) {
  ggplot2::binned_scale('color', 'wiki_rep_pres',
                        palette = function(x) ggredist$wiki_rep_pres,
                        breaks = c(0, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1),
                        limits = c(.2, .9),
                        oob = scales::squish,
                        guide = 'colourbar',
                        ...
  )
}

#' @rdname scale_wiki
#'
#' @concept colors
#' @export
scale_fill_wiki_dem_pres <- function(...) {
  ggplot2::binned_scale('fill', 'wiki_dem_pres',
                        palette = function(x) ggredist$wiki_dem_pres,
                        breaks = c(0, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1),
                        limits = c(.2, .9),
                        oob = scales::squish,
                        guide = 'colourbar',
                        ...
  )
}

#' @rdname scale_wiki
#'
#' @concept colors
#' @export
scale_color_wiki_dem_pres <- function(...) {
  ggplot2::binned_scale('color', 'wiki_dem_pres',
                        palette = function(x) ggredist$wiki_dem_pres,
                        breaks = c(0, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1),
                        limits = c(.2, .9),
                        oob = scales::squish,
                        guide = 'colourbar',
                        ...
  )
}

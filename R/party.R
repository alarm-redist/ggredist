#' Partisan scales for `ggplot2`
#'
#' @param name Name for scale. Default is `"Vote share"`.
#' @param midpoint Scale midpoint value. Default is `0.5`.
#' @param limits Lower and upper limits for scale. Default is `0:1`.
#' @param labels Function to adjust scale labels. Default is `scales::percent`.
#' @param oob Function to deal with out of bounds. Default is `scales::squish()`.
#' @param reverse Whether to reverse red and blue.
#' @param nice.breaks If `TRUE`, attempt to place breaks at nice values instead
#'   of exactly evenly spaced between the limits.
#' @param ... Additional arguments to `ggplot::scale_*` functions
#'
#' @return ggplot scale function
#'
#' @examples
#' library(ggplot2)
#' data(oregon)
#'
#' ggplot(oregon, aes(fill = ndv / (ndv + nrv))) +
#'     geom_sf(size = 0) +
#'     scale_fill_party_c(limits=c(0.3, 0.7)) +
#'     theme_map()
#'
#' ggplot(oregon, aes(fill = ndv / (ndv + nrv))) +
#'     geom_sf(size = 0) +
#'     scale_fill_party_b() +
#'     theme_map()
#'
#' @name scale_party
#' @concept colors
NULL

#' @rdname scale_party
#' @concept colors
#' @export
scale_fill_party_c <- function(name = 'Vote share', midpoint = 0.5, limits = 0:1,
                               labels = label_party_pct(), oob = scales::squish,
                               reverse = FALSE, ...) {
  pal = ggredist$partisan
  if (reverse) pal = rev(pal)

  if (is.null(midpoint)) {
    rescaler = scales::rescale
  } else {
    rescaler = function(x, to=c(0, 1), from=range(x, na.rm=TRUE)) {
      scales::rescale_mid(x, to, from, midpoint)
    }
  }

  ggplot2::scale_fill_gradientn(name = name, limits = limits, labels = labels,
                                oob = oob, colours=pal, rescaler=rescaler)
}


#' @rdname scale_party
#' @concept colors
#' @export
scale_color_party_c <- function(name = 'Vote share', midpoint = 0.5, limits = 0:1,
                                labels = label_party_pct(), oob = scales::squish,
                                reverse = FALSE, ...) {
  pal = ggredist$partisan
  if (reverse) pal = rev(pal)

  if (is.null(midpoint)) {
    rescaler = scales::rescale
  } else {
    rescaler = function(x, to=c(0, 1), from=range(x, na.rm=TRUE)) {
      scales::rescale_mid(x, to, from, midpoint)
    }
  }

  ggplot2::scale_color_gradientn(name = name, limits = limits, labels = labels,
                                 oob = oob, colours=pal, rescaler=rescaler)
}

#' @rdname scale_party
#' @concept colors
#' @export
scale_fill_party_d <- function(labels = c('Rep.', 'Dem.'), reverse = FALSE, ...) {
  pal = c(ggredist$partisan[2], ggredist$partisan[14])
  if (reverse) pal = rev(pal)

  ggplot2::scale_fill_manual(..., values = pal, labels = labels)
}

#' @rdname scale_party
#' @concept colors
#' @export
scale_color_party_d <- function(labels = c('Rep.', 'Dem.'), reverse = FALSE, ...) {
  pal = c(ggredist$partisan[2], ggredist$partisan[14])
  if (reverse) pal = rev(pal)

  ggplot2::scale_color_manual(..., values = pal, labels = labels)
}


#' @rdname scale_party
#' @concept colors
#' @export
scale_fill_party_b <- function(name = 'Vote share', midpoint = 0.5, limits = 0:1,
                               labels = label_party_pct(), oob = scales::squish,
                               reverse = FALSE, nice.breaks = FALSE, ...) {
  pal = ggredist$partisan
  if (reverse) pal$pal = rev(pal)
  pal_fun = scales::colour_ramp(pal)

  if (is.null(midpoint)) {
    rescaler = scales::rescale
  } else {
    rescaler = function(x, to=c(0, 1), from=range(x, na.rm=TRUE)) {
      scales::rescale_mid(x, to, from, midpoint)
    }
  }

  ggplot2::binned_scale("fill", "party", name = name, limits = limits,
                        labels = labels, oob = oob, palette = pal_fun,
                        rescaler = rescaler, nice.breaks = nice.breaks, ...)
}

#' @rdname scale_party
#' @concept colors
#' @export
scale_color_party_b <- function(name = 'Vote share', midpoint = 0.5, limits = 0:1,
                                labels = label_party_pct(), oob = scales::squish,
                                reverse = FALSE, nice.breaks = FALSE, ...) {
  pal = ggredist$partisan
  if (reverse) pal$pal = rev(pal)
  pal_fun = scales::colour_ramp(pal)

  if (is.null(midpoint)) {
    rescaler = scales::rescale
  } else {
    rescaler = function(x, to=c(0, 1), from=range(x, na.rm=TRUE)) {
      scales::rescale_mid(x, to, from, midpoint)
    }
  }

  ggplot2::binned_scale("color", "party", name = name, limits = limits,
                        labels = labels, oob = oob, palette = pal_fun,
                        rescaler = rescaler, nice.breaks = nice.breaks, ...)
}


#' @rdname scale_party
#' @concept colors
#' @export
scale_colour_party_d = scale_color_party_d
#' @rdname scale_party
#' @concept colors
#' @export
scale_colour_party_c = scale_color_party_c
#' @rdname scale_party
#' @concept colors
#' @export
scale_colour_party_b = scale_color_party_b

adjacency = function(shp) {
  if (requireNamespace("geos", quietly=TRUE)) {
    shp <- geos::as_geos_geometry(shp)
    nby <- geos::geos_strtree_query(geos::geos_strtree(shp),
                                    shp)
    adj <- lapply(seq_len(length(shp)), function(i) {
      x <- geos::geos_relate(shp[[i]], shp[[nby[[i]]]])
      nby[[i]][geos::geos_relate_pattern_match(x, "F***1****") |
                 geos::geos_relate_pattern_match(x, "2121**2*2")]
    })
  } else if (requireNamespace("sf", quietly=TRUE)) {
    adj <- suppressMessages(sf::st_relate(shp, shp, pattern = "F***1****"))
    withinadj <- suppressMessages(sf::st_relate(x = shp, pattern = "2121**2*2"))
    adj <- lapply(1:nrow(shp), function(x) c(adj[[x]], withinadj[[x]]))
  } else {
    stop("`sf` is required.")
  }
  adj
}

#' Produce a Map Coloring
#'
#' Finds colors for every element of a shapefile so that adjacent elements don't
#' have the same color.
#'
#' @param shp an `sf` object
#' @param min_coloring if `TRUE`, try to minimize the number of colors used
#'
#' @returns an integer vector of the same length as `shp`, corresponding to the
#'   coloring.
#'
#' @examples
#' data(oregon)
#' map_coloring(head(oregon))
#'
#' @export
map_coloring = function(shp, min_coloring = TRUE) {
  adj <- adjacency(shp)
  N <- length(adj)
  degs <- lengths(adj)
  deg_ord <- order(degs, decreasing = isTRUE(min_coloring))

  colors <- 4L
  color <- integer(N)
  color[deg_ord[1]] <- 1L
  for (i in seq(2L, N)) {
    curr <- deg_ord[i]
    seen <- match(seq_len(colors), color[ adj[[curr]] ])
    idx <- which(is.na(seen))[1]
    if (is.na(idx)) {
      colors <- colors + 1L
      idx <- colors
    }
    color[curr] <- idx
  }

  color
}

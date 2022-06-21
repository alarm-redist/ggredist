#' Label Map Regions
#'
#' Aggregates shapefile according to the `group` aesthetic and positions labels
#' for each region defined by `group`.
#'
#' @param mapping Set of aesthetic mappings created by [aes()]
#' @param data The data to be displayed in this layer
#' @param geom The geometric object to use display the data
#' @param position Position adjustment
#' @param na.rm if `TRUE`, will silently remove missing values from calculations
#' @param show.legend Should this layer be included in the legends?
#' @param inherit.aes If `FALSE`, overrides the default aesthetics, rather than
#'   combining with them.
#' @param ... Passed onto the underlying geoms.
#'
#' @returns a `ggproto` object
#'
#' @examples
#' library(ggplot2)
#' data(oregon)
#'
#' ggplot(oregon, aes(group=county)) +
#'     geom_district() +
#'     geom_district_text() +
#'     scale_fill_penn82() +
#'     theme_map()
#'
#' @concept geoms
#' @name StatDistrictCoordinates
NULL

#' @export
#' @rdname StatDistrictCoordinates
#' @usage NULL
#' @format NULL
StatDistrictCoordinates <- ggplot2::ggproto(
  "StatDistrictCoordinates", ggplot2::Stat,

  compute_layer = function(self, data, params, layout) {
    # add coord to the params, so it can be forwarded to compute_group()
    params$coord <- layout$coord
    ggproto_parent(Stat, self)$compute_layer(data, params, layout)
  },

  compute_panel = function(self, data, scales, coord, adjust = 1.0) {
    if (!inherits(coord, "CoordSf")) {
      stop("`stat_districts()` can only be used with `coord_sf()`")
    }

    points_sfc <- sf::st_centroid(data$geometry)

    bbox <- sf::st_bbox(points_sfc)
    coord$record_bbox(
      xmin = bbox[["xmin"]], xmax = bbox[["xmax"]],
      ymin = bbox[["ymin"]], ymax = bbox[["ymax"]]
    )

    # transform to the coord's default crs if possible
    default_crs <- coord$get_default_crs()
    if (!(is.null(default_crs) || is.na(default_crs) ||
          is.na(sf::st_crs(points_sfc)))) {
      points_sfc <- sf::st_transform(points_sfc, default_crs)
    }

    xy <- as.data.frame(sf::st_coordinates(points_sfc))
    xy$area <- as.numeric(sf::st_area(data$geometry))
    xy$area <- xy$area / mean(xy$area)
    xy <- split(xy, data$group)
    centers = do.call(rbind, lapply(xy, function(d) {
      tot_area = sum(d$area)
      ctr_x = sum(d$X * d$area) / tot_area
      ctr_y = sum(d$Y * d$area) / tot_area
      idx = which.min((d$X - ctr_x)^2 + (d$Y - ctr_y)^2)
      data.frame(X = d$X[idx], Y = d$Y[idx],
                 area = tot_area)
    }))

    # locs <- as.matrix(centers[, 1:2])
    # locs <- scale(locs, scale=FALSE)
    # locs <- locs / sqrt(var(locs[,1]) + var(locs[,2]))
    # locs <<- locs
    # n <- nrow(locs)

    # pen = function(x) {
    #   x = matrix(x, nrow=n)
    #   dm = as.matrix(dist(x))
    #   pen_close = mean(vapply(seq_len(n), function(i) {
    #     mean(1 / (0.01 + dm[-i, i]))
    #   }, numeric(1)))
    #   pen_far = mean(1e5 * rowSums((x - locs)^2))
    #   print(c(pen_far, pen_close))
    #   pen_close + pen_far
    # }
    # res = optim(locs, pen)
    # print(res)

    data.frame(
      group = unique(data$group),
      x = centers$X,
      y = centers$Y,
      size = 1.25 * adjust * sqrt(centers$area)
    )
  },

  default_aes = ggplot2::aes(x = ggplot2::after_stat(x),
                             y = ggplot2::after_stat(y),
                             label = ggplot2::after_stat(group)),

  required_aes = c("geometry")
)

#' @rdname StatDistrictCoordinates
#' @concept geoms
#' @order 2
#' @export
stat_district_coordinates <- function(mapping = NULL, data = NULL, geom = "text",
                                      position = "identity", na.rm = FALSE,
                                      adjust = 1.0,
                                      show.legend = NA, inherit.aes = TRUE, ...) {
  ggplot2::layer_sf(
    stat = StatDistrictCoordinates, data = data, mapping = mapping, geom = geom,
    position = position, show.legend = show.legend, inherit.aes = inherit.aes,
    params = list(na.rm = na.rm, adjust = adjust, ...)
  )
}

#' @rdname StatDistrictCoordinates
#' @concept geoms
#' @order 2
#' @export
geom_district_text <- function(mapping = NULL, data = NULL,
                               position = "identity", na.rm = FALSE,
                               adjust = 1.0,
                               show.legend = NA, inherit.aes = TRUE, ...) {
  c(
    ggplot2::layer_sf(
      stat = StatDistrictCoordinates, data = data, mapping = mapping, geom = GeomText,
      position = position, show.legend = show.legend, inherit.aes = inherit.aes,
      params = list(na.rm = na.rm, adjust = adjust, ...)
    ),
    ggplot2::coord_sf(default = TRUE)
  )
}

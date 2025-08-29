#' Label Map Regions
#'
#' Aggregates shapefile according to the `group` aesthetic and positions labels
#' for each region defined by `group`. By default, labels will be sized in rough
#' proportion to the available area.
#'
#' @param mapping Set of aesthetic mappings created by [ggplot2::aes()]
#' @param data The data to be displayed in this layer
#' @param geom The geometric object to use display the data
#' @param position Position adjustment
#' @param na.rm if `TRUE`, will silently remove missing values from calculations
#' @param show.legend Should this layer be included in the legends?
#' @param inherit.aes If `FALSE`, overrides the default aesthetics, rather than
#'   combining with them.
#' @param adjust A multiplicative scaling factor for the default label sizes
#' @param label.padding Padding around label
#' @param label.r Radius of rounded corners
#' @param label.size Size of label border (mm)
#' @param check_overlap If `TRUE`, text that overlaps previous text in the same
#'   layer will not be plotted.
#' @param parse If `TRUE`, the labels will be parsed into expressions and
#'   displayed as described in [`?plotmath`][grDevices::plotmath].
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
#'     scale_fill_randmcnally() +
#'     theme_map()
#'
#' ggplot(oregon, aes(group=cd_2020)) +
#'   geom_district(lwd=0.9, color="#442222") +
#'   geom_district(aes(group=county), lwd=0.4, lty="dashed", fill=NA) +
#'   geom_district_text(aes(group=county, label=toupper(county)),
#'                      size=2.2, check_overlap=TRUE) +
#'   geom_district_text(adjust=2) +
#'   scale_fill_penn82() +
#'   theme_map()
#'
#' @concept geoms
#' @name StatDistrictCoordinates
NULL


# Helper to find best label location
# takes in d, with X, Y + area for every precinct's center
# returns a 1-row data frame with X,Y for label + estimated size
find_label_loc = function(d) {
  tot_area = sum(d$area)
  bbox = cbind(range(d$X), range(d$Y))

  sc = c(diff(bbox[, 1]), diff(bbox[, 2]))
  if (any(sc == 0)) {
    return(data.frame(X = weighted.mean(d$X, d$area),
                      Y = weighted.mean(d$Y, d$area),
                      size = tot_area))
  }

  # rescale to 0-1 and construct edge
  hull_idx = grDevices::chull(d$X, d$Y)
  hull = data.frame(X = (d$X[hull_idx] - bbox[1, 1]) / sc[1],
                    Y = (d$Y[hull_idx] - bbox[1, 2]) / sc[2])
  hull = data.frame(X = approx(c(hull$X, hull$X[1]), n=60)$y,
                    Y = approx(c(hull$Y, hull$Y[1]), n=60)$y)

  # maximize minimum distance to edge
  res = optim(c(0.5, 0.5), function(pt) {
    -min((pt[1] - hull$X)^2 + (pt[2] - hull$Y)^2)
  })
  ctr = bbox[1, ] + res$par * sc # scale back
  # average with centroid
  centroid = c(weighted.mean(d$X, d$area), weighted.mean(d$Y, d$area))
  ctr = 0.6*ctr + 0.4*centroid
  # ctr = 0.8*ctr + 0.2*centroid

  # find nearest precincts to center...
  dists = abs(d$X - ctr[1]) + abs(d$Y - ctr[2])
  idx = head(order(dists), 5)

  # ... and take a distance/area -weighted average
  wts = (d$area[idx])^(1/4) / (1e-6 + dists[idx])
  data.frame(X = weighted.mean(d$X[idx], wts),
             Y = weighted.mean(d$Y[idx], wts),
             size = tot_area)
}


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

    # find closest unit to the centroid of each group
    xy <- as.data.frame(sf::st_coordinates(points_sfc))
    xy$area <- as.numeric(sf::st_area(data$geometry))
    xy$area <- xy$area / mean(xy$area)
    xy <- split(xy, data$group)
    centers = do.call(rbind, lapply(xy, find_label_loc))

    out = data.frame(
      group = rownames(centers),
      x = centers$X,
      y = centers$Y,
      size = adjust * 20 * (centers$size / sum(centers$size))^(1/3)
    )

    if (!is.null(data$label)) {
      out$label = tapply(data$label, data$group, function(y) y[1])
    }
    if (!is.null(data$color)) {
      out$color = tapply(data$color, data$group, function(y) y[1])
    }

    out
  },

  default_aes = ggplot2::aes(x = ggplot2::after_stat(x),
                             y = ggplot2::after_stat(y),
                             label = ggplot2::after_stat(group)),

  required_aes = c("geometry")
)


#' @export
#' @rdname StatDistrictCoordinates
#' @usage NULL
#' @format NULL
GeomDistrictText <- ggplot2::ggproto(
  "GeomDistrictText", ggplot2::GeomText,

  default_aes = ggplot2::aes(
    colour = "black",
    size = 4,
    angle = 0,
    hjust = 0.5,
    vjust = 0.5,
    alpha = 0.6,
    family = "",
    fontface = "bold",
    lineheight = 1.0
  )
)


#' @rdname StatDistrictCoordinates
#' @concept geoms
#' @order 3
#' @export
stat_district_coordinates <- function(mapping = NULL, data = NULL, geom = "text",
                                      position = "identity", na.rm = FALSE,
                                      adjust = 1.0,
                                      show.legend = NA, inherit.aes = TRUE, ...) {
  ggplot2::layer_sf(
    stat = StatDistrictCoordinates, data = data, mapping = mapping, geom = geom,
    position = position, show.legend = show.legend, inherit.aes = inherit.aes,
      params = list(na.rm = na.rm,
                    adjust = adjust,
                    ...)
  )
}

#' @rdname StatDistrictCoordinates
#' @concept geoms
#' @order 1
#' @export
geom_district_text <- function(mapping = NULL, data = NULL,
                               position = "identity", na.rm = FALSE,
                               adjust = 1.0,
                               check_overlap = FALSE, parse = FALSE,
                               show.legend = NA, inherit.aes = TRUE, ...) {
  c(
    ggplot2::layer_sf(
      stat = StatDistrictCoordinates, data = data, mapping = mapping, geom = GeomDistrictText,
      position = position, show.legend = show.legend, inherit.aes = inherit.aes,
      params = list(na.rm = na.rm,
                    parse = parse,
                    check_overlap = check_overlap,
                    adjust = adjust,
                    ...)
    ),
    ggplot2::coord_sf(default = TRUE)
  )
}


#' @rdname StatDistrictCoordinates
#' @concept geoms
#' @order 2
#' @export
geom_district_label <- function(mapping = NULL, data = NULL,
                                position = "identity", na.rm = FALSE,
                                label.padding = ggplot2::unit(0.25, "lines"),
                                label.r = ggplot2::unit(0.15, "lines"),
                                label.size = 0.25,
                                check_overlap = FALSE, parse = FALSE,
                                adjust = 1.0,
                                show.legend = NA, inherit.aes = TRUE, ...) {
  c(
    ggplot2::layer_sf(
      stat = StatDistrictCoordinates, data = data, mapping = mapping, geom = ggplot2::GeomLabel,
      position = position, show.legend = show.legend, inherit.aes = inherit.aes,
      params = list(na.rm = na.rm,
                    label.padding = label.padding,
                    label.r = label.r,
                    label.size = label.size,
                    parse = parse,
                    check_overlap = check_overlap,
                    adjust = adjust,
                    ...)
    ),
    ggplot2::coord_sf(default = TRUE)
  )
}



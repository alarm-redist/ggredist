#' Aggregate and Plot Map Regions
#'
#' Aggregates shapefile according to the `group` aesthetic. If just `group` is
#' provided, then by default map regions will be colored by `group` (set `fill`
#' to force a particular color, or `NA` for no fill).  If `fill` is provided,
#' the values in `fill` will be summed within the groups defined by `group`.
#' If `denom` is provided, the values in `denom` will be summed within the
#' groups defined by `group`, and then used to divide the summed values of `fill`.
#' For example, `fill` and `denom` can be used together to plot the partisan
#' or demographic characteristics congressional districts (see examples).
#'
#' @param mapping Set of aesthetic mappings created by [aes()]
#' @param data The data to be displayed in this layer
#' @param geom The geometric object to use display the data
#' @param position Position adjustment
#' @param na.rm if `TRUE`, will silently remove missing values from calculations
#' @param is_coverage As in [sf::st_union()]. May speed up plotting for large
#'   shapefiles if `geos` is not installed or the shapefile is not projected.
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
#' ggplot(oregon, aes(group=cd_2020)) +
#'     geom_districts() +
#'     scale_fill_penn82() +
#'     theme_map()
#'
#' ggplot(oregon, aes(group=cd_2020, fill=pop)) +
#'     geom_districts() +
#'     theme_map()
#'
#' ggplot(oregon, aes(group=cd_2020, fill=ndv, denom=ndv+nrv)) +
#'     geom_districts() +
#'     scale_fill_party_c(limits=c(0.4, 0.6)) +
#'     theme_map()
#'
#' @concept geoms
#' @name StatDistricts
NULL

# mapping = NULL, data = NULL, geom = "districts",
# position = "identity", na.rm = FALSE, is_coverage = FALSE,
# show.legend = NA, inherit.aes = TRUE, ...)


# original ggplot2:::geom_column from (c) 2020 ggplot2 authors
geom_column <- function (data) {
  w <- which(vapply(data, inherits, TRUE, what = "sfc"))
  if (length(w) == 0) {
    "geometry"
  } else {
    if (length(w) > 1)
      warn("more than one geometry column present: taking the first")
    w[[1]]
  }
}


StatDistricts <- ggplot2::ggproto("StatDistricts", ggplot2::Stat,

  setup_params = function(data, params) {
    if (!is.null(params$fill)) {
      if (is.na(params$fill)) {
        params$fill = NA_character_
      }
    }

    params
  },

  compute_layer = function(self, data, params, layout) {
    if (all(data$group == -1)) data$group = 1
    data$group = factor(data$group)
    # add coord to the params, so it can be forwarded to compute_group()
    params$coord <- layout$coord
    ggproto_parent(Stat, self)$compute_layer(data, params, layout)
  },

  # st_union by group
  compute_group = function(data, scales, coord, na.rm=FALSE, is_coverage=FALSE, fill=NULL) {
    geometry_data = data[[geom_column(data)]]
    geometry_crs = sf::st_crs(geometry_data)

    if (!inherits(coord, "CoordSf")) {
      stop("`stat_districts()` can only be used with `coord_sf()`")
    }

    if (!is.null(fill)) {
      fill = NULL
    } else if (is.null(data$fill)) {
      fill = data$group[1]
    } else if (is.numeric(data$fill)) {
      fill = sum(data$fill, na.rm=na.rm)
      if (!is.null(data$denom)) {
        fill = fill / sum(data$denom, na.rm=na.rm)
      }
    } else {
      fill = data$fill[1]
    }

    if (isFALSE(sf::st_is_longlat(sf::st_geometry(geometry_data))) && # planar
                requireNamespace("geos", quietly=TRUE)) {
      merged_geom = sf::st_as_sf(
        geos::geos_unary_union(
          geos::geos_make_collection(geometry_data)
        )
      )
    } else {
      merged_geom = sf::st_union(geometry_data, is_coverage=is_coverage)
    }

    out = data.frame(
      group = data$group[1],
      geometry = merged_geom
    )
    if (!is.null(fill)) out$fill = fill

    bbox = sf::st_bbox(out$geometry)
    # copied from StatSf <https://github.com/tidyverse/ggplot2/blob/main/R/stat-sf.R>
    coord$record_bbox(
      xmin = bbox[["xmin"]], xmax = bbox[["xmax"]],
      ymin = bbox[["ymin"]], ymax = bbox[["ymax"]]
    )
    bbox_trans <- sf_transform_xy(
      list(
        x = c(rep(0.5*(bbox[["xmin"]] + bbox[["xmax"]]), 2), bbox[["xmin"]], bbox[["xmax"]]),
        y = c(bbox[["ymin"]], bbox[["ymax"]], rep(0.5*(bbox[["ymin"]] + bbox[["ymax"]]), 2))
      ),
      coord$get_default_crs(),
      geometry_crs
    )
    out$xmin <- min(bbox_trans$x)
    out$xmax <- max(bbox_trans$x)
    out$ymin <- min(bbox_trans$y)
    out$ymax <- max(bbox_trans$y)

    out
  },

  optional_aes = c("fill", "denom"),

  required_aes = c("geometry")
)

GeomDistricts <- ggplot2::ggproto("GeomDistricts", ggplot2::GeomSf,
  default_aes = ggplot2::aes(
    colour = "#222222",
    fill = NULL,
    size = NULL,
    linewidth = NULL,
    linetype = 1,
    alpha = NA,
    stroke = 0.8
  ),
  optional_aes = c("fill", "denom"),
  required_aes = c("geometry")
)


#' @rdname StatDistricts
#' @concept geoms
#' @export
stat_districts <- function(mapping = NULL, data = NULL, geom = "districts",
                           position = "identity", na.rm = FALSE, is_coverage = FALSE,
                           show.legend = NA, inherit.aes = TRUE, ...) {
  ggplot2::layer_sf(
    stat = StatDistricts, data = data, mapping = mapping, geom = geom,
    position = position, show.legend = show.legend, inherit.aes = inherit.aes,
    params = list(na.rm = na.rm, is_coverage = is_coverage, ...)
  )
}

#' @rdname StatDistricts
#' @concept geoms
#' @export
geom_districts <- function(mapping = NULL, data = NULL,
                           position = "identity", na.rm = FALSE, is_coverage = FALSE,
                           show.legend = NA, inherit.aes = TRUE, ...) {
  c(
    ggplot2::layer_sf(
      stat = StatDistricts, data = data, mapping = mapping, geom = GeomDistricts,
      position = position, show.legend = show.legend, inherit.aes = inherit.aes,
      params = list(na.rm = na.rm, is_coverage = is_coverage, ...)
    ),
    ggplot2::coord_sf(default = TRUE)
  )
}

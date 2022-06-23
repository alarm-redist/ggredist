#' Aggregate and Plot Map Regions
#'
#' Aggregates shapefile according to the `group` aesthetic. If just `group` is
#' provided, then by default map regions will be colored by `group` so that
#' adjacent regions do not share a color (set `fill` to force a particular
#' color, or `NA` for no fill).  If `fill` is provided, the values in `fill`
#' will be summed within the groups defined by `group`. If `denom` is provided,
#' the values in `denom` will be summed within the groups defined by `group`,
#' and then used to divide the summed values of `fill`. For example, `fill` and
#' `denom` can be used together to plot the partisan or demographic
#' characteristics congressional districts (see examples).
#'
#' @param mapping Set of aesthetic mappings created by [aes()]
#' @param data The data to be displayed in this layer
#' @param geom The geometric object to use display the data
#' @param position Position adjustment
#' @param na.rm if `TRUE`, will silently remove missing values from calculations
#' @param is_coverage As in [sf::st_union()]. May speed up plotting for large
#'   shapefiles if `geos` is not installed or the shapefile is not projected.
#' @param min_col If `TRUE`, try to minimize the number of colors used. May
#'   be necessary for short palettes.
#' @param buffer Optionally buffer the merged geometries. Negative values will
#'   shrink geometries towards the center and can be used for a "glowing
#'   boundary" effect (see examples).
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
#'     scale_fill_penn82() +
#'     theme_map()
#'
#' ggplot(oregon, aes(group=county, fill=pop)) +
#'     geom_district() +
#'     theme_map()
#'
#' ggplot(oregon, aes(group=cd_2020, fill=ndv, denom=ndv+nrv)) +
#'     geom_district() +
#'     scale_fill_party_c(limits=c(0.4, 0.6)) +
#'     theme_map()
#'
#' ggplot(oregon, aes(group=county)) +
#'     geom_district() +
#'     geom_district(buffer=-5000, fill="#ffffffcc", color=NA) +
#'     scale_fill_natgeo() +
#'     theme_map()
#'
#' @concept geoms
#' @name StatDistrict
NULL


# original ggplot2:::geom_column from (c) 2020 ggplot2 authors
geom_column <- function (data) {
  w <- which(vapply(data, inherits, TRUE, what = "sfc"))
  if (length(w) == 0) {
    "geometry"
  } else {
    if (length(w) > 1)
      warning("more than one geometry column present: taking the first")
    w[[1]]
  }
}


#' @export
#' @rdname StatDistrict
#' @usage NULL
#' @format NULL
StatDistrict <- ggplot2::ggproto(
  "StatDistrict", ggplot2::Stat,

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

    geometry_data = data[[geom_column(data)]]
    params$crs = sf::st_crs(geometry_data)

    if (isFALSE(sf::st_is_longlat(geometry_data)) && # planar
        requireNamespace("geos", quietly=TRUE)) {
      merged_geom = sf::st_as_sfc(
        tapply(geometry_data, data$group, function(x) {
          sf::st_as_sfc(geos::geos_unary_union(geos::geos_make_collection(x)))
        }),
        crs = params$crs)
    } else {
      merged_geom = sf::st_as_sfc(
        tapply(geometry_data, data$group, sf::st_union,
               is_coverage=params$is_coverage),
        crs = params$crs)
    }
    names(merged_geom) <- NULL

    if (nlevels(data$group) <= 6) {
      params$coloring <- levels(data$group)
    } else {
      params$coloring <- map_coloring(merged_geom, params$min_col)
    }

    if (params$buffer != 0) {
      merged_geom <- sf::st_buffer(merged_geom, params$buffer)
    }

    params$merged_geom <- merged_geom

    # add coord to the params, so it can be forwarded to compute_group()
    params$coord <- layout$coord
    ggproto_parent(Stat, self)$compute_layer(data, params, layout)
  },

  # st_union by group
  compute_group = function(data, scales, coord, crs, merged_geom, coloring,
                           na.rm=FALSE, is_coverage=FALSE, min_col=FALSE,
                           buffer=0, fill=NULL) {
    if (!inherits(coord, "CoordSf")) {
      stop("`stat_districts()` can only be used with `coord_sf()`")
    }

    grp = data$group[1]
    if (!is.null(fill)) {
      fill = NULL
    } else if (is.null(data$fill)) {
      fill = factor(coloring[as.integer(grp)], levels=unique(coloring))
    } else if (is.numeric(data$fill)) {
      fill = sum(data$fill, na.rm=na.rm)
      if (!is.null(data$denom)) {
        fill = fill / sum(data$denom, na.rm=na.rm)
      }
    } else {
      fill = data$fill[1]
    }

    out = data.frame(
      group = grp,
      geometry = sf::st_sf(geometry=merged_geom[grp])
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
      crs
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

#' @export
#' @rdname StatDistrict
#' @usage NULL
#' @format NULL
GeomDistrict <- ggplot2::ggproto(
  "GeomDistrict", ggplot2::GeomSf,

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


#' @rdname StatDistrict
#' @concept geoms
#' @order 2
#' @export
stat_district <- function(mapping = NULL, data = NULL, geom = GeomDistrict,
                          position = "identity", na.rm = FALSE,
                          is_coverage = FALSE, min_col= FALSE, buffer = 0,
                          show.legend = NA, inherit.aes = TRUE, ...) {
  ggplot2::layer_sf(
    stat = StatDistrict, data = data, mapping = mapping, geom = geom,
    position = position, show.legend = show.legend, inherit.aes = inherit.aes,
    params = list(na.rm = na.rm,
                  is_coverage = is_coverage,
                  min_col = min_col,
                  buffer = buffer,
                  ...)
  )
}

#' @rdname StatDistrict
#' @concept geoms
#' @order 1
#' @export
geom_district <- function(mapping = NULL, data = NULL,
                          position = "identity", na.rm = FALSE,
                          is_coverage = FALSE, min_col = FALSE, buffer = 0,
                          show.legend = NA, inherit.aes = TRUE, ...) {
  c(
    ggplot2::layer_sf(
      stat = StatDistrict, data = data, mapping = mapping, geom = GeomDistrict,
      position = position, show.legend = show.legend, inherit.aes = inherit.aes,
      params = list(na.rm = na.rm,
                    is_coverage = is_coverage,
                    min_col = min_col,
                    buffer = buffer,
                    ...)
    ),
    ggplot2::coord_sf(default = TRUE)
  )
}

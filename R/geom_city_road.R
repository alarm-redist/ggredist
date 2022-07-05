#' Annotate a Map with Roads and Cities
#'
#' Clips the [interstates] and [cities] datasets to the bounding box of the
#' map and plots them.
#'
#' @param mapping Set of aesthetic mappings created by [aes()]
#' @param data The data to be displayed in this layer
#' @param geom The geometric object to use display the data
#' @param position Position adjustment
#' @param na.rm if `TRUE`, will silently remove missing values from calculations
#' @param adjust A multiplicative scaling factor for the default label sizes
#' @param min_pop The minimum population a city must have had in 2006 to be shown.
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
#'   geom_district() +
#'   stat_interstates(size=1.4, color="#0044aa55") +
#'   stat_cities(geom="text", min_pop=130e3, fontface="bold", adjust=0.8) +
#'   scale_fill_penn82() +
#'   theme_map()
#'
#' @concept geoms
#' @name StatCityRoad
NULL


#' @export
#' @rdname StatCityRoad
#' @usage NULL
#' @format NULL
StatCities <- ggplot2::ggproto(
  "StatCities", ggplot2::Stat,

  compute_layer = function(self, data, params, layout) {
    # add coord to the params, so it can be forwarded to compute_group()
    params$coord <- layout$coord
    ggproto_parent(Stat, self)$compute_layer(data, params, layout)
  },

  # st_union by group
  compute_panel = function(data, scales, coord, min_pop = 100e3, adjust = 1.0) {
    if (!inherits(coord, "CoordSf")) {
      stop("`stat_districts()` can only be used with `coord_sf()`")
    }

    geom_data = data[[geom_column(data)]]
    geom_crs = sf::st_crs(geom_data)

    bbox = sf::st_bbox(geom_data)

    city_d = suppressWarnings(sf::st_crop(
      sf::st_transform(cities[cities$pop_2020 >= min_pop, ], geom_crs),
      bbox
    ))
    out = data.frame(label = city_d$name,
                     shape = c(16, 8)[1 + city_d$capital],
                     size = adjust * 0.01 * sqrt(city_d$pop_2020),
                     geometry = city_d$geometry)

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
      geom_crs
    )
    out$xmin <- min(bbox_trans$x)
    out$xmax <- max(bbox_trans$x)
    out$ymin <- min(bbox_trans$y)
    out$ymax <- max(bbox_trans$y)

    xy <- as.data.frame(sf::st_coordinates(out$geometry))
    out$x <- xy$X
    out$y <- xy$Y

    out
  },

  default_aes = ggplot2::aes(x = ggplot2::after_stat(x),
                             y = ggplot2::after_stat(y)),

  required_aes = c("geometry")
)


#' @rdname StatCityRoad
#' @concept geoms
#' @order 2
#' @export
stat_cities <- function(mapping = NULL, data = NULL, geom = ggplot2::GeomSf,
                        position = "identity", na.rm = FALSE,
                        adjust = 1.0, min_pop = 100e3,
                        show.legend = NA, inherit.aes = TRUE, ...) {
  ggplot2::layer_sf(
    stat = StatCities, data = data, mapping = mapping, geom = geom,
    position = position, show.legend = show.legend, inherit.aes = inherit.aes,
    params = list(na.rm = na.rm,
                  adjust = adjust,
                  min_pop = min_pop,
                  ...)
  )
}


#' @export
#' @rdname StatCityRoad
#' @usage NULL
#' @format NULL
StatInterstates <- ggplot2::ggproto(
  "StatInterstates", ggplot2::Stat,

  compute_layer = function(self, data, params, layout) {
    # add coord to the params, so it can be forwarded to compute_group()
    params$coord <- layout$coord
    ggproto_parent(Stat, self)$compute_layer(data, params, layout)
  },

  # st_union by group
  compute_panel = function(data, scales, coord) {
    if (!inherits(coord, "CoordSf")) {
      stop("`stat_districts()` can only be used with `coord_sf()`")
    }

    geom_data = data[[geom_column(data)]]
    geom_crs = sf::st_crs(geom_data)

    bbox = sf::st_bbox(geom_data)

    road_d = suppressWarnings(sf::st_crop(
      sf::st_transform(roads, geom_crs),
      bbox
    ))
    out = data.frame(geometry = road_d$geometry)

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
      geom_crs
    )
    out$xmin <- min(bbox_trans$x)
    out$xmax <- max(bbox_trans$x)
    out$ymin <- min(bbox_trans$y)
    out$ymax <- max(bbox_trans$y)

    out
  },

  required_aes = c("geometry")
)

#' @rdname StatCityRoad
#' @concept geoms
#' @order 2
#' @export
stat_interstates <- function(mapping = NULL, data = NULL, geom = ggplot2::GeomSf,
                        position = "identity", na.rm = FALSE,
                        show.legend = NA, inherit.aes = TRUE, ...) {
  ggplot2::layer_sf(
    stat = StatInterstates, data = data, mapping = mapping, geom = geom,
    position = position, show.legend = show.legend, inherit.aes = inherit.aes,
    params = list(na.rm = na.rm, ...)
  )
}

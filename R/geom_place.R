#' Emphasize Populated Regions of a Map with greyed out Places
#'
#' Identifies relevant census places and plots them.
#'
#' @param mapping Set of aesthetic mappings created by [aes()]
#' @param data The data to be displayed in this layer
#' @param geom The geometric object to use display the data
#' @param position Position adjustment
#' @param na.rm if `TRUE`, will silently remove missing values from calculations
#' @param state state to use. Guesses based on overlap if not provided.
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
#' ggplot(oregon, aes(group = cd_2020)) +
#'   geom_district() +
#"   stat_places(state = 'OR') +
#'   theme_map()
#' ggplot(oregon, aes(group = cd_2020)) +
#'   geom_district() +
#"   geom_places(state = 'OR') +
#'   theme_map()
#'
#' @concept geoms
#' @name StatPlaces
NULL

#' @export
#' @rdname StatPlaces
#' @usage NULL
#' @format NULL
StatPlaces <- ggplot2::ggproto(
  'StatPlaces', ggplot2::Stat,
  compute_layer = function(self, data, params, layout) {
    # add coord to the params, so it can be forwarded to compute_group()
    params$coord <- layout$coord
    ggproto_parent(Stat, self)$compute_layer(data, params, layout)
  },

  # st_union by group
  compute_panel = function(data, scales, coord, state = params$state) {
    if (!inherits(coord, 'CoordSf')) {
      stop('`stat_places()` can only be used with `coord_sf()`')
    }

    geom_data <- data[[geom_column(data)]]
    geom_crs <- sf::st_crs(geom_data)

    bbox <- sf::st_bbox(geom_data)

    if (is.null(state)) {
      state <- small_states$STATEFP[which(lengths(sf::st_overlaps(sf::st_transform(small_states, geom_crs), geom_data)) > 0)]
    }

    state_d <- do.call('rbind', lapply(state, tinytiger::tt_places))

    out <- suppressWarnings(sf::st_crop(
      sf::st_transform(state_d, geom_crs),
      bbox
    ))

    # copied from StatSf <https://github.com/tidyverse/ggplot2/blob/main/R/stat-sf.R>
    coord$record_bbox(
      xmin = bbox[['xmin']], xmax = bbox[['xmax']],
      ymin = bbox[['ymin']], ymax = bbox[['ymax']]
    )
    bbox_trans <- sf_transform_xy(
      list(
        x = c(rep(0.5 * (bbox[['xmin']] + bbox[['xmax']]), 2), bbox[['xmin']], bbox[['xmax']]),
        y = c(bbox[['ymin']], bbox[['ymax']], rep(0.5 * (bbox[['ymin']] + bbox[['ymax']]), 2))
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
  default_aes = ggplot2::aes(
    fill = "#00000033",
    color = NA,
    size = 0
  ),
    required_aes = c('geometry')
)

#' @rdname StatPlaces
#' @concept geoms
#' @export
stat_places <- function(mapping = NULL, data = NULL, geom = ggplot2::GeomSf,
                        position = 'identity', na.rm = FALSE, state = NULL,
                        show.legend = NA, inherit.aes = TRUE, ...) {
  ggplot2::layer_sf(
    stat = StatPlaces, data = data, mapping = mapping, geom = geom,
    position = position, show.legend = show.legend, inherit.aes = inherit.aes,
    params = list(na.rm = na.rm, state = state, ...)
  )
}

#' @export
#' @rdname StatPlaces
#' @usage NULL
#' @format NULL
GeomPlaces <- ggplot2::ggproto(
  "GeomPlaces", ggplot2::GeomSf,
  default_aes = ggplot2::aes(
    colour = NA,
    fill = "#00000033",
    size = 0,
    #linewidth = NULL,
    linetype = 1,
    alpha = NA,
    stroke = 0.8
  ),
  required_aes = c("geometry")
)

#' @rdname StatPlaces
#' @concept geoms
#' @order 1
#' @export
geom_places <- function(mapping = NULL, data = NULL,
                        position = "identity", na.rm = FALSE,
                        state = NULL,
                        show.legend = NA, inherit.aes = TRUE, ...) {
  c(
    ggplot2::layer_sf(
      stat = StatPlaces, data = data, mapping = mapping, geom = GeomPlaces,
      position = position, show.legend = show.legend, inherit.aes = inherit.aes,
      params = list(na.rm = na.rm,
                    state = state,
                    ...)
    ),
    ggplot2::coord_sf(default = TRUE)
  )
}

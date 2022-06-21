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

  compute_layer = function(self, data, params, layout) {
    # add coord to the params, so it can be forwarded to compute_group()
    params$coord <- layout$coord
    ggproto_parent(Stat, self)$compute_layer(data, params, layout)
  },

  # st_union by group
  compute_group = function(data, scales, coord, na.rm=FALSE, is_coverage=FALSE) {
    geometry_data = data[[geom_column(data)]]
    geometry_crs = sf::st_crs(geometry_data)

    if (is.null(data$fill)) {
        fill = as.character(data$group[1])
    } else {
      fill = sum(data$fill, na.rm=na.rm)
      if (!is.null(data$denom)) {
        fill = fill / sum(data$denom, na.rm=na.rm)
      }
    }

    out = data.frame(
      group = data$group[1],
      fill = fill,
      geometry = sf::st_union(geometry_data, is_coverage=is_coverage)
    )

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

  required_aes = c("group", "geometry")
)


stat_districts <- function(mapping = NULL, data = NULL, geom = "sf",
                           position = "identity", na.rm = FALSE, is_coverage = FALSE,
                           show.legend = NA, inherit.aes = TRUE, ...) {
  ggplot2::layer(
    stat = StatDistricts, data = data, mapping = mapping, geom = geom,
    position = position, show.legend = show.legend, inherit.aes = inherit.aes,
    params = list(na.rm = na.rm, is_coverage = is_coverage, ...)
  )
}

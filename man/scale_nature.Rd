% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/nature.R
\name{scale_fill_coast}
\alias{scale_fill_coast}
\alias{scale_color_coast}
\alias{scale_colour_coast}
\alias{scale_fill_larch}
\alias{scale_color_larch}
\alias{scale_colour_larch}
\title{Nature-derived Color Scales for \code{ggplot2}}
\usage{
scale_fill_coast(...)

scale_color_coast(...)

scale_colour_coast(...)

scale_fill_larch(...)

scale_color_larch(...)

scale_colour_larch(...)
}
\arguments{
\item{...}{Arguments passed on to \code{\link[ggplot2:discrete_scale]{ggplot2::discrete_scale()}}}
}
\value{
ggplot scale function
}
\description{
Nature-derived Color Scales for \code{ggplot2}
}
\examples{
library(ggplot2)
data(oregon)

ggplot(oregon, aes(group = county)) +
    geom_district() +
    scale_fill_coast() +
    theme_map()

ggplot(oregon, aes(group = county)) +
    geom_district() +
    scale_fill_larch() +
    theme_map()

}
\concept{colors}

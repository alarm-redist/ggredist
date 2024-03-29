% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/538.R
\name{scale_fill_538}
\alias{scale_fill_538}
\alias{scale_color_538}
\title{FiveThirtyEight scales for \code{ggplot2}}
\usage{
scale_fill_538(...)

scale_color_538(...)
}
\arguments{
\item{...}{additional arguments to \verb{ggplot::scale_*} functions}
}
\value{
ggplot scale function
}
\description{
FiveThirtyEight scales for \code{ggplot2}
}
\examples{
library(ggplot2)
data(oregon)

ggplot(oregon, aes(fill = ndv / (ndv + nrv))) +
    geom_sf(size = 0) +
    scale_fill_538(name = '') +
    theme_map()
}
\concept{colors}

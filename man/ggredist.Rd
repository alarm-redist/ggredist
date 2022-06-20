% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/colors.R
\docType{data}
\name{ggredist}
\alias{ggredist}
\title{Redistricting Color Palettes}
\format{
list of character vectors of type \code{palette} (which supports a
\code{plot()} generic for visualization)
}
\usage{
ggredist
}
\description{
Included palettes:
\itemize{
\item \strong{partisan}, a perceptually uniform red-white-blue scale
\item \strong{dra}, the Dave's Redistricting App classic color palette
\item \strong{penn82}, Historic categorical color palette from the 1982 published Pennsylvania
congressional district map
}
}
\examples{
plot(ggredist$partisan)
plot(ggredist$dra)
plot(ggredist$penn82)

}
\keyword{datasets}
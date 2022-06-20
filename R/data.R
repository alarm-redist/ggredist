#' Oregon Redistricting File
#'
#' This data contains geographic, demographic, and political information on the
#' 1,071 census tracts of the state of Oregon.
#'
#' @name oregon
#' @usage data("oregon")
#' @format `sf` object

#' \describe{
#' \item{\code{county}}{The county the tract belongs to.}
#' \item{\code{cd_2020}}{The 2210 congressional district assignment for the tract.}
#' \item{\code{pop}}{The total population of the tract, according to the 2020 Census.}
#' \item{\code{pop_white}}{The non-Hispanic white population of the precinct.}
#' \item{\code{ndv}}{Average number of votes for Democratic candidates in recent statewide elections.}
#' \item{\code{nrv}}{Average number of votes for Republican candidates in recent statewide elections.}
#' \item{\code{geometry}}{The `sf` geometry column containing the geographic information.}
#' }
#'
#' @examples
#' data(oregon)
#' oregon[, 1:6] # final column requires `sf` library
NULL

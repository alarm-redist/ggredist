#' Oregon Redistricting File
#'
#' This data contains geographic, demographic, and political information on the
#' 1,071 census tracts of the state of Oregon.
#'
#' @name oregon
#' @usage data("oregon")
#' @concept data
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
#' oregon[, 1:6]
NULL

#' Insterstate Shapefile
#'
#' This data contains geometry information for the U.S. Interstate Highway System.
#' It was processed from the U.S. Census Bureau TIGER/Line Shapefile system.
#'
#' @name interstates
#' @usage data("interstates")
#' @concept data
#' @format `sf` object

#' \describe{
#' \item{\code{name}}{Census Bureau name for the interstate}
#' \item{\code{geometry}}{The `sf` geometry column containing the geographic information.}
#' }
#'
#' @examples
#' data(interstates)
NULL

#' U.S. Cities
#'
#' This data contains the location, name, and 2020 population of U.S. cities and
#' large towns.
#'
#' @name cities
#' @usage data("cities")
#' @concept data
#' @format `sf` object

#' \describe{
#' \item{\code{name}}{City name.}
#' \item{\code{state}}{City state.}
#' \item{\code{pop_2020}}{City population in 2020}
#' \item{\code{GEOID}}{Census GEOID for the corresponding Census Designated Place.}
#' \item{\code{geometry}}{The `sf` geometry column containing the geographic information.}
#' }
#'
#' @examples
#' data(cities)
NULL

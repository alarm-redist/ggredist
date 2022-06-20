make_bins <- function(v, pal, where) {
  force(v)
  pal[as.integer(cut(v, where))]
}

# `plot.palette` modified from that in `wesanderson` (c) 2016 Karthik Ram
#' @export
#' @importFrom graphics rect par image text
plot.palette = function(x, ...) {
  n <- length(x)
  old <- par(mar=c(0.5, 0.5, 0.5, 0.5))
  on.exit(par(old))

  image(1:n, 1, as.matrix(1:n), col=x,
        ylab="", xaxt="n", yaxt="n", bty="n")

  rect(0, 0.9, n + 1, 1.1, col=grDevices::rgb(1, 1, 1, 0.8), border=NA)
  text((n + 1) / 2, 1, labels=deparse(substitute(x)), col="black", cex=1, font=2)

  if (!is.null(names(x)))
    text(1:n, 1.25, labels=names(x), col="black", cex=1)
}

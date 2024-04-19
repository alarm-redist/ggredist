make_bins <- function(v, pal, where) {
  force(v)
  pal[as.integer(cut(v, where))]
}

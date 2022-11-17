make_bins <- function(v, pal, where) {
  force(v)
  pal[as.integer(cut(v, where))]
}

rot_pal <- function(pal) {
  function(n) {
    if (n <= length(pal)) {
      pal[seq_len(n)]
    } else {
      rep(pal, ceiling(n / length(pal)))[seq_len(n)]
    }
  }
}

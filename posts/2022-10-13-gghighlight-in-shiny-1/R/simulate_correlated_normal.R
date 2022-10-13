#' Simulate Correlated Data
#' 
#' Simulates `n` by `p` multivariate normal data with
#'   suggested correlation.
#' 
#' @param n integer. Number of observations.
#' @param p integer. Number of variables.
#' @param offdiag numeric, between 0 and 1. Informs correlation matrix.
simulate_correlated_normal <- function(n = 50, p = 30, offdiag = 0.95) {
  mu <- rep(0, p)
  Sigma <- diag(1 - offdiag, p) + matrix(offdiag, p, p)
  
  as.data.frame(MASS::mvrnorm(n, mu, Sigma))
}

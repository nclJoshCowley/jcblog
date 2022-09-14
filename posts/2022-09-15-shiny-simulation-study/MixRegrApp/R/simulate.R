#' Mixture of Regressions
#'
#' Simulate from `K` (`length(groups)`) distinct regressions based on group
#'   membership variable `z`.
#'
#' That is,
#'   \eqn{Y_i \sim N(x_i * regr_{i, z_i}, sd^2)}
#'
#' @param x matrix. Design matrix.
#' @param z integer. Group membership variable.
#' @param regr matrix. Regression matrix with `p` rows and `k` columns.
#' @param sd numeric. Standard deviation of the observational error.
#'
#' @export
sim_mixregr <- function(x, z, regr, sd) {
    n <- length(z)
    p <- ncol(x)
    n_groups <- if (is.factor(z)) nlevels(z) else length(z)

    stopifnot(
      "Invalid dimensions for `regr`" = identical(dim(regr), c(p, n_groups)),
      "Invalid dimensions for `x`" = (nrow(x) == n)
    )

    lp <- x %*% regr
    y_means <- vapply(seq_len(n), function(i) lp[i, z[i]], numeric(1))

    y <- stats::rnorm(n, mean = y_means, sd = sd)

    return(y)
}


#' Design Matrix
#'
#' Simulated from i.i.d N(0,1) distributions, optional intercept.
#'
#' @param n integer. Number of observations.
#' @param nx integer. Number of explanatory variables, excluding intercept.
#' @param add_intercept logical. An intercept column is prepened when `TRUE`.
#'
#' @export
sim_design_matrix <- function(n, nx = 2, add_intercept = TRUE) {
    x <- matrix(stats::rnorm(n * nx), nrow = n, ncol = nx)
    colnames(x) <- paste0("X", seq_len(ncol(x)))
    if (add_intercept) return(cbind(Intercept = 1, x)) else return(x)
}

#' Group Membership
#'
#' Returns (factor of) groupings based on a vector of probabilities.
#'
#' @param n integer. Number of observations.
#' @param prob passed to \code{\link{sample}}.
#'
#' @export
sim_group_membership <- function(n, prob) {
    z_int <- sample(seq_along(prob), size = n, replace = TRUE, prob = prob)
    return(factor(z_int, levels = seq_along(prob)))
}

#' Visualisation Methods
#'
#' @param x matrix. Design matrix
#' @param y vector. Response variable data.
#' @param z vector/factor. Group membership data.
#'
#' @importFrom rlang .data
#'
#' @name vis
NULL


#' @describeIn vis
#'   Scatterplot with additional group membership data shown as colour.
#'
#' @export
vis_scatterplot <- function(x, y, z) {
  plot_data <-
    tidyr::pivot_longer(
      data = tidyr::tibble(as.data.frame(x), y, z),
      cols = tidyselect::matches("(X)|(Intercept)")
    )

  ggplot2::ggplot(plot_data, ggplot2::aes(
    x = .data$value,
    y = .data$y,
    colour = as.factor(.data$z)
  )) +
    ggplot2::geom_point() +
    ggplot2::facet_wrap(ggplot2::vars(.data$name)) +
    ggplot2::labs(y = "Y", x = "X", colour = "Group") +
    ggplot2::scale_color_discrete(drop = FALSE)
}


#' @describeIn vis
#'   Boxplot of `y` for each group (independent of `x`).
#'
#' @export
vis_boxgroup <- function(y, z) {
  plot_data <- data.frame(y = y, z = z)

  ggplot2::ggplot(plot_data, ggplot2::aes(y = y)) +
    ggplot2::geom_boxplot() +
    ggplot2::facet_wrap(
      ggplot2::vars(.data$z),
      labeller = function(tb) list(z = paste("Z =", tb$z)),
      drop = FALSE,
      nrow = 1
    ) +
    ggplot2::labs(y = "Y")
}

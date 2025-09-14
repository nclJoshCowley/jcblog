#' Visualise Relationship
#'
#' A fairly simple plot to show logistic regression data with varying slopes.
#' Not for use outside this blog post.
#'
#' @param data `tibble`. Data generated in the blog post.
#'
#' @returns ggplot2 object.
visualise_relationship <- function(data) {
  data |>
    dplyr::mutate(x_bin = ggplot2::cut_number(x, n = 10)) |>
    dplyr::summarise(
      proportion = mean(event), x = mean(x),
      .by = c("x_bin", "category")
    ) |>
    ggplot2::ggplot(
      mapping = ggplot2::aes(y = proportion, x = x, colour = category)
    ) +
    ggplot2::geom_smooth(
      alpha = 0.2,
      formula = y ~ x,
      method = "glm",
      se = FALSE
    ) +
    ggplot2::geom_point() +
    ggplot2::expand_limits(y = c(0, 1))
}

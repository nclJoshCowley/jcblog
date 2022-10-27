#' Visualise Time-Series Data
#' 
#' Plot used in blog post to show many time-series like data.
#' 
#' @param plot_data .
#' @param highlight character vector. Names of variables to highlight.
ggplot_ts <- function(plot_data, highlight = NULL) {
  out <- 
    plot_data %>%
    ggplot2::ggplot(ggplot2::aes(
      x = rowid,
      y = value,
      colour = name
    )) +
    ggplot2::geom_line(alpha = 0.8) +
    ggplot2::geom_point(alpha = 0.8) +
    ggplot2::labs(x = "Time", y = "Value", colour = "Series") +
    ggplot2::guides(colour = "none")
  
  if (is.null(highlight)) return(out)
  
  out +
    gghighlight::gghighlight(
      .data$name %in% highlight,
      unhighlighted_params = ggplot2::aes(alpha = 0.2),
      use_group_by = FALSE
    )
}

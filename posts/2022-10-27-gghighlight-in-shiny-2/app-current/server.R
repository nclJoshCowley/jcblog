library(ggplot2)
library(shiny)
library(dplyr) # %>%

source("simulate_correlated_normal.R")
source("ggplot_ts.R")

# Data to be clicked on
ts_data1 <-
  simulate_correlated_normal(offdiag = 0.2) %>%
  tibble::rowid_to_column() %>%
  tidyr::pivot_longer(-.data$rowid) %>%
  dplyr::mutate(selected_ = FALSE)

# Alternate data set
ts_data2 <-
  simulate_correlated_normal(offdiag = 0.8) %>%
  tibble::rowid_to_column() %>%
  tidyr::pivot_longer(-.data$rowid) %>%
  dplyr::mutate(selected_ = FALSE)

server <- function(input, output, session) {
  highlight <- 
    shiny::reactive(if (input$dropdown == "None") NULL else input$dropdown)
  
  shiny::bindEvent(
    shiny::observe({
      tb <- shiny::nearPoints(
        ts_data1,
        input$plot_click,
        maxpoints = 1,
        threshold = 20,
        xvar = "rowid",
        yvar = "value"
      )
      nm <- if (NROW(tb)) tb$name else NULL
      shiny::updateSelectInput(inputId = "dropdown", selected = nm)
    }),
    input$plot_click
  )
  
  output$plot1 <- shiny::renderPlot(ggplot_ts(ts_data1, highlight()))
  output$plot2 <- shiny::renderPlot(ggplot_ts(ts_data2, highlight()))
}

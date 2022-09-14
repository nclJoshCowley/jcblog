#' Application I/O
#'
#' @keywords internal
app_ui <- function() {
  inputs <-
    shiny::sidebarPanel(
      shiny::textOutput("tmp"),

      shiny::numericInput("seed", "Seed", 3),

      shiny::numericInput("n", "Observations (n)", 50),

      shiny::checkboxInput("add_intercept", "Include Intercept?", TRUE),

      shiny::tags$label("Probabilities"),
      shiny::splitLayout(
        shiny::numericInput("prob1", "k = 1", 0.1),
        shiny::numericInput("prob2", "k = 2", 0.2),
        shiny::numericInput("prob3", "k = 3", 0.3),
        shiny::numericInput("prob4", "k = 4", 0.4)
      ),

      shinyMatrix::matrixInput(
        "regr",
        "Regression Matrix",
        value = matrix(c(1, 3, 0.1, 4, -4, 5, 2, 6, -2, 3, 10, 3.5), 3, 4),
        rows = list(names = FALSE), cols = list(names = FALSE), class = "numeric"
      ),

      shiny::numericInput("sd", "Standard Deviation", 5),
    )

  outputs <-
    shiny::mainPanel(
      shiny::tabsetPanel(
        shiny::tabPanel(
          "Scatterplot",
          shiny::plotOutput("scatterplot", height = "800px")
        ),

        shiny::tabPanel(
          "Boxplot by Group",
          shiny::plotOutput("boxgroup", height = "800px")
        )
      )
    )

  # Return a single fluid page for I/O
  shiny::fluidPage(
    shiny::titlePanel("Mixture of Regressions - Simulation Study App"),
    shiny::sidebarLayout(inputs, outputs)
  )
}

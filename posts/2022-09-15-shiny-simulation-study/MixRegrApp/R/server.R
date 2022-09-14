#' Application Backend
#'
#' @keywords internal
app_server <- function(sample_info) {
  ggplot2::theme_set(ggplot2::theme_minimal(base_size = 20))
  ggplot2::theme_update(panel.spacing = ggplot2::unit(4, "lines"))

  function(input, output) {
    probs <- shiny::reactive(c(input$prob1, input$prob2, input$prob3, input$prob4))

    simdata <-
      shiny::reactive({
        set.seed(input$seed)

        add_intercept <- input$add_intercept
        nx <- if (add_intercept) 2 else 3

        x <-
          sim_design_matrix(input$n, nx = nx, add_intercept = add_intercept)

        z <- sim_group_membership(input$n, probs())

        y <- sim_mixregr(x, z, input$regr, input$sd)

        return(list(x = x, y = y, z = z))
      })

    output$scatterplot <-
    shiny::renderPlot(vis_scatterplot(simdata()$x, simdata()$y, simdata()$z))

    output$boxgroup <-
      shiny::renderPlot(vis_boxgroup(simdata()$y, simdata()$z))
  }
}

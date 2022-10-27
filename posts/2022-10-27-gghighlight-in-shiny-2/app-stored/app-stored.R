library(shiny)

ui <- 
  fluidPage(plotOutput("plot", click = "plot_click"), verbatimTextOutput("info"))

server <-
  function(input, output, server) {
    saved_events <- reactiveValues(plot_click = NULL)
    
    bindEvent(
      observe({saved_events$plot_click <- input$plot_click}),
      input$plot_click
    )
    
    output$plot <- 
      renderPlot({
        ggplot2::qplot(
          mtcars$mpg,
          mtcars$hp,
          colour = is.null(saved_events$plot_click)
        )
      })
    
    output$info <- renderPrint(saved_events$plot_click)
  }

shinyApp(ui, server)

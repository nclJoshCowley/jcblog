library(shiny)

ui <- 
  fluidPage(plotOutput("plot", click = "plot_click"), verbatimTextOutput("info"))

server <-
  function(input, output, server) {
    output$plot <- 
      renderPlot({
        ggplot2::qplot(
          mtcars$mpg,
          mtcars$hp,
          colour = is.null(input$plot_click)
        )
      })
    
    output$info <- renderPrint(input$plot_click)
  }

shinyApp(ui, server)

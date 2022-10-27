ui <-
  shiny::fluidPage(
    # Sidebar panel
    shiny::sidebarPanel(
      shiny::selectInput(
        "dropdown", "Selected", choices = c("None", unique(ts_data$name))
      ),
      width = 2
    ),
    
    # Main panel
    shiny::mainPanel(
      shiny::plotOutput("plot1", click = "plot_click"),
      shiny::plotOutput("plot2"),
      width = 10
    )
  )

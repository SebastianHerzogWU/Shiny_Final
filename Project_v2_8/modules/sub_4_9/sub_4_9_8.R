sub_4_9_8_UI <- function(id) {
  ns <- NS(id)
  tagList(
    fluidPage(
      h3("Histogram of the loadings for each Timeframe:"),
        sidebarLayout(
          sidebarPanel(
              selectInput(ns("plot_select"), label = "Select Timeframe:", 
                          choices = c("Start to 2008-12-31", "2008-12-31 to 2012-12-31",
                                      "2012-12-31 to 2019-12-31", "2019-12-31 to Present"),
                          selected = "Start")
            ),
          mainPanel(
            plotOutput(ns("selected_plot"))
        )
      )
    )
  )
}



sub_4_9_8_Server <- function(id, sharedData) {
  moduleServer(
    id,
    function(input, output, session) {
      ns <- session$ns
      
      ###########################################################################
      ########   Histogram of influence     #####################################
      ###########################################################################
      
      output$selected_plot <- renderPlot({
        full_merge_roll_avgs <- as.data.frame(sharedData$full_merge_roll_avgs())
        timeframe <- switch(input$plot_select,
                            "Start to 2008-12-31" = c("Start", "2008-12-31"),
                            "2008-12-31 to 2012-12-31" = c("2008-12-31", "2012-12-31"),
                            "2012-12-31 to 2019-12-31" = c("2012-12-31", "2019-12-31"),
                            "2019-12-31 to Present" = c("2019-12-31", "Present"))
        plot_histogram_for_timeframe_Index(full_merge_roll_avgs, timeframe[1], timeframe[2])
      })
      
    }
  )
}

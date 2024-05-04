sub_4_9_9_UI <- function(id) {
  ns <- NS(id)
  tagList(
    fluidPage(
      h3("Evolving themes for the selected Timeframe:"),
      sidebarLayout(
        sidebarPanel(
          selectInput(ns("plot_select"), label = "Select Timeframe:", 
                      choices = c("Start to Present","Start to 2008-12-31", "2008-12-31 to 2012-12-31",
                                  "2012-12-31 to 2019-12-31", "2019-12-31 to Present"
                                  ),
                      selected = "Start")
        ),
        mainPanel(
          plotOutput(ns("selected_plot"))
        )
      )
    )
  )
}

sub_4_9_9_Server <- function(id, sharedData) {
  moduleServer(
    id,
    function(input, output, session) {
      ns <- session$ns
      
      ###########################################################################
      ########   Lines of influence     #####################################
      ###########################################################################
      
      output$selected_plot <- renderPlot({
        full_merge_roll_avgs_long <- as.data.frame(sharedData$full_merge_roll_avgs_long())
        timeframe <- switch(input$plot_select,
                            "Start to Present" = c("Start", "Present"),
                            "Start to 2008-12-31" = c("Start", "2008-12-31"),
                            "2008-12-31 to 2012-12-31" = c("2008-12-31", "2012-12-31"),
                            "2012-12-31 to 2019-12-31" = c("2012-12-31", "2019-12-31"),
                            "2019-12-31 to Present" = c("2019-12-31", "Present"))
        plot_lines_for_timeframe_Index(full_merge_roll_avgs_long, timeframe[1], timeframe[2])
      })
      
    }
  )
}

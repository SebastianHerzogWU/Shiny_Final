sub_3_3_UI <- function(id) {
  ns <- NS(id)
  tagList(
    h1("Detailed Statistics"),
    sidebarLayout(
      sidebarPanel(
        selectInput(ns("column_selector_detail_stat"), "Select Column(s):", choices = setdiff(colnames(df_raw), "Date"),
                    multiple = TRUE),
        actionButton(ns("show_plot_button"), "Show Plot")  # Adding the actionButton
      ), 
      mainPanel(
        verbatimTextOutput(ns("summary_detail"),placeholder = TRUE),
        plotOutput(ns("boxplot_detail"))
      )
    ),
    h4("Click the button to show the plot.")  # Moved outside of sidebarLayout
  )
}



sub_3_3_Server <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      
      # Reactive function to filter and prepare the data for detailed statistics      
      selected_detail_statistics_data <- eventReactive(input$show_plot_button, {
        print(input$column_selector_detail_stat)
        if (length(input$column_selector_detail_stat) > 0) {
          detailed_data <- df_raw[,input$column_selector_detail_stat, drop = FALSE]
          return(detailed_data)
        } else { # If nothing is selected, return NA
          return(NULL)}
      })
      
      output$summary_detail <- renderPrint({
        if (is.null(selected_detail_statistics_data()) || length(selected_detail_statistics_data()) == 0) {
          p <- "please select a column"
          return(p)
        } else {
          p <- summary(selected_detail_statistics_data())
        }
        return(p)
      })
      
      output$boxplot_detail <- renderPlot({
        g <- boxplot(selected_detail_statistics_data())
        return(g)
      })
        
      })
}

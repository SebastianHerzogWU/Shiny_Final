sub_4_2_UI <- function(id) {
  ns <- NS(id)
  tagList(
    fluidPage(
      h1("A first PCA Plot"),
      sidebarLayout(
        sidebarPanel(
          selectInput(ns("comp_simpl_selector"), "Select Component:", choices = setdiff(colnames(comp), "V1"), 
                      multiple = TRUE)  # Added ns() around the input ID
        ),
        mainPanel(shinycssloaders::withSpinner(plotOutput(ns("selected_plot_simpl")), type = 2),  # Added ns() around the output ID
                  p("In here, only the most correlated PC's are to be selected. Threshold 0.85")
        )
      )
    )
  )
}

sub_4_2_Server <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      # Reactive function to filter and prepare the data for plotting on the simple PC Plot
      selected_plot_data_simpl_pca <- reactive({
        if (length(input$comp_simpl_selector) > 0) {
          # Extracting selected components and the first column (date) from the original data
          selected_cols <- c(1, match(input$comp_simpl_selector, colnames(comp)) + 1)
          # Adding 1 because we keep the date column
          comp_selected <- comp[, selected_cols, drop = FALSE]
          return(comp_selected)
        } else {
          # If nothing is selected, include the "date" column by default
          return(comp)  # Return the original data
        }
      })
      
      # Render simple PC plot based on the reactive function
      output$selected_plot_simpl <- renderPlot({
        plot_data <- selected_plot_data_simpl_pca()
        # Ensure the first column is converted to Date format
        plot_data[, 1] <- as.Date(plot_data[, 1], format = "%Y-%m-%d")  # Adjust the format as per your data
        
        # Customizing the plot with a grid and granular x-axis
        matplot(plot_data[, 1], plot_data[, -1], type = "l",  
                xlab = "Observations", ylab = "Principal Components",
                main = "Principal Component Plot",
                xaxt = "n")  # Remove automatic x-axis labeling
        
        axis(1, at = pretty(plot_data[, 1]), labels = format(pretty(plot_data[, 1]), "%b %Y"))  # Custom x-axis with monthly intervals
        
        grid()  # Add grid to the plot
      })
    }
  )
}


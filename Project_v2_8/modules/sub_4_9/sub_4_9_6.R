

# UI Function
sub_4_9_6_UI <- function(id) {
  ns <- NS(id)
  tagList(
    fluidPage(
      mainPanel(
        h3("PC1 Loadings of Indices after rolling PCA (window = 80-Day)"),
    plotOutput(ns("rolling_window_plot"))  # Add a plot output for the rolling window plot
      )
    )
  )
}

# Server Function
sub_4_9_6_Server <- function(id, sharedData) {
  moduleServer(
    id,
    function(input, output, session) {
      # Assume 'full_merge' and the necessary functions are available in the global environment
      
      # Reactive expression for the correlation_df dataframe
      sharedData$correlation_df <- reactive({
        # Rolling Window regression code
        full_merge <- sharedData$full_merge()
        Dates <- as.Date(rownames(full_merge))
        n_rows <- nrow(full_merge)
        window_length <- 80  # Length of the rolling window
        
        # Get the PCA loadings
        roll_principal_components_loading <- lapply(1:(n_rows - window_length + 1), function(i) {
          window_data <- full_merge[i:(i + window_length - 1), , drop = FALSE]
          perform_pca_loading_Index(window_data)
        })
        
        # DataFrame for loadings
        col_names <- colnames(full_merge)
        correlation_df <- data.frame(matrix(ncol = length(col_names), nrow = length(roll_principal_components_loading)))
        colnames(correlation_df) <- col_names
        
        # Fill in correlations for each variable at each time point
        for (i in 1:length(roll_principal_components_loading)) {
          correlation_df[i, ] <- roll_principal_components_loading[[i]] 
        }
        Dates <- Dates[window_length:length(Dates)]  # Date adjustment
        rownames(correlation_df) <- Dates
        correlation_df$Date <- as.character(rownames(correlation_df))
        correlation_df
      })
      
      # Render the plot using the sharedData
      output$rolling_window_plot <- renderPlot({
        correlation_df_long <- melt(sharedData$correlation_df(), id.vars = "Date")
        
        ggplot(data = correlation_df_long, aes(x = as.Date(Date), y = value, color = variable)) +
          geom_line() +
          labs(x = "Date", y = "Loading of PC1", color = "Variable") +
          scale_x_date(date_breaks = "1 year", date_labels = "%Y") +
          theme_minimal() +
          theme(legend.position = "right") +
          theme(axis.text.x = element_text(angle = 45, hjust = 1))
      })
    }
  )
}

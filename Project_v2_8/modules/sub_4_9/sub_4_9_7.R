# UI Function for sub_4_9_7
sub_4_9_7_UI <- function(id) {
  ns <- NS(id)
  tagList(
    fluidPage(
      mainPanel(
        h3("Control Outliers by moving average of loadings (window = 80-Day) + Timeframes"),
    plotOutput(ns("rolling_avg_plot"))  # Output for the rolling average plot
      )
    )
  )
}

# Server Function for sub_4_9_7
sub_4_9_7_Server <- function(id, sharedData) {
  moduleServer(
    id,
    function(input, output, session) {
      # Calculate moving averages and store the result in sharedData
      sharedData$full_merge_roll_avgs_long <- reactive({
        correlation_df <- sharedData$correlation_df()  # Retrieve the correlation_df from sharedData
        correlation_df_temp <- correlation_df[, -which(names(correlation_df) == "Date")]
        
        window_size <- 80  # Define the window size for the rolling average
        roll_avgs <- lapply(correlation_df_temp, function(column) {
          if (is.numeric(column)) {
            rollmean(column, k = window_size, align = "right", fill = NA)
          } else {
            column  # Skip non-numeric columns
          }
        })
        
        full_merge_roll_avgs <- as.data.frame(roll_avgs) # Combine the list of rolling averages back into a data frame
        full_merge_roll_avgs$Date <- as.Date(correlation_df$Date) # Add the original dates back to the data frame
        full_merge_roll_avgs <- full_merge_roll_avgs %>% 
          drop_na()
        

        
        full_merge_roll_avgs_long <- melt(full_merge_roll_avgs, id.vars = "Date") # Reshape the data to long format for plotting with ggplot2
        
        full_merge_roll_avgs_long
      })
      sharedData$full_merge_roll_avgs <- reactive({
        correlation_df <- sharedData$correlation_df()  # Retrieve the correlation_df from sharedData
        correlation_df_temp <- correlation_df[, -which(names(correlation_df) == "Date")]
        
        window_size <- 80  # Define the window size for the rolling average
        roll_avgs <- lapply(correlation_df_temp, function(column) {
          if (is.numeric(column)) {
            rollmean(column, k = window_size, align = "right", fill = NA)
          } else {
            column  # Skip non-numeric columns
          }
        })
        
        full_merge_roll_avgs <- as.data.frame(roll_avgs) # Combine the list of rolling averages back into a data frame
        full_merge_roll_avgs$Date <- as.Date(correlation_df$Date) # Add the original dates back to the data frame
        full_merge_roll_avgs <- full_merge_roll_avgs %>% 
          drop_na()
      })
      
      # Render the plot using the calculated moving averages
      output$rolling_avg_plot <- renderPlot({
        ggplot(data = sharedData$full_merge_roll_avgs_long(), aes(x = Date, y = value, color = variable, group = variable)) +
          geom_line(na.rm = TRUE) +  # Remove NA values resulting from the rolling average calculation
          labs(x = "Date", y = "80-Day Rolling Average", color = "Variable") +
          scale_x_date(date_breaks = "1 year", date_labels = "%Y") +  # Display only years on x-axis
          geom_vline(xintercept = as.Date(c("2007-01-01", "2008-12-31", "2012-12-31", "2019-12-31", "2024-04-01")), linetype = "dashed", color = "red") +
          theme_minimal() +
          theme(legend.position = "right") +
          theme(axis.text.x = element_text(angle = 45, hjust = 1))
      })
    }
  )
}

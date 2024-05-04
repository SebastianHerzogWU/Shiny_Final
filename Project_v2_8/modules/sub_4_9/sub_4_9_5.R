# UI function
sub_4_9_5_UI <- function(id) {
  ns <- NS(id)
  tagList(
    fluidPage(
      mainPanel(
        h3("Plotting the self created Indices:"),
    plotOutput(ns("time_series_plot")) # UI element for the plot
      )
    )
  )
}

# Server function
sub_4_9_5_Server <- function(id, sharedData) {
  moduleServer(
    id,
    function(input, output, session) {
      
      sharedData$full_merge <- reactive({
        # Equally weighted Index --------------------------------------------------
        ###########################################################################
        ########   Index creation       ###########################################
        ###########################################################################
        commodities_index <- create_equally_weighted_index(sharedData$commodities_std_no_corr(), "COMMODITIES")
        indices_index <- create_equally_weighted_index(sharedData$indices_std_no_corr(), "INDICES")
        bonds_index <- create_equally_weighted_index(sharedData$bonds_std_no_corr(), "BONDS")
        currencies_index <- create_equally_weighted_index(sharedData$merged_currencies_std_no_corr(), "CURRENCIES")
        macro_index <- create_equally_weighted_index(sharedData$macro_indicators_std_no_corr(), "MACRO")
        fama_french_index <- create_equally_weighted_index(sharedData$fama_french_factors_std_no_corr(), "FAMA_FRENCH")
        
        # Plot the Indices --------------------------------------------------------
        # Convert row names to a column for each dataframe
        full_merge <- commodities_index
        full_merge$Date <- rownames(full_merge)
        indices_index$Date <- rownames(indices_index)
        bonds_index$Date <- rownames(bonds_index)
        currencies_index$Date <- rownames(currencies_index)
        macro_index$Date <- rownames(macro_index)
        fama_french_index$Date <- rownames(fama_french_index)
        
        full_merge <- full_merge %>% 
          left_join(indices_index, by = "Date") %>% 
          left_join(bonds_index, by = "Date") %>% 
          left_join(currencies_index, by = "Date") %>% 
          left_join(macro_index, by = "Date") %>% 
          left_join(fama_french_index, by = "Date")
        rownames(full_merge) <- full_merge$Date
        full_merge = subset(full_merge, select = -Date )
        full_merge
      })
      
      output$time_series_plot <- renderPlot({
        plot_time_series_Index(sharedData$full_merge(), value_name = "Index Values", title = "Index Over Time")
      })
    }
  )
}

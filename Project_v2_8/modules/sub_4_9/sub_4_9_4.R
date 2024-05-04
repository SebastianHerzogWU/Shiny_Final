sub_4_9_4_UI <- function(id) {
  ns <- NS(id)
  tagList(
    fluidPage(
      mainPanel(
        h3("Plotting 7 Dataframes each selected by correlation exclusion:"),
    plotOutput(ns("commodities_plot")),
    plotOutput(ns("indices_plot")),
    plotOutput(ns("bonds_plot")),
    plotOutput(ns("currencies_plot")),
    plotOutput(ns("macro_indicators_plot")),
    plotOutput(ns("fama_french_factors_plot"))
      )
    )
  )
}


sub_4_9_4_Server <- function(id, sharedData) {
  moduleServer(
    id,
    function(input, output, session) {
      
      # Exclude Highly correlated Variables -------------------------------------
      ###########################################################################
      ########   Exclude Correlated     #########################################
      ###########################################################################
      ## Apply the length method

      sharedData$commodities_std_no_corr <- reactive({
        commodities_std_no_corr <- remove_to_target_count_Index(sharedData$commodities_std(), target_count = 7, execute = TRUE)
        commodities_std_no_corr
        })
      
      sharedData$indices_std_no_corr <- reactive({
        indices_std_no_corr <- remove_to_target_count_Index(sharedData$indices_std(), target_count = 7, execute = TRUE)
        indices_std_no_corr
      })
      
      sharedData$bonds_std_no_corr <- reactive({
        bonds_std_no_corr <- remove_to_target_count_Index(sharedData$bonds_std() , target_count = 7, execute = TRUE)
        bonds_std_no_corr
      })
      
      sharedData$macro_indicators_std_no_corr <- reactive({
        macro_indicators_std_no_corr <- remove_to_target_count_Index(sharedData$macro_indicators_std(), target_count = 7, execute = TRUE)
        macro_indicators_std_no_corr
      })
      
      sharedData$fama_french_factors_std_no_corr <- reactive({
        fama_french_factors_std_no_corr <- remove_to_target_count_Index(sharedData$fama_french_factors_std(), target_count = 5, execute = TRUE)
        fama_french_factors_std_no_corr
      })
      
      sharedData$merged_currencies_std_no_corr <- reactive({
        merged_currencies_std_no_corr <- remove_to_target_count_Index(sharedData$merged_currencies_std(), target_count = 7, execute = TRUE)
        merged_currencies_std_no_corr
      })
      
      
      # Create Plots for the Data Frames -------------------------------------
      ###########################################################################
      ########   Data Frames Plots    ###########################################
      ###########################################################################
      
      output$commodities_plot <- renderPlot({
        plot_time_series_Index(sharedData$commodities_std_no_corr(), value_name = "Commodity Value", title = "Commodities Over Time")
      })
      output$indices_plot <- renderPlot({
        plot_time_series_Index(sharedData$indices_std_no_corr(), value_name = "Index Value", title = "Indices Over Time")
      })
      output$bonds_plot <- renderPlot({
        plot_time_series_Index(sharedData$bonds_std_no_corr(), value_name = "Bond Index Value", title = "Bonds Over Time")
      })
      output$currencies_plot <- renderPlot({
        plot_time_series_Index(sharedData$merged_currencies_std_no_corr(), value_name = "Currency Value", title = "Currencies Over Time")
      })
      output$macro_indicators_plot <- renderPlot({
        plot_time_series_Index(sharedData$macro_indicators_std_no_corr(), value_name = "Macro Indicator Value", title = "Macroeconomic Indicators Over Time")
      })
      output$fama_french_factors_plot <- renderPlot({
        plot_time_series_Index(sharedData$fama_french_factors_std_no_corr(), value_name = "Factor Value", title = "Fama-French Factors Over Time")
      })
    }
  )
}



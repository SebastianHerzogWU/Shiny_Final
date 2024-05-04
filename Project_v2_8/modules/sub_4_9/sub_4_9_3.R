sub_4_9_3_UI <- function(id) {
  ns <- NS(id)
  tagList(
    fluidPage(
      mainPanel(h3("Standardizing the Data groups and plotting:"),
        # Placeholders for the plots of each dataframe
        plotOutput(ns("plot_commodities")),
        plotOutput(ns("plot_indices")),
        plotOutput(ns("plot_bonds")),
        plotOutput(ns("plot_merged_currencies")),
        plotOutput(ns("plot_macro_indicators")),
        plotOutput(ns("plot_fama_french_factors"))
      )
    )
  
  )
}

sub_4_9_3_Server <- function(id, sharedData) {
  moduleServer(
    id,
    function(input, output, session) {
      
      # Standardize -------------------------------------------------------------
      ###########################################################################
      ########   standardize   ##################################################
      ###########################################################################
      sharedData$commodities_std <- reactive({
          commodities <-sharedData$commodities()
          commodities_std <- standardize_columns_Index(commodities)
          commodities_std
        })
      
      sharedData$indices_std <- reactive({
        indices <-sharedData$indices()
        indices_std <- standardize_columns_Index(indices)
        indices_std
      })
      
      sharedData$bonds_std <- reactive({
        bonds <-sharedData$bonds()        
        bonds_std <- standardize_columns_Index(bonds)
        bonds_std
      })
      
      sharedData$merged_currencies_std <- reactive({
        merged_currencies <-sharedData$merged_currencies() 
        merged_currencies_std <- standardize_columns_Index(merged_currencies)
        merged_currencies_std
      })
      
      sharedData$macro_indicators_std <- reactive({
        macro_indicators <-sharedData$macro_indicators()         
        macro_indicators_std <- standardize_columns_Index(macro_indicators)
        macro_indicators_std
      })
      
      sharedData$fama_french_factors_std <- reactive({
        fama_french_factors <-sharedData$fama_french_factors()        
        fama_french_factors_std <- standardize_columns_Index(fama_french_factors)
        fama_french_factors_std
      })

      # Create Plots for the Data Frames -------------------------------------
      ###########################################################################
      ########   Data Frames Plots    ###########################################
      ###########################################################################
      
      # Function to render plots
      render_plot <- function(data, output_id,value_names, title) {
        output[[output_id]] <- renderPlot({
          plot_time_series_Index(data, value_name = value_names, title = title)
        })
      }
      
      # Render plots for each dataframe
      render_plot(sharedData$commodities_std(), "plot_commodities", "Commodities", "Commodities")
      render_plot(sharedData$indices_std(), "plot_indices","Indices","Indices")
      render_plot(sharedData$bonds_std(), "plot_bonds","Plot Bonds","Plot Bonds")
      render_plot(sharedData$merged_currencies_std(), "plot_merged_currencies", "Currencies", "Currencies")
      render_plot(sharedData$macro_indicators_std(), "plot_macro_indicators", "Indicators", "Indicators")
      render_plot(sharedData$fama_french_factors_std(), "plot_fama_french_factors", "Fama French Factors", "Fama French Factors")
    }
  )
}
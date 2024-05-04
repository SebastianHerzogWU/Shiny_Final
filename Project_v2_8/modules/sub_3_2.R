# UI module for displaying summary statistics
sub_3_2_UI <- function(id) {
  ns <- NS(id)
  fluidPage(
    sidebarLayout(
      sidebarPanel(
        selectInput(ns("dataGroup"), "Select Data Group", 
                    choices = c("Commodities", "Indices", "Bonds", "Currencies", "Macro Indicators", "Fama-French Factors")),
        checkboxInput(ns("standardize"), "Standardize Data", FALSE),
        uiOutput(ns("seriesSelector")),
        actionButton(ns("statsButton"), "Show Statistics")
      ),
      mainPanel(
        DTOutput(ns("summaryStatsTable"))
      )
    )
  )
}

# Server module
sub_3_2_Server <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      ns <- session$ns
      
      # Reactive expression to load data
      loadData <- reactive({
        index_file_path <- "www/Data/Index.RData"
        macro_file_path <- "www/Data/Macro.RData"
        
        load(index_file_path)
        index_data <- df
        load(macro_file_path)
        macro_data <- df
        
        list(index_data = index_data, macro_data = macro_data)
      })
      
      # Reactive expression to prepare data based on the user's selection
      preparedData <- reactive({
        data <- loadData()
        index_data <- data$index_data
        macro_data <- data$macro_data
        
        # Creating groups of indicators
        commodities <- index_data[, grep("Comdty", names(index_data))]
        indices <- index_data[, grep("Index", names(index_data))]
        bond_indices <- grep("Y[0-9]+", names(indices), value = TRUE)
        indices <- indices[, !names(indices) %in% bond_indices]
        bonds <- index_data[, bond_indices, drop = FALSE]
        index_currencies <- index_data[, grep("Curncy", names(index_data)), drop = FALSE]
        macro_currencies <- macro_data[, grep("Curncy", names(macro_data)), drop = FALSE]
        merged_currencies <- merge(index_currencies, macro_currencies, by = "row.names")
        rownames(merged_currencies) <- merged_currencies$Row.names
        merged_currencies <- merged_currencies[, -1]
        macro_indicators <- macro_data[, grep("Index", names(macro_data))]
        macro_indicators <- macro_indicators[, !names(macro_indicators) %in% names(merged_currencies)]
        fama_french_factors <- macro_data[, grep("^ff[35]", names(macro_data))]
        
        # Select the data group based on the user's choice
        selectedData <- switch(input$dataGroup,
                               "Commodities" = commodities,
                               "Indices" = indices,
                               "Bonds" = bonds,
                               "Currencies" = merged_currencies,
                               "Macro Indicators" = macro_indicators,
                               "Fama-French Factors" = fama_french_factors)
        
        # If "standardize" is checked, standardize the data
        if (input$standardize) {
          selectedData <- standardize_columns(selectedData)
        }
        
        selectedData
      })
      
      # Update series selector based on the selected data group
      output$seriesSelector <- renderUI({
        data <- preparedData()
        selectInput(ns("selectedSeries"), "Select Series", choices = names(data), multiple = TRUE, selected = names(data))
      })
      
      # Generate and render the summary statistics table
      output$summaryStatsTable <- renderDT({
        req(input$statsButton) # Require that the action button is clicked before rendering the table
        isolate({
          data <- preparedData()
          selectedSeries <- input$selectedSeries
          
          # Filter the data to only include selected series
          if (!is.null(selectedSeries)) {
            data <- data[, selectedSeries, drop = FALSE]
          }
          
          # Calculate summary statistics for each selected series
          summary_stats <- sapply(data, summary)
          
          # Convert the summary statistics to a data frame for display
          stats_df <- as.data.frame(t(summary_stats))
          
          # Render the table using DT
          datatable(stats_df, options = list(pageLength = 5))
        })
      })
    }
  )
}

sub_4_9_2_UI <- function(id) {
  ns <- NS(id)
  tagList(
    fluidPage(
      mainPanel(
        h3("Grouping the Data By indicators:"),
        div(id = ns("accordion"), class = "accordion",
            # Bonds Category
            div(class = "card",
                div(class = "card-header",
                    h5(class = "mb-0",
                       a(href = "#collapseBonds", "data-toggle" = "collapse", "data-target" = "#collapseBonds", 
                         "aria-expanded" = "true", "aria-controls" = "collapseBonds",
                         strong("Bonds"))
                    )
                ),
                div(id = "collapseBonds", class = "collapse show", "aria-labelledby" = "headingBonds",
                    div(class = "card-body",
                        span(style = 'display: inline-block;', "GJGB10 Index, GAGB10YR Index, I00163JP Index, GDBR10 Index, USGG10YR Index, USGG2YR Index, GFRN10 Index, GBTPGR10 Index, GACGB10 Index, GSPG10YR Index, GECU10YR Index, BSELTRUU Index, I00163US Index, LBUSTRUU Index, LBEATREU Index, USYC2Y10 Index, DEYC2Y10 Index, JPYC1030 Index, JPYC2Y10 Index, USYC1030 Index, DEYC1030 Index, FRYC1030 Index, FRYC2Y10 Index, ATYC2Y10 Index, ATYC1030 Index")
                    )
                )
            ),
            # Commodities Category
            div(class = "card",
                div(class = "card-header",
                    h5(class = "mb-0",
                       a(href = "#collapseCommodities", "data-toggle" = "collapse", "data-target" = "#collapseCommodities", 
                         "aria-expanded" = "false", "aria-controls" = "collapseCommodities",
                         strong("Commodities"))
                    )
                ),
                div(id = "collapseCommodities", class = "collapse", "aria-labelledby" = "headingCommodities",
                    div(class = "card-body",
                        span(style = 'display: inline-block;', "CL1 Comdty, CO1 Comdty, HG1 Comdty, LA1 Comdty, LL1 Comdty, LN1 Comdty, LT1 Comdty, HO1 Comdty, NG1 Comdty, BO1 Comdty, W 1 Comdty, SM1 Comdty, S 1 Comdty, RR1 Comdty, QW1 Comdty, O 1 Comdty, LH1 Comdty, LC1 Comdty, KC1 Comdty, JO1 Comdty, FC1 Comdty, CT1 Comdty, CC1 Comdty, C 1 Comdty, XAG Curncy, XAU Curncy, XPD Curncy, XPT Curncy")
                    )
                )
            ),
            # Repeat the above structure for each category...
            # Fama-French Factors Category
            div(class = "card",
                div(class = "card-header",
                    h5(class = "mb-0",
                       a(href = "#collapseFamaFrench", "data-toggle" = "collapse", "data-target" = "#collapseFamaFrench", 
                         "aria-expanded" = "false", "aria-controls" = "collapseFamaFrench",
                         strong("Fama-French Factors"))
                    )
                ),
                div(id = "collapseFamaFrench", class = "collapse", "aria-labelledby" = "headingFamaFrench",
                    div(class = "card-body",
                        span(style = 'display: inline-block;', "ff3_Mkt.RF, ff3_SMB, ff3_HML, ff5_Mkt.RF, ff5_SMB, ff5_HML, ff5_RMW, ff5_CMA")
                    )
                )
            ),
            # Indices Category
            div(class = "card",
                div(class = "card-header",
                    h5(class = "mb-0",
                       a(href = "#collapseIndices", "data-toggle" = "collapse", "data-target" = "#collapseIndices", 
                         "aria-expanded" = "false", "aria-controls" = "collapseIndices",
                         strong("Indices"))
                    )
                ),
                div(id = "collapseIndices", class = "collapse", "aria-labelledby" = "headingIndices",
                    div(class = "card-body",
                        span(style = 'display: inline-block;', "AEX Index, ASE Index, BEL20 Index, BVLX Index, HEX Index, ISEQ Index, KFX Index, NDX Index, SPTSX Index, SMI Index, NKY Index, KOSPI Index, HSI Index")
                    )
                )
            ),
            # Macro Indicators Category
            div(class = "card",
                div(class = "card-header",
                    h5(class = "mb-0",
                       a(href = "#collapseMacro", "data-toggle" = "collapse", "data-target" = "#collapseMacro", 
                         "aria-expanded" = "false", "aria-controls" = "collapseMacro",
                         strong("Macro Indicators"))
                    )
                ),
                div(id = "collapseMacro", class = "collapse", "aria-labelledby" = "headingMacro",
                    div(class = "card-body",
                        span(style = 'display: inline-block;', "CPI YOY Index, CNCPIYOY Index, JNCPIYOY Index, BZPIIPCY Index, EACPI Index, HKCPIY Index, AUCPIYOY Index, ITCPNICY Index, FRCPEECY Index, EHPILAT Index, EHPIASP Index, CPEXEMUY Index, SACPIYOY Index, RUCPIYOY Index, SPIPCYOY Index, EHUPUS Index, EHUPCN Index, EHUPJP Index, EHUPEU Index, EHUPDE Index, EHUPAT Index, EHUPES Index, EHUPIT Index, EHUPHK Index, EHUPBR Index, EHUPGB Index, EHUPSE Index, EHUPFR Index, EHUPMX Index, EHUPCA Index, EHUPASAY Index, EHGDDEY Index, EHGDUSY Index, EHGDEUY Index, EHGDCNY Index, EHGDSE Index, EHGDFRY Index, EHGDESY Index, EHGDITY Index, EHGDGBY Index, EHGDHKY Index, EHGDASPY Index, EHGDBRY Index, EHGDMXY Index, EHGDRUY Index, EHGDAUY Index, EHGDEEUY Index, EHGDNOY Index, MXEF0CX0 Index")
                    )
                )
            ),
            # Merged Currencies Category
            div(class = "card",
                div(class = "card-header",
                    h5(class = "mb-0",
                       a(href = "#collapseCurrencies", "data-toggle" = "collapse", "data-target" = "#collapseCurrencies", 
                         "aria-expanded" = "false", "aria-controls" = "collapseCurrencies",
                         strong("Merged Currencies"))
                    )
                ),
                div(id = "collapseCurrencies", class = "collapse", "aria-labelledby" = "headingCurrencies",
                    div(class = "card-body",
                        span(style = 'display: inline-block;', "EUR Curncy, EURJPY Curncy, EURCHF Curncy, EURGBP Curncy, EURSEK Curncy, EURNOK Curncy, EURCAD Curncy, EURCZK Curncy, EURHUF Curncy, EURKRW Curncy")
                    )
                )
            )
        ),
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

sub_4_9_2_Server <- function(id, sharedData) {
  moduleServer(
    id,
    function(input, output, session) {
      
      # Setup Data frames load/ align -------------------------------------------
      ###########################################################################
      ########   Setup/Load/align    ############################################
      ###########################################################################
      sharedData$index_data <- reactive({
        aligned_dataframes <- align_dataframes_by_date_Index(index_data, macro_data)
        index_data <- aligned_dataframes[[1]]
        index_data
      })
      
      sharedData$macro_data <- reactive({
        aligned_dataframes <- align_dataframes_by_date_Index(index_data, macro_data)
        macro_data <- aligned_dataframes[[2]]
        macro_data
      })

      # creating groups of indicators -------------------------------------------
      ###########################################################################
      ########   groups        ##################################################
      ###########################################################################
      
      ## indices group
      sharedData$indices <- reactive({
        index_data <- sharedData$index_data()
        indices <- index_data[, grep("Index", names(index_data))] # Indices (excluding bond indices)
        bond_indices <-  c(
          "GJGB10 Index", "GAGB10YR Index", "I00163JP Index", "GDBR10 Index",
          "USGG10YR Index", "USGG2YR Index", "GFRN10 Index", "GBTPGR10 Index",
          "GACGB10 Index", "GSPG10YR Index", "GECU10YR Index", "BSELTRUU Index",
          "I00163US Index", "LBUSTRUU Index", "LBEATREU Index", "USYC2Y10 Index",
          "DEYC2Y10 Index", "JPYC1030 Index", "JPYC2Y10 Index", "USYC1030 Index",
          "DEYC1030 Index", "FRYC1030 Index", "FRYC2Y10 Index", "ATYC2Y10 Index",
          "ATYC1030 Index")
        indices <- indices[, !names(indices) %in% bond_indices]
        indices
      })
      
      ## bonds group
      sharedData$bonds <- reactive({
        index_data <- sharedData$index_data()
        bond_indices <-  c(
          "GJGB10 Index", "GAGB10YR Index", "I00163JP Index", "GDBR10 Index",
          "USGG10YR Index", "USGG2YR Index", "GFRN10 Index", "GBTPGR10 Index",
          "GACGB10 Index", "GSPG10YR Index", "GECU10YR Index", "BSELTRUU Index",
          "I00163US Index", "LBUSTRUU Index", "LBEATREU Index", "USYC2Y10 Index",
          "DEYC2Y10 Index", "JPYC1030 Index", "JPYC2Y10 Index", "USYC1030 Index",
          "DEYC1030 Index", "FRYC1030 Index", "FRYC2Y10 Index", "ATYC2Y10 Index",
          "ATYC1030 Index")
        bonds <- index_data[, bond_indices, drop = FALSE] # Bonds
        bonds
      })
      
      ## fama-french group
      sharedData$fama_french_factors <- reactive({
        index_data <- sharedData$index_data()
        fama_french_factors <- macro_data[, grep("^ff[35]", names(macro_data))] # Fama-French Factors
        fama_french_factors
      })
      
      ## currencies group
      sharedData$merged_currencies <- reactive({
        index_data <- sharedData$index_data()
        macro_data <- sharedData$macro_data()
        
        index_currencies <- index_data[, grep("Curncy", names(index_data)), drop = FALSE] # Currencies
        macro_currencies <- macro_data[, grep("Curncy", names(macro_data)), drop = FALSE]
        merged_currencies <- merge(index_currencies, macro_currencies, by = "row.names") 
        rownames(merged_currencies) <- merged_currencies$Row.names
        merged_currencies <- merged_currencies[, -1]
        commodities <- index_data[, grep("Comdty", names(index_data))] # Commodities
        precious_metals_currencies <- merged_currencies[, c("XAG Curncy", "XAU Curncy", "XPD Curncy", "XPT Curncy")]  # Extract specific currency columns into a new dataframe
        merged_currencies <- merged_currencies[, !names(merged_currencies) %in% c("XAG Curncy", "XAU Curncy", "XPD Curncy", "XPT Curncy")] # Remove specific currency columns from the merged_currencies dataframe
        return(merged_currencies)
        })
      
      ## commodities group
      sharedData$commodities <- reactive({
        index_data <- sharedData$index_data()
        macro_data <- sharedData$macro_data()
        
        # get precious_metals_currencies
        index_currencies <- index_data[, grep("Curncy", names(index_data)), drop = FALSE] # Currencies
        macro_currencies <- macro_data[, grep("Curncy", names(macro_data)), drop = FALSE]
        merged_currencies <- merge(index_currencies, macro_currencies, by = "row.names") 
        rownames(merged_currencies) <- merged_currencies$Row.names
        merged_currencies <- merged_currencies[, -1]
        precious_metals_currencies <- merged_currencies[, c("XAG Curncy", "XAU Curncy", "XPD Curncy", "XPT Curncy")]  # Extract specific currency columns into a new dataframe
        
        commodities <- index_data[, grep("Comdty", names(index_data))] # Commodities
        commodities$Date <- rownames(commodities) # Convert row names to a column for merging
        precious_metals_currencies$Date <- rownames(precious_metals_currencies)
        merged_data <- merge(commodities, precious_metals_currencies, by = "Date", all = TRUE) # Merge by the new Date column using all.x = TRUE to include all rows from commodities
        rownames(merged_data) <- merged_data$Date # set the Date column as row names again
        commodities <- merged_data[, -1]  # Remove the Date column after setting it as row names
        commodities
      })
    
      ## macro group
      sharedData$macro_indicators <- reactive({
        macro_data <- sharedData$macro_data()
        merged_currencies <- sharedData$merged_currencies()
        macro_indicators <- macro_data[, grep("Index", names(macro_data))] # Macroeconomic Indicators
        macro_indicators <- macro_indicators[, !names(macro_indicators) %in% names(merged_currencies)]  # Remove currency-related indices
        macro_indicators
      })

      ### End of Groups

      
      # Function to render plots
      render_plot <- function(data, output_id,value_names, title) {
        output[[output_id]] <- renderPlot({
          plot_time_series_Index(data, value_name = value_names, title = title)
        })
      }
      
      # Create Plots for the Data Frames -------------------------------------
      ###########################################################################
      ########   Data Frames Plots    ###########################################
      ###########################################################################
      
      # Render plots for each dataframe
      render_plot(sharedData$commodities(), "plot_commodities", "Commodities", "Commodities")
      render_plot(sharedData$indices(), "plot_indices","Indices","Indices")
      render_plot(sharedData$bonds(), "plot_bonds","Plot Bonds","Plot Bonds")
      render_plot(sharedData$merged_currencies(), "plot_merged_currencies", "Currencies", "Currencies")
      render_plot(sharedData$macro_indicators(), "plot_macro_indicators", "Indicators", "Indicators")
      render_plot(sharedData$fama_french_factors(), "plot_fama_french_factors", "Fama French Factors", "Fama French Factors")
    }
  )
}
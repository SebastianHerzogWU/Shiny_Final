sub_4_7_UI <- function(id) {
  ns <- NS(id)
  tagList(
    
    fluidPage(
      titlePanel("Rolling Window Regression and Loadings in selected Time Frame"),
      # Adding explanatory text
      p("Performing rolling window regression can be computationally expensive. To optimize performance, we use the `on-click` eventReactive() function, which replaces the reactive dependency from the inputs and takes it on the action button."),
      p(a("Read more here", href = "https://mastering-shiny.org/basic-reactivity.html#on-click")),
      sidebarLayout(
        sidebarPanel(
          dateInput(ns("start_date"), "Start Date", value = "2010-01-01"),
          dateInput(ns("end_date"), "End Date", value = "2019-01-01"),
          actionButton(ns("Start_GFC"), "Start to GFC"),
          #actionButton(ns("GFC_EuroCris"), "GFC to Euro Crisis"),
          actionButton(ns("EuroCris_Covid"), "Euro Crisis to Covid"),
          actionButton(ns("Covid_Present"), "Covid to Present"),
          numericInput(ns("current_observation"), "Regression Window:", value = 40, min = 1),
          selectInput(ns("variable_part"), "Select Variable(s):", choices = NULL),
          actionButton(ns("update_plot_roll_window"), "Update Plot")
        ),
        mainPanel(
          shinycssloaders::withSpinner(plotOutput(ns("pca_plot_part")), type = 2) # Add the spinner without using %>%
        )
      )
    )
  )
}

sub_4_7_Server <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      
# Input Selector -------------------------------------------------------------------
####################################################################################
########   Input Selector     ######################################################
####################################################################################
      observe({
        
        updateSelectInput(session, "variable_part", choices = names(correlation_df()))
        
      })

      
      
# Rolling Window Regression  -------------------------------------------------------
####################################################################################
####### Rolling Window Regression ##################################################
####################################################################################
      
      correlation_df <- reactive({
        start_date <- eventReactive(input$update_plot_roll_window, {input$start_date})
        end_date <- eventReactive(input$update_plot_roll_window, {input$end_date})
        current_observation <- eventReactive(input$update_plot_roll_window, {input$current_observation})
        
        ## Clean the Data and standardize
        df <- na.omit(df)
        df_standardized <- as.data.frame(lapply(df, function(x) (x - mean(x)) / sd(x)))
        df_standardized$Date <- as.Date(rownames(df))
        df1 <- df_standardized[, sapply(df_standardized, is.numeric)] #delete date column
        
        ## Remove highly correlated Columns
        correlation_threshold <- 0.85 #correlations 
        cor_matrix <- cor(df1) # Find highly correlated columns
        highly_correlated_cols <- findCorrelation(cor_matrix, cutoff = correlation_threshold)
        df1_no_high_correlation <- df1[, -highly_correlated_cols] # Remove highly correlated columns
        
        ## Print the resulting data frame without highly correlated columns
        df1_no_high_correlation <- subset(df1_no_high_correlation, select = -c(HO1.Comdty))
        df1_no_high_correlation$CL1.Comdty <- df1$`CL1 Comdty`
        df1 <- df1_no_high_correlation
        
        
        # Rolling Window PCA 
        ## Adjusting the df1 by the dates 
        #'Therefore we need to merge the dates with it again and after undo this column
        df1$Date <- as.Date(rownames(df))# Add row names of the original df dataframe to df1
        
        df1 <- df1[df1$Date >= start_date() & df1$Date <= end_date(), ]# Filter df1 based on the defined start and end date
        Dates <- df1$Date # Save the Dates for later
        df1 <- df1[, -ncol(df1)]  # Remove the Date column
        rownames(df1) <- NULL  # Remove row names
        
        ## Main of Rolling Window PCA
        perform_pca_x <- function(matrix_data) {
          pca_result <- prcomp(matrix_data, scale = TRUE)
          loadings <- pca_result$rotation
          loadings_pc1 <- loadings[, 1]
          return(loadings_pc1)  
        }
        
        
        n_rows <- nrow(df1) # df1 is the standardized dataframe without highly correlated columns
        roll_principal_components_x <- lapply(1:(n_rows - current_observation() + 1), function(i) {
          window_data <- df1[i:(i + current_observation() - 1), , drop = FALSE]
          perform_pca_x(window_data)
        })
        
        your_variable_names <- colnames(df1) #CREATING DATA FRAME WITH CORRELATION OF EACH VARIBLE WITH PC1
        correlation_df <- data.frame(matrix(ncol = length(your_variable_names), nrow = length(roll_principal_components_x)))
        colnames(correlation_df) <- your_variable_names
        
        # Fill in correlations for each variable at each time point
        for (i in 1:length(roll_principal_components_x)) {
          correlation_df[i, ] <- roll_principal_components_x[[i]] 
        }
        
        Dates <-Dates[current_observation():length(Dates)]
        
        rownames(correlation_df) <- Dates
        correlation_df$Dates <- rownames(correlation_df)
      
        return(correlation_df)
        
      }) %>% 
        bindEvent(input$update_plot_roll_window)
        
# Create Plot based on Dataframe ---------------------------------------------------
####################################################################################
######## Create Plot based on Dataframe  ###########################################
####################################################################################      
        output$pca_plot_part <- renderPlot({
          
        selected_vars <- input$variable_part # Filter data based on selected variables
        
        if (selected_vars == '') {
          selected_vars <- names(correlation_df())[-1] # If no variables selected, select all variables
        }
      
        
        plot_data <- correlation_df() %>%
          pivot_longer(cols = -Dates, names_to = "variable", values_to = "value") %>%
          filter(variable %in% selected_vars) # Filter data based on selected variables

        
       
        if (nrow(plot_data) == 0) {
          # If no data is selected, return a message plot
          p <- ggplot() + 
            geom_text(aes(x = 0.5, y = 0.5, label = "No data selected"), size = 10, color = "red") +
            theme_void()
          return(p)
        } else {
          # Plot
          p <- ggplot(data = plot_data, aes(x = as.Date(Dates), y = value, color = variable, group = 1)) +
            geom_line() +
            labs(x = "Dates", y = "Correlation with PC1", color = "Variable") +
            scale_x_date(date_breaks = "1 year", date_labels = "%Y") +  
            theme_minimal() +
            theme(legend.position = "right") +
            theme(axis.text.x = element_text(angle = 45, hjust = 1))
          return(p)
        }
        
      }) %>% 
        bindEvent(input$update_plot_roll_window)
      
      #### Date Definitions ####
      # Define the entire period from 1998 to the present
      entirePeriod <- data.frame(
        Date = seq(from = as.Date("2006-01-01"), to = Sys.Date(), by = "day"),
        Value = runif(length(seq(from = as.Date("2006-01-01"), to = Sys.Date(), by = "day")))
      )
      
      # Define event observers for the buttons
      observeEvent(input$Start_GFC, {
        updateDateInput(session, "start_date", value = "2006-01-01") # Start of GFC
        updateDateInput(session, "end_date", value = "2008-12-31")   # End of GFC
      })
      
      observeEvent(input$GFC_EuroCris, {
        updateDateInput(session, "start_date", value = "2008-12-31") # Start of EU Financial Crisis
        updateDateInput(session, "end_date", value = "2014-01-01")   # End of EU Financial Crisis
      })
      
      observeEvent(input$EuroCris_Covid, {
        updateDateInput(session, "start_date", value = "2014-01-01") # After EU Crisis
        updateDateInput(session, "end_date", value = "2019-12-31")   # Before Covid
      })
      
      observeEvent(input$Covid_Present, {
        updateDateInput(session, "start_date", value = "2020-01-01") # Start of Covid
        updateDateInput(session, "end_date", value = Sys.Date())     # To the present
      })
      
      ### End: Sub_4_8 Rolling window regression ####
    }
  )
}
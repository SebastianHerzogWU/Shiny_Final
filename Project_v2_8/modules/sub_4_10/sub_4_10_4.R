sub_4_10_4_UI <- function(id) {
  ns <- NS(id)
  tagList(
    fluidPage(
      h3("PC1 Variables"),
      sidebarLayout(
        sidebarPanel(
          selectInput(ns("dropdown"), "Select a Variable:", choices = NULL)),
        mainPanel(
          HTML("
            <p>In the plot below you see the result of a rolling regression, using window size 700 and step size 100.</p>
            <p>The dependent variable is the variance explained by PC1 and PC2. The regressors are the macro variables and the indices that we have self created.</p>
            <p>For each variable the plot below is generated. Each plot shows the (1-p value).</p>
            <p>Using this Approach, we can assess in the regression whether the variable was significant or not at any period of time.</p>
          "),
          shinycssloaders::withSpinner(plotOutput(ns("PC1_table")), type = 2) # Add a plot output for the rolling window plot
        )
      )
    )
  )
}

sub_4_10_4_Server <- function(id, sharedPcaData) {
  moduleServer(
    id,
    function(input, output, session) {
      
      # Input Selector -------------------------------------------------------------------
      ####################################################################################
      ########   Input Selector     ######################################################
      ####################################################################################
      observe({
        updateSelectInput(session, "dropdown", choices = sharedPcaData$list_names_sign_PC1())
      })
      
      # Table calc. for PC1 -----------------------------------------------------
      ###########################################################################
      ########   Table calc. for PC1    #########################################
      ###########################################################################
      sharedPcaData$tbl_p_values_variables_PC1 <- reactive({
      ### Setup ###
      merged_df1 <- sharedPcaData$merged_df1() # Input from shared Data
      window_size <- 700  # initial window size
      step_size <- 100    # step size
      significant_variables_PC1 <- list() # Initialize a list to store results 
      
      
      significant_df_PC1 <- data.frame(matrix(ncol = 0, nrow = nrow(merged_df1))) # Create an empty dataframe to store significant variables
      rownames(significant_df_PC1) <- merged_df1$Dates
      
      
      for (i in seq(1, nrow(merged_df1) - window_size, by = step_size)) { # Perform rolling regression
        start_index <- i # Define the start and end indices for the subset
        end_index <- i + window_size
        subset_data <- merged_df1[start_index:end_index, ] # Subset the data
        lm_model <- lm(PC1 ~ . - Dates, data = subset_data) # Fit the regression model
        p_values <- summary(lm_model)$coefficients[, "Pr(>|t|)"] # Get p-values for coefficients
        significant_df_PC1[i, names(p_values)] <- (1-p_values)
      }
      
      significant_df_PC1[is.na(significant_df_PC1)] <- FALSE
      significant_df_PC1 <- significant_df_PC1[rowSums(significant_df_PC1 != FALSE, na.rm = TRUE) > 0, ]
      significant_df_temp_PC1 <- as.data.frame(sapply(significant_df_PC1, as.integer))
      row_names <- rownames(significant_df_PC1) # Extract row names from significant_df
      rownames(significant_df_temp_PC1) <- row_names # Assign row names to significant_df_temp
      significant_df_temp_PC1 <- significant_df_PC1
      return(significant_df_temp_PC1)
      })
      
# Get the Input Variable  ----------------------------------------------------------
####################################################################################
######## Get the Input Variable  ###################################################
####################################################################################
      
      sharedPcaData$list_names_sign_PC1 <- reactive({
        significant_df_PC1 <- sharedPcaData$tbl_p_values_variables_PC1()
        list_names_sign_PC1 <- names(significant_df_PC1)
        list_names_sign_PC1
      })
      
# Create Plot based on Dataframe ---------------------------------------------------
####################################################################################
######## Create Plot based on Dataframe  ###########################################
####################################################################################
      
      output$PC1_table <- renderPlot({
        significant_df_PC1 <- sharedPcaData$tbl_p_values_variables_PC1()
        selected_variable_name <- input$dropdown

        if (!(selected_variable_name %in% names(significant_df_PC1))) { # Check if the selected variable exists in the dataframe
          return(NULL)
        }
        plot_data <- significant_df_PC1[[selected_variable_name]] # Get the plot data for double check
        if (length(plot_data) == 0 || !all(is.finite(plot_data))) { # Check if empty plot data based on  selected_variable_name
          return(NULL)
        }
        
        plot(plot_data, 
             type = "l", 
             xaxt = "n", 
             yaxt = "n", 
             xlab = ".", 
             ylab = selected_variable_name,
             main = selected_variable_name,
             ylim = c(0, 1))
        
        abline(h = 0.95, col = "red", lty = 2)
        axis(1, at = 1:length(row.names(significant_df_PC1)), labels = row.names(significant_df_PC1), las = 2)
        axis(2, at = c(0, 1), labels = c(0, 1))
      })
      
      
    }
  )
}
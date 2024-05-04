sub_4_10_5_UI <- function(id) {
  ns <- NS(id)
  tagList(
    fluidPage(
      h3("PC2 Variables"),
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
          shinycssloaders::withSpinner(plotOutput(ns("PC2_table")), type = 2) # Add a plot output for the rolling window plot
        )
      )
    )
  )
}

sub_4_10_5_Server <- function(id, sharedPcaData) {
  moduleServer(
    id,
    function(input, output, session) {
# Input Selector -------------------------------------------------------------------
####################################################################################
########   Input Selector     ######################################################
####################################################################################
      observe({
        updateSelectInput(session, "dropdown", choices = sharedPcaData$list_names_sign_PC2())
      })
      
# Table calc. for PC2 -----------------------------------------------------
###########################################################################
########   Table calc. for PC2    #########################################
###########################################################################
      sharedPcaData$tbl_p_values_variables_PC2 <- reactive({
        #### Setup ####
        merged_df2 <- sharedPcaData$merged_df2() # Input from shared Data
        window_size <- 700  # initial window size
        step_size <- 100    # step size
        significant_variables_PC2 <- list()# Initialize a list to store results
        
        # Create an empty dataframe to store significant variables
        significant_df_PC2 <- data.frame(matrix(ncol = 0, nrow = nrow(merged_df2)))  # Change merged_df1 to merged_df2
        rownames(significant_df_PC2) <- merged_df2$Dates  # Change merged_df1 to merged_df2
      
        for (i in seq(1, nrow(merged_df2) - window_size, by = step_size)) { # Perform rolling regression
          start_index <- i # Define the start and end indices for the subset
          end_index <- i + window_size
          subset_data <- merged_df2[start_index:end_index, ]  # Change merged_df1 to merged_df2
          lm_model <- lm(PC2 ~ . - Dates, data = subset_data)    # Fit the regression model
          p_values <- summary(lm_model)$coefficients[, "Pr(>|t|)"] # Get p-values for coefficients
          significant_vars <- names(p_values[p_values < 0.0001]) # Find significant variables (p-value < 0.0001)
          significant_variables_PC2[[i]] <- significant_vars # Store the significant variables
          significant_df_PC2[i, names(p_values)] <- (1-p_values) # Store significant variables in the dataframe
        }
        
        significant_df_PC2[is.na(significant_df_PC2)] <- FALSE
        significant_df_PC2 <- significant_df_PC2[rowSums(significant_df_PC2 != FALSE, na.rm = TRUE) > 0, ]
        significant_df_temp_PC2 <- as.data.frame(sapply(significant_df_PC2, as.integer))
        row_names <- rownames(significant_df_PC2) # Extract row names from significant_df

        rownames(significant_df_temp_PC2) <- row_names # Assign row names to significant_df_temp
        significant_df_temp_PC2 <- significant_df_PC2
        return(significant_df_temp_PC2)
      })
      
# Get the Input Variable  ----------------------------------------------------------
####################################################################################
######## Get the Input Variable  ###################################################
####################################################################################
      sharedPcaData$list_names_sign_PC2 <- reactive({
        significant_df_PC2 <- sharedPcaData$tbl_p_values_variables_PC2()
        list_names_sign_PC2 <- names(significant_df_PC2)
        list_names_sign_PC2
      })
      
# Create Plot based on Dataframe ---------------------------------------------------
####################################################################################
######## Create Plot based on Dataframe  ###########################################
####################################################################################
      output$PC2_table <- renderPlot({
        significant_df_PC2 <- sharedPcaData$tbl_p_values_variables_PC2()
        selected_variable_name <- input$dropdown
        
        if (!(selected_variable_name %in% names(significant_df_PC2))) { # Check if the selected variable exists in the dataframe
          return(NULL)
        }
        plot_data <- significant_df_PC2[[selected_variable_name]] # Get the plot data for double check
        if (length(plot_data) == 0 || !all(is.finite(plot_data))) { # Check if empty plot data based on  selected_variable_name
          return(NULL)
        }
        
        plot(plot_data, 
             type = "l", 
             xaxt = "n", 
             yaxt = "n", 
             xlab = ".", 
             ylab = selected_variable_name,  # Use sample_name directly
             main = selected_variable_name,  # Use sample_name directly
             ylim = c(0, 1))
        
        axis(1, at = 1:length(row.names(significant_df_PC2)), labels = row.names(significant_df_PC2), las = 2) # Add custom x-axis labels
        axis(2, at = c(0, 1), labels = c(0, 1)) # Add custom y-axis ticks for 0 and 1
        abline(h = 0.95, col = "red", lty = 2)
      })
      
    }
  )
}
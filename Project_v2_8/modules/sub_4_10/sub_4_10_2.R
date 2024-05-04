sub_4_10_2_UI <- function(id) {
  ns <- NS(id)
  tagList(
    fluidPage(
      h3("PC1 Variables"),
      sidebarLayout(
        sidebarPanel(
          selectInput(ns("dropdown"), "Select a Variable:", choices = NULL)),
          mainPanel(
            shinycssloaders::withSpinner(plotOutput(ns("PC1_table")), type = 2) # Add a plot output for the rolling window plot
        )
      )
    )
  )
}

sub_4_10_2_Server <- function(id, sharedPcaData) {
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
        sharedPcaData$tbl_sign_variables_PC1 <- reactive({
        ### Setup ###
        merged_df1 <- sharedPcaData$merged_df1() # Input from shared Data
        window_size <- 700  # initial window size
        step_size <- 100    # step size
        significant_variables_PC1 <- list()# Initialize a list to store results
        significant_df_PC1 <- data.frame(matrix(ncol = 0, nrow = nrow(merged_df1))) # Create an empty dataframe to store significant variables
        rownames(significant_df_PC1) <- merged_df1$Dates
        
        # Perform rolling regression
        for (i in seq(1, nrow(merged_df1) - window_size, by = step_size)) {
          start_index <- i # Define the start and end indices for the subset
          end_index <- i + window_size
          subset_data <- merged_df1[start_index:end_index, ] # Subset the data
          lm_model <- lm(PC1 ~ . - Dates, data = subset_data) # Fit the regression model
          p_values <- summary(lm_model)$coefficients[, "Pr(>|t|)"] # Get p-values for coefficients
          significant_vars <- names(p_values[p_values < 0.0001]) # Find significant variables (p-value < 0.0001)
          significant_variables_PC1[[i]] <- significant_vars # Store the significant variables
          significant_df_PC1[i, significant_vars] <- TRUE # Store significant variables in the dataframe
        }
        
        significant_df_PC1[is.na(significant_df_PC1)] <- FALSE
        significant_df_PC1 <- significant_df_PC1[rowSums(significant_df_PC1 != FALSE, na.rm = TRUE) > 0, ]
        significant_df_temp_PC1 <- as.data.frame(sapply(significant_df_PC1, as.integer))
        row_names <- rownames(significant_df_PC1) # Extract row names from significant_df
        rownames(significant_df_temp_PC1) <- row_names # Assign row names to significant_df_temp
        significant_df_temp_PC1 <- significant_df_PC1
        tbl_sign_variables <- significant_df_PC1
        
        
        return(tbl_sign_variables)
      })
      
# Get the Input Variable  ----------------------------------------------------------
####################################################################################
######## Get the Input Variable  ###################################################
####################################################################################
      
      sharedPcaData$list_names_sign_PC1 <- reactive({
        significant_df_PC1 <- sharedPcaData$tbl_sign_variables_PC1()
        list_names_sign_PC1 <- names(significant_df_PC1)
        list_names_sign_PC1
      })
      
# Create Plot based on Dataframe ---------------------------------------------------
####################################################################################
######## Create Plot based on Dataframe  ###########################################
####################################################################################
      
      output$PC1_table <- renderPlot({
        significant_df_PC1 <- sharedPcaData$tbl_sign_variables_PC1()
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
             ylab = selected_variable_name,  # Use sample_name directly
             main = selected_variable_name,  # Use sample_name directly
             ylim = c(0, 1))
        
        axis(1, at = 1:length(row.names(significant_df_PC1)), labels = row.names(significant_df_PC1), las = 2) # Add custom x-axis labels
        axis(2, at = c(0, 1), labels = c(0, 1)) # Add custom y-axis ticks for 0 and 1
        
        
      })
    }
  )
}
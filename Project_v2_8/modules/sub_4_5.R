sub_4_5_UI <- function(id) {
  ns <- NS(id)
  tagList(
    titlePanel("Correlation of the first Principal Component on the entire time frame."),
    sidebarLayout(
      sidebarPanel(selectInput(ns("variable"), "Select Variable(s):",
                               choices = NULL,
                               multiple = TRUE)
      ),
      mainPanel(
        shinycssloaders::withSpinner(plotOutput(ns("corr_loading_plot")), type = 2)
      )
    )
  )
}

sub_4_5_Server <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
# Input Selector -------------------------------------------------------------------
####################################################################################
########   Input Selector     ######################################################
####################################################################################
      observe({
        updateSelectInput(session, "variable", choices = names(correlation_df())[-1])
      })
      
# Table correlation_df ------------------------------------------------------------
###################################################################################
########   Table correlation_df    ################################################
###################################################################################      
      correlation_df <- reactive({
        ## Adjusting the df1 by the dates 
        #'Therefore we need to merge the dates with it again and after undo this column
        df1$Date <- as.Date(rownames(df))# Add row names of the original df dataframe to df1
        Dates <- df1$Date # Save the Dates for later
        df1 <- df1[, -ncol(df1)]  # Remove the Date column
        rownames(df1) <- NULL  # Remove row names
        
        n_rows <- nrow(df1) # df1 is the standardized dataframe without highly correlated columns
        current_observation <- 80
        
        perform_pca_x <- function(matrix_data) {
          pca_result <- prcomp(matrix_data, scale = TRUE)
          loadings <- pca_result$rotation
          loadings_pc1 <- loadings[, 1]
          return(loadings_pc1)
        }
        
        roll_principal_components_x <- lapply(1:(n_rows - current_observation + 1), function(i) {
          window_data <- df1[i:(i + current_observation - 1), , drop = FALSE]
          perform_pca_x(window_data)
        })
        
        # #CREATING DATA FRAME WITH CORRELATION OF EACH VARIBLE WITH PC1
        your_variable_names <- colnames(df1)
        correlation_df <- data.frame(matrix(ncol = length(your_variable_names), nrow = length(roll_principal_components_x)))
        colnames(correlation_df) <- your_variable_names
        
        # Fill in correlations for each variable at each time point
        for (i in 1:length(roll_principal_components_x)) {
          correlation_df[i, ] <- roll_principal_components_x[[i]]
        }
        
        Dates <-Dates[current_observation:length(Dates)]
        rownames(correlation_df) <- Dates
        correlation_df$Date <- rownames(correlation_df)
        return(correlation_df)
      })
      
      
# Create Plot based on Dataframe ---------------------------------------------------
####################################################################################
######## Create Plot based on Dataframe  ###########################################
####################################################################################
      
      output$corr_loading_plot <- renderPlot({
        selected_vars <- input$variable # Filter data based on selected variables
        if (is.null(selected_vars)) {
          selected_vars <- names(df1)[-1] # If no variables selected, select all variables
        }
        plot_data <- correlation_df() %>%
          pivot_longer(cols = -Date, names_to = "variable", values_to = "value") %>%
          filter(variable %in% selected_vars)
        
        # Plot
        ggplot(data = plot_data, aes(x = as.Date(Date), y = value, color = variable, group = 1)) +
          geom_line() +
          labs(x = "Date", y = "Correlation with PC1", color = "Variable") +
          scale_x_date(date_breaks = "1 year", date_labels = "%Y") +  
          theme_minimal() +
          theme(legend.position = "right") +
          theme(axis.text.x = element_text(angle = 45, hjust = 1))
      })
      

    }
  )
}

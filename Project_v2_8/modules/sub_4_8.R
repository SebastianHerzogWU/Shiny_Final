sub_4_8_UI <- function(id) {
  ns <- NS(id)
  tagList(
    titlePanel("Comparison of df1_value and D_value"),
    sidebarLayout(
      sidebarPanel(
        selectInput(ns("filter_value_comparison"), "Choose a filter value:",
                    choices = NULL) # Updated to be populated dynamically
      ),
      mainPanel(
        plotOutput(ns("plot_comparison"))
      )
    )
  )
}

sub_4_8_Server <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      
# Update Input ------------------------------------------------------------
###########################################################################
######  Update choices of selectInput based on df1_comparison  ############
###########################################################################
      
      observe({
        updateSelectInput(session, "filter_value_comparison",
                          choices = names(df1))
      })
      
# Create output -----------------------------------------------------------
###########################################################################
######  Create output  ####################################################
###########################################################################
#' Not that df1 (or df1_comparison with the date) is the standard PCA apporach on the entire date
#' the D_subset is the PCA approach with the same data but only including the first 5 PC's
    
      output$plot_comparison <- renderPlot({
        filter_value <- input$filter_value_comparison
        
        # Create df1_comparison
        df1_comparison <- df1
        index_data <- na.omit(index_data)
        df1_comparison$Date <- rownames(index_data)
        
        # select the column from df1
        filter_value_df1 <- df1_comparison %>%
          select(Date, !!sym(filter_value)) %>%
          rename(df1_value = !!sym(filter_value))

        # Create first 5 PC's -----------------------------------------------------
        ###########################################################################
        ########   Create Subset of first 5 PC's###################################
        ###########################################################################
      
        full_pca <- prcomp(df1) # PCA on full dataset
        X <- full_pca$x # Get PCs
        L <- full_pca$rotation # Get Loadings
        if (!is.matrix(X)) X <- as.matrix(X) #transform to a matrix
        if (!is.matrix(L)) L <- as.matrix(L) #transform to a matrix
        L_transpose <- t(L) # Transpose matrix L
        D <- X %*% L_transpose # Perform matrix multiplication
        X_subset <- X[, 1:5] #now take PC which explain more than 5% of variance, so PC1-PC5
        L_subset <- L[, 1:5] # same for loadings
        L_subset_transpose <- t(L_subset) # Transpose matrix L_subset
        D_subset <- as.data.frame(X_subset %*% L_subset_transpose) # Perform matrix multiplication
        

        # Filter Dataframe---------------------------------------------------------
        ###########################################################################
        ########   Filter Dataframe ###############################################
        ###########################################################################
        
        filter_value_D <- D_subset %>%
          select(!!sym(filter_value)) %>%
          rename(D_value = !!sym(filter_value))
        
        merged <- merge(filter_value_df1, filter_value_D, by = 'row.names')
        merged <- merged[-c(1)]
        
        # Create Plots ------------------------------------------------------------
        ###########################################################################
        ########  Create Plots      ###############################################
        ###########################################################################
        
        # Plotting the time series
        plot_lines <- ggplot(merged, aes(x = Date,group = 1)) +
          geom_line(aes(y = df1_value, color = "df1_value")) +
          geom_line(aes(y = D_value, color = "D_value")) +
          labs(title = "Comparison of df1_value and D_value",
               y = "Value") +
          theme_minimal() +
          theme(legend.position = "top") +
          scale_color_manual(values = c("df1_value" = "blue", "D_value" = "red"))
        
        # Adding a spread plot for the difference
        plot_spread <- ggplot(merged, aes(x = Date, y = df1_value - D_value,group = 1)) +
          geom_line() +
          labs(title = "Spread Plot: Difference between df1_value and D_value",
               y = "Difference") +
          theme_minimal() +
          theme(legend.position = "none")
        
        # Combine plots
        combined_plot <- cowplot::plot_grid(plot_lines, plot_spread, ncol = 1, align = "v", axis = "tb", rel_heights = c(3, 2))
        combined_plot
        
      })
    }
  )
}

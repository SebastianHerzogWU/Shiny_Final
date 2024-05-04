sub_4_6_UI <- function(id) {
  ns <- NS(id)
  tagList(
    titlePanel("Moving Average"),
    sidebarLayout(
      sidebarPanel(
        selectInput(ns("select_pc_mov_avg"), "SELECT PC", choices = c("PC1", "PC2")),
        sliderInput(ns("select_window_size_mov_avg"), "WINDOW SIZE Moving Average", min = 10, max = 500, value = 100, step = 20)
      ),
      mainPanel(
        plotOutput(ns("plot_PC_Moving_Average"))
      )
    )
  )
}

sub_4_6_Server <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      
      df_pca_combined <- reactive({
        
        # KMO Test ----------------------------------------------------------------
        current_observation <- 80 # Initialize variables
        target_msa <- 0.91
        
        # Rolling Window PCA ------------------------------------------------------
        
        ## Adjusting the df1 by the dates 
        #'Therefore we need to merge the dates with it again and after undo this column
        df1$Date <- as.Date(rownames(df))# Add row names of the original df dataframe to df1
        start_date <- as.Date("2006-12-01") # Manually define a start date
        end_date <- as.Date("2023-12-05") # Manually define a end date
        df1 <- df1[df1$Date >= start_date & df1$Date <= end_date, ]# Filter df1 based on the defined start and end date
        Dates <- df1$Date # Save the Dates for later
        df1 <- df1[, -ncol(df1)]  # Remove the Date column
        rownames(df1) <- NULL  # Remove row names
        
        ## Main of Rolling Window PCA
        perform_pca <- function(matrix_data) {
          pca_result <- prcomp(matrix_data, scale = TRUE)
          return(pca_result$sdev^2/sum(pca_result$sdev^2))  
        }
        
        n_rows <- nrow(df1) # df1 is the standardized dataframe without highly correlated columns
        roll_principal_components <- lapply(1:(n_rows - current_observation + 1), function(i) {
          window_data <- df1[i:(i + current_observation - 1), , drop = FALSE]
          perform_pca(window_data)
        })
        
        
        #Dates <-rownames(df)
        Dates <-Dates[current_observation:length(Dates)]
        
        ## Create PC1
        PC1 <- sapply(roll_principal_components, function(x) x[1]) # Create a vector containing the first element of each list element
        PC1 <-as.data.frame(PC1)
        rownames(PC1) <- Dates
        PC1$Dates <- row.names(PC1)
        
        ## Create PC2
        PC2 <-  sapply(roll_principal_components, function(x) x[2]) # Create a vector containing the first element of each list element
        PC2 <-as.data.frame(PC2)
        rownames(PC2) <- Dates
        PC2$Dates <- row.names(PC2)
        
        #Output
        df_pca_output <- dplyr::inner_join(PC1, PC2, by = "Dates") # Perform inner join
        df_pca_output$Dates <- as.Date(df_pca_output$Dates) #as date. better safe than sorry
        
        return(df_pca_output)
      })
      
      
      # Reactive function to generate plot based on selected PC and window size
      plot_PC_Moving_Average <- reactive({
        PC <- input$select_pc_mov_avg
        window_size <- input$select_window_size_mov_avg
        
        PC1_Plot <- df_pca_combined()
        PC1_Plot$Moving_Avg <- zoo::rollmean(PC1_Plot[[PC]], k = window_size, fill = NA)
        PC1_Plot$Moving_SD <- zoo::rollapply(PC1_Plot[[PC]], width = window_size, FUN = sd, fill = NA)
        PC1_Plot$Upper_Bound <- PC1_Plot$Moving_Avg + PC1_Plot$Moving_SD
        PC1_Plot$Lower_Bound <- PC1_Plot$Moving_Avg - PC1_Plot$Moving_SD
        PC1_Plot$Lower_Bound[is.na(PC1_Plot$Lower_Bound)] <- PC1_Plot[[PC]][is.na(PC1_Plot$Lower_Bound)]
        PC1_Plot$Upper_Bound[is.na(PC1_Plot$Upper_Bound)] <- PC1_Plot[[PC]][is.na(PC1_Plot$Upper_Bound)]
        PC1_Plot$Moving_Avg[is.na(PC1_Plot$Moving_Avg)] <- PC1_Plot[[PC]][is.na(PC1_Plot$Moving_Avg)]
        PC1_Plot$Within_1SD <- PC1_Plot[[PC]] >= PC1_Plot$Lower_Bound & PC1_Plot[[PC]] <= PC1_Plot$Upper_Bound
        PC1_Plot$Within_1SD <- ifelse(PC1_Plot$Within_1SD, "TRUE", "FALSE")
        PC1_Plot$Dates <- as.Date(PC1_Plot$Dates)
        
        ggplot(PC1_Plot, aes(x = Dates, y = !!sym(PC), color = Within_1SD, group = 1)) + 
          geom_point(size = 1) +
          geom_line(aes(y = Upper_Bound), color = "blue") +
          geom_line(aes(y = Lower_Bound), color = "blue") +
          geom_line(aes(y = Moving_Avg), color = "red") +
          scale_color_manual(values = c("TRUE" = "lightblue", "FALSE" = "coral")) +
          labs(title = "Moving average and SD", x = "Date Index", y = PC) +
          theme(panel.border = element_rect(linetype = "dashed", fill = NA), panel.grid.major = element_line(colour = "lightgrey"), legend.position="top")
      })
      
      # Output the prev. gen. plot
      output$plot_PC_Moving_Average <- renderPlot({
        plot_PC_Moving_Average()
      })
    }
  )
}


sub_4_4_UI <- function(id) {
  ns <- NS(id)
  tagList(
    h1("KMO Test"),
    plotOutput(ns("plot")),
    br(),
    HTML("
      <p style='font-size: 14px;'>
        <b>Observation Frames:</b> On the plot for the KMO Test, we observe that small increments in the beginning that there is a rapid increase in MSA value.
        <br>
        <b>Threshold:</b> However, stable MSA levels above a threshold of 75 are only reached if we pass the 60 observation mark.
        <br>
        <b>Stable Growth:</b> From there on, one can observe stable growth. To reach further higher MSA levels, one needs to tremendously add observations.
        <br>
        <b>Tradeoff:</b> There is a tradeoff since we would lose variation if we apply the Principal Compnent Method Method with such long time frames.
        <br>
        <b>Additional Observations:</b> If we aimed to reach a higher level of only 0.05 more, we would need to observe 410 observations.
        <br>
        <b>Final Threshold and Observations:</b> Hence, we finally settle for the threshold of 0.85 reached by 80 Observations. This value is als recommmended by Kieser (see Page PCA-Explained Tab KMO).
      </p>
    ")
  )
}



sub_4_4_Server <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      
# Compute kmo_results_df -----------------------------------------------------------
####################################################################################
########  Compute kmo_results_df ###################################################
####################################################################################      
      
      
      kmo_results_df <- reactive({
        current_observation <- 40 # Initialize variables
        target_msa <- 0.91
        kmo_results_df <- data.frame(Observation = numeric(),
                                     KMO_Result = numeric())
        while (TRUE) {
          df_temp <- df1[1:current_observation, ]
          kmo_result <- psych::KMO(df_temp)
          kmo_results_df <- rbind(kmo_results_df, data.frame(Observation = current_observation, KMO_Result = kmo_result$MSA))
          if (kmo_result$MSA >= target_msa) {
            #cat("Reached target MSA:", kmo_result$MSA, "at observation", current_observation, "\n") # print the Exit
            break  
          }
          current_observation <- current_observation + 1  
        }
        
        kmo_results_df <- round(kmo_results_df, digits = 4)
        return(kmo_results_df)
      })

# Create Plot output ---------------------------------------------------------------
####################################################################################
######## Create Plot output ########################################################
####################################################################################      
      
      
      output$plot <- renderPlot({
        highlight_df <- data.frame(
          x = c(80, 410),
          label = c("80", "410")
        )
        
        
        ggplot(kmo_results_df(), aes(x = Observation, y = KMO_Result)) +
          geom_point() +  # Scatter plot
          geom_vline(xintercept = c(80, 410), linetype = "dotted", color = "red") +  # Vertical lines
          geom_text(data = highlight_df, aes(x = x, y = -0.05, label = label), color = "red") +  # Highlight x-axis values
          geom_text(data = subset(kmo_results_df(), Observation %in% c(80, 410)), aes(label = as.character(KMO_Result)), vjust = -0.5, color = "red") +  # Text annotations
          labs(x = "Observation", y = "KMO Result") +  # Axes labels
          theme_minimal() +  # Minimal theme
          theme(
            axis.text = element_text(size = 14),  # Font size for axis labels
            axis.title = element_text(size = 16)  # Font size for axis titles
          )
      })
    }
  )
}

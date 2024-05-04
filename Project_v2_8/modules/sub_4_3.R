sub_4_3_UI <- function(id) {
  ns <- NS(id)
  tagList(
    h1("Scree Plot for the first simple PC Analysis"),
    plotOutput(ns("scree_plot"))
  )
}

sub_4_3_Server <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      output$scree_plot <- renderPlot({
        # Scree Plot: variance explained by each PC in a graph 
        plot(prcomp(df1)$sdev^2, type = "b", pch = 19, main = "Scree Plot", xlab = "Principal Component", ylab = "Eigenvalue")
      })
    }
  )
}

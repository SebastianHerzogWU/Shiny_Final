plot_UI <- function(id, dataset) {
  ns <- NS(id)
  tagList(
    fluidPage(
    sidebarLayout(
      sidebarPanel(
        selectInput(
          ns('select_var_1'),
          'Variable 1',
          choices = names(dataset)
        ),
        selectInput(
          ns('select_var_2'),
          'Variable 2',
          choices = names(dataset)
        ),
        actionButton(
          ns('draw_scatterplot'),
          'Draw Scatterplot'
        )
      ),
      mainPanel(
        plotOutput(ns('scatterplot'))
      )
    )
    )
  )
}

plot_Server <- function(id, dataset) {
  moduleServer(
    id,
    function(input, output, session) {
      output$scatterplot <- renderPlot({
        ggplot(dataset) +
          geom_point(
            aes_string(input$select_var_1, input$select_var_2),
            size = 3,
            alpha = 0.5,
            col = 'dodgerblue4'
          )
      }) %>% 
        bindEvent(input$draw_scatterplot)
    }
  )
}
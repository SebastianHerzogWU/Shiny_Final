sub_1_2_UI <- function(id) {
  
  ns <- NS(id)
  
  tagList(
    fluidPage(titlePanel("Kick-Off Meeting Instruction PDF"),
               htmlOutput(ns("instruction_pdf"))
    )
             
  )
}

sub_1_2_Server <- function(id) {
  
  moduleServer(id, function(input, output, session) {
    
    output$instruction_pdf <- renderUI({
      tags$iframe(style = "height:600px; width:100%", src = "PDF/Various/instructions.pdf") # Display PDF using iframe
    })
  })
}

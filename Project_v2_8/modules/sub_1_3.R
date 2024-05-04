library(shiny)

sub_1_3_UI <- function(id, pdf_files, pdf_folder) {
  ns <- NS(id)
  tagList(
    fluidPage(
      h4("Please select a PDF by the dropdown window"),
      sidebarLayout(
        sidebarPanel(
          selectInput(ns("selectedPdf"), "Select PDF file", choices = basename(pdf_files))
        ),
        mainPanel(
          h3("Selected PDF:"),
          uiOutput(ns("pdfViewer"))
        )
      )
    )
  )
}

sub_1_3_Server <- function(id, pdf_files, pdf_folder) {
  moduleServer(
    id,
    function(input, output, session) {
      observeEvent(input$selectedPdf, {
        
        
        # Function to cut the PDF path
        cut_pdf_path <- function(path) {
          parts <- strsplit(path, "/")[[1]]
          index <- which(parts == "PDF") # Find index of "PDF"
          if (length(index) > 0) {
            cut_part <- paste(parts[index:length(parts)], collapse = "/")
            return(cut_part)
          } else {
            return("Invalid path: 'PDF' not found.")
          }
        }
        
        selected_pdf_path <- file.path(pdf_folder, input$selectedPdf)
        
        cut_path <- cut_pdf_path(selected_pdf_path)
        

        output$pdfViewer <- renderUI({
          tags$iframe(
            src = cut_path,
            width = "100%",
            height = "800px",
            scrolling = "yes"
          )
        })
      })
    }
  )
}

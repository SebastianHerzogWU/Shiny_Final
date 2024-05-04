sub_1_0_UI <- function(id) {
  ns <- NS(id)
  tagList(
    fluidPage(
      titlePanel("Industry Lab 2023/24"),
      tags$style(HTML("
                    .box.box-solid.box-primary>.box-header {
                    color:#fff;
                    background:#FF8C00
                    }
                    .box.box-solid.box-primary{
                    background:#FAEBD7
                    }

                    ")),
      mainPanel(width = 12,
                box(title = "Welcome to the Industry Lab 2023/24 Shiny Dashboard!", solidHeader = TRUE, status = "primary", collapsible = TRUE,
                    p("This dashboard combines the entire exploration and findings for the 2023/24 PWC ILAB."),
                    p("Use the tabs on the left to navigate through the different sections."),
                    p("Start with the 'Introduction' tab and its subtabs to learn more about the purpose and progress of this ILAB Project."),
                    p("Under the tab 'Data' you can explore all used the data sets that we used. With various methods like agregating, simple statistics or plots you can learn more about them."),
                    p("The main exploration is under 'Methodology: PCA'. Explore here how PCA works and how we used it in various ways on the given data."),
                    p("We hope you have a great time  exploring and analyzing the hidden drivers of asset prices by this shiny app.")
                ),
                h3("Collaboration"),
                hr(class = "header-line"),  # Horizontal line after the header
                fluidRow(
                  column(3, 
                         img(src = "images/Logo-pwc.png", width = "65%"),
                         tags$figcaption("PWC Wien")
                  ),
                  column(3, 
                         img(src = "images/Logo_Wirtschaftsuniversitaet_Wien.png",  width = "100%"),
                         tags$figcaption("Wirtschaftsuniversität Wien")
                  )
                )
      )
    )
  )
}

sub_1_0_Server <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      
    }
  )
}
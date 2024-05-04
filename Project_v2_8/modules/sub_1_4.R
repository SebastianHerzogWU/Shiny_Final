sub_1_4_UI <- function(id) {
  ns <- NS(id)
  tagList(
    tags$style(HTML(".header-line { border-top: 2px solid grey; }")),
    h3("PWC Consulting "),
    hr(class = "header-line"),  # Horizontal line after the header
    fluidRow(
      column(3, 
             tags$img(src = "Team/Koellich.jpeg", height = "200px", width = "200px"),
             tags$figcaption("Christian Koellich")
      ),
      column(3, 
             img(src = "Team/Moemken.jpeg", height = "200px", width = "200px"),
             tags$figcaption("Florian Mömken")
      )
    ),
    h3("WU-Faculty"),
    hr(class = "header-line"),  # Horizontal line after the header
    fluidRow(
      column(3, 
             img(src = "Team/Pauer.jpeg", height = "200px", width = "200px"),
             tags$figcaption("Florian Pauer")
      ),
      column(3, 
             img(src = "Team/Handler.jpeg", height = "200px", width = "200px"),
             tags$figcaption("Lukas Handler")
      )
    ),
    h3("Qfin Students"),
    hr(class = "header-line"),  # Horizontal line after the header
    fluidRow(
      column(2, 
             img(src = "Team/Sophie.jpeg", height = "150px", width = "150px"),
             tags$figcaption("Sophie Grill")
      ),
      column(2, 
             img(src = "Team/Arina.jpeg", height = "150px", width = "150px"),
             tags$figcaption("Arina Sukhodolova")
      ),
      column(2, 
             img(src = "Team/Dinara.jpeg", height = "150px", width = "150px"),
             tags$figcaption("Dinara Zainullina")
      ),
      column(2, 
             img(src = "Team/Aleksei.jpg", height = "150px", width = "150px"),
             tags$figcaption("Aleksei Volodin")
      ),
      column(2, 
             img(src = "Team/Sebastian.jpeg", height = "150px", width = "150px"),
             tags$figcaption("Sebastian Herzog")
      )
    )
  
  )
}

sub_1_4_Server <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      
    }
  )
}
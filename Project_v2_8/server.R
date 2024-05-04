# Server Setup   -----------------------------------------------------
######################################################################
######## Server Setup  ###############################################
######################################################################


server <- function(input, output, session) {
  
# Observer to load modules  ------------------------------------------
######################################################################
####### Observer to load modules #####################################
######################################################################
  
  observe({
    cat("input$mytabitems ", input$mytabitems, "\n")
    cat("input$menu_1 ", input$menu_1, "\n")
    cat("input$menu_2 ", input$menu_2, "\n")
    cat("input$sub_1_1 ", input$sub_1_1, "\n")
    cat("input$sub_1_2 ", input$sub_1_2, "\n")
    cat("input$sub_1_3 ", input$sub_1_3, "\n")
    cat("input$sub_1_4 ", input$sub_1_4, "\n")
    cat("input$sub_1_5 ", input$sub_1_5, "\n")
    cat("input$menu_3 ", input$menu_3, "\n")
    cat("input$sub_3_1 ", input$sub_3_1, "\n")
    cat("input$sub_3_2 ", input$sub_3_2, "\n")
    cat("input$sub_3_3 ", input$sub_3_3, "\n")
    cat("input$sub_3_4 ", input$sub_3_4, "\n")
    cat("input$menu_4 ", input$menu_4, "\n")
    cat("input$sub_4_1 ", input$sub_4_1, "\n")
    cat("input$sub_4_2 ", input$sub_4_2, "\n")
    cat("input$sub_4_3 ", input$sub_4_3, "\n")
    cat("input$sub_4_4 ", input$sub_4_4, "\n")
    cat("input$sub_4_5 ", input$sub_4_5, "\n")
    cat("input$sub_4_6 ", input$sub_4_6, "\n")
    cat("input$sub_4_7 ", input$sub_4_7, "\n")
    cat("input$sub_4_8 ", input$sub_4_8, "\n")
    cat("input$sub_4_9 ", input$sub_4_9, "\n")
    cat("input$sub_4_10 ", input$sub_4_10, "\n")
  })
  
  observeEvent(input$sidebarItemExpanded, {
    if (input$sidebarItemExpanded == "MenuItem2") {
      print("updating tab items")
      shinydashboard::updateTabItems(session, "mytabitems", "sub_1_1")
    }
  })
  
  
  output$tb <- renderTable({
    Sys.sleep(3) # system sleeping for 3 seconds for demo purpose
  })

  
# Initialize shared Data   -------------------------------------------
######################################################################
######## Initialize shared Data  #####################################
######################################################################

sharedData <- reactiveValues() # Create a sharedData reactiveValues object
sharedPcaData <- reactiveValues() # Create a sharedData reactiveValues object
  
# Load modules   -----------------------------------------------------
######################################################################
######## Load modules  ###############################################
######################################################################

#Server 1.x  
  sub_1_0_Server("sub_1_0_id")
  sub_1_2_Server("sub_1_2_id")
  sub_1_3_Server("sub_1_3_1_id", minutes_files, minutes_folder) # Minutes
  sub_1_3_Server("sub_1_3_2_id", presentation_files, presentation_folder) # Presentations 
  sub_1_3_Server("sub_1_3_3_id", resources_files, resources_folder) # Other Resources
  sub_1_4_Server("sub_1_4_id")
  sub_1_5_Server("sub_1_5_id")
  
#Server 3.x  
  sub_3_1_Server("sub_3_1_id")
  sub_3_2_Server("sub_3_2_id")
  sub_3_3_Server("sub_3_3_id")
  sub_3_4_Server("sub_3_4_id")
  
#Server 4.x
  sub_4_1_1_Server("sub_4_1_1_id") # PCA Basics
  sub_4_1_2_Server("sub_4_1_2_id") # Loadings
  sub_4_1_3_Server("sub_4_1_3_id") # KMO
  sub_4_1_4_Server("sub_4_1_4_id") # Pros vs. Cons
  sub_4_2_Server("sub_4_2_id")
  sub_4_3_Server("sub_4_3_id")
  sub_4_4_Server("sub_4_4_id")
  sub_4_5_Server("sub_4_5_id")
  sub_4_6_Server("sub_4_6_id")
  sub_4_7_Server("sub_4_7_id")
  sub_4_8_Server("sub_4_8_id")
  #Server 4.9
    sub_4_9_1_Server("sub_4_9_1_id")
    sub_4_9_2_Server("sub_4_9_2_id", sharedData) # Call the module and pass the sharedData
    sub_4_9_3_Server("sub_4_9_3_id", sharedData) # Call the module and pass the sharedData
    sub_4_9_4_Server("sub_4_9_4_id", sharedData) # Call the module and pass the sharedData
    sub_4_9_5_Server("sub_4_9_5_id", sharedData) # Call the module and pass the sharedData
    sub_4_9_6_Server("sub_4_9_6_id", sharedData) # Call the module and pass the sharedData
    sub_4_9_7_Server("sub_4_9_7_id", sharedData) # Call the module and pass the sharedData
    sub_4_9_8_Server("sub_4_9_8_id", sharedData) # Call the module and pass the sharedData
    sub_4_9_9_Server("sub_4_9_9_id", sharedData) # Call the module and pass the sharedData
  #Server 4.10
    sub_4_10_1_Server("sub_4_10_1_id", sharedPcaData) # Call the module and pass the sharedPcaData
    sub_4_10_2_Server("sub_4_10_2_id", sharedPcaData) # Call the module and pass the sharedPcaData
    sub_4_10_3_Server("sub_4_10_3_id", sharedPcaData) # Call the module and pass the sharedPcaData
    sub_4_10_4_Server("sub_4_10_4_id", sharedPcaData) # Call the module and pass the sharedPcaData
    sub_4_10_5_Server("sub_4_10_5_id", sharedPcaData) # Call the module and pass the sharedPcaData
}
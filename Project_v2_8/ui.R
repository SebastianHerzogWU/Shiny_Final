# UI Setup   ---------------------------------------------------------
######################################################################
######## UI Setup  ###################################################
######################################################################

# def header ---------------------------------------------------------
######################################################################
######## def header   ################################################
######################################################################
header <- shinydashboard::dashboardHeader(title = "PWC ILab",

  dropdownMenu(type = "tasks", badgeStatus = "success",
             taskItem(value = 100, color = "blue",
                      "Data Collection"
             ),
             taskItem(value = 100, color = "blue",
                      "Main Calculation in R"
             ),
             taskItem(value = 99, color = "blue",
                      "Shiny Bug Fixing"
             ),
             taskItem(value = 80, color = "blue",
                      "Final Presentation"
             )
  )
)

# def sidebar --------------------------------------------------------
######################################################################
######## def sidebar #################################################
###################################################################### 
sidebar <- shinydashboard::dashboardSidebar(
  shinydashboard::sidebarMenu(
    id = "mytabitems",
    shinydashboard::menuItem(" Welcome Page", tabName = "menu_1", icon = icon("dashboard")),
    shinydashboard::menuItem(" Introduction",
             tabName = "menu_2",
             shinydashboard::menuSubItem("Task Summary", tabName = "sub_1_1", icon = icon("clipboard-list")),
             shinydashboard::menuSubItem("Kick-Off PDF", tabName = "sub_1_2", icon = icon("file-pdf")),
             shinydashboard::menuSubItem("PDF Viewer", tabName = "sub_1_3", icon = icon("file-pdf")),
             shinydashboard::menuSubItem("Team", tabName = "sub_1_4", icon = icon("people-group")),
             shinydashboard::menuSubItem("Shiny_APP", tabName = "sub_1_5", icon = icon("r-project")),
             icon = icon("th")
    ),
    shinydashboard::menuItem(" Data ",
             tabName = "menu_3",
             shinydashboard::menuSubItem("Data Sources", tabName = "sub_3_1", icon = icon("cloud-arrow-down")),
             shinydashboard::menuSubItem("Simple Statistics", tabName = "sub_3_2", icon = icon("chart-simple")),
             shinydashboard::menuSubItem("Detailed Statistics", tabName = "sub_3_3", icon = icon("chart-simple")),
             shinydashboard::menuSubItem("Simple Plotting ", tabName = "sub_3_4", icon = icon("chart-bar")),
             icon = icon("database")
    ),
    shinydashboard::menuItem("Methodology: PCA ",
             tabName = "menu_4",
             shinydashboard::menuSubItem("PCA-Explained", tabName = "sub_4_1", icon = icon("chart-simple")),
             shinydashboard::menuSubItem("Simple PC-Plot", tabName = "sub_4_2", icon = icon("chart-bar")),
             shinydashboard::menuSubItem("Scree Plot", tabName = "sub_4_3", icon = icon("chart-simple")),
             shinydashboard::menuSubItem("KMO Test", tabName = "sub_4_4", icon = icon("magnifying-glass-chart")),
             icon = icon("magnifying-glass"),
             shinydashboard::menuSubItem("PC1 Loading", tabName = "sub_4_5", icon = icon("magnifying-glass-plus")),
             shinydashboard::menuSubItem("Moving Averages", tabName = "sub_4_6", icon = icon("gauge")),
             shinydashboard::menuSubItem("Partial Regression", tabName = "sub_4_7", icon = icon("scissors")),
             shinydashboard::menuSubItem("Dual Comparison", tabName = "sub_4_8", icon = icon("code-compare")),
             shinydashboard::menuSubItem("PCA on Index", tabName = "sub_4_9", icon = icon("gears")),
             shinydashboard::menuSubItem("Siginificant. Var.", tabName = "sub_4_10", icon = icon("check"))
    )
  )
  
)


# def body  ----------------------------------------------------------
######################################################################
######## def body  ###################################################
###################################################################### 
body <- shinydashboard::dashboardBody(
  shinydashboard::tabItems(
    shinydashboard::tabItem(
      tabName = "menu_1",
      fluidPage(
        
        theme = shinytheme("sandstone"), # Apply the Sandstone Bootstrap theme
        useShinyjs(), # Initialize shinyjs
        tags$style(HTML(
        ".well { background-color: #f8efc0; } /* Light yellow background for sidebar */
         .navbar, .navbar-default { background-color: #f0c05a; border-color: #f0c05a; } /* Dark yellow for the navbar */
         .navbar-default .navbar-nav > .active > a { background-color: #e0b04a; } /* Even darker yellow for active navbar links */
         .btn-default { background-color: #f0c05a; border-color: #e0b04a; } /* Dark yellow for buttons */
         .btn-default:hover { background-color: #e0b04a; } /* Darker yellow on hover */
         .panel { border-color: #f0c05a; } /* Dark yellow panel borders */")),
        
        
        
        sub_1_0_UI("sub_1_0_id")
      )
      
    ),
    shinydashboard::tabItem(
      tabName = "menu_2",
      fluidPage(
      )
    ),
    shinydashboard::tabItem(
      tabName = "sub_1_1",
      fluidPage(
        h1("Sub Menu Page 1"),
        HTML("<p>The text of this module should be created last to capture all functions of the app.</p>"),
        HTML("
                <ul>
                  <li>All Functions should be included and guidence provided</li>
                  <li>All input and background calculations should be done. </li>
                  <li>All results should be obtained and inperpreated somewhere. </li>
                </ul>
                ")
        )
      ),
    shinydashboard::tabItem(
      tabName = "sub_1_2",
      fluidPage(
        sub_1_2_UI("sub_1_2_id"),
      )
    ),
    
    shinydashboard::tabItem(
      tabName = "sub_1_3",
      fluidPage(
        h1("PDF Viewer and Downloader"),
        tabsetPanel(
          tabPanel("Minutes", sub_1_3_UI('sub_1_3_1_id', minutes_files, minutes_folder)),
          tabPanel("Presentation", sub_1_3_UI('sub_1_3_2_id', presentation_files, presentation_folder)),
          tabPanel("Other Resources", sub_1_3_UI('sub_1_3_3_id', resources_files, resources_folder))
        )
      )
    ),
    
    
    shinydashboard::tabItem(
      tabName = "sub_1_4",
      sub_1_4_UI("sub_1_4_id")
    ),
    
    shinydashboard::tabItem(
      tabName = "sub_1_5",
      sub_1_5_UI("sub_1_5_id")
    ),
    
    shinydashboard::tabItem(
      tabName = "menu_3",
      fluidPage(
        
        h1("Homepage 3")
      )
    ),
    
    shinydashboard::tabItem(
      tabName = "sub_3_1",
      fluidPage(
        sub_3_1_UI("sub_3_1_id")
      )
    ),
    
    
    
    shinydashboard::tabItem(
      tabName = "sub_3_2",
      fluidPage(
        sub_3_2_UI("sub_3_2_id")
      )
    ),
    shinydashboard::tabItem(
      tabName = "sub_3_3",
      fluidPage(
        sub_3_3_UI("sub_3_3_id")
        )
      ),
    
    shinydashboard::tabItem(
      tabName = "sub_3_4",
      fluidPage(
        sub_3_4_UI("sub_3_4_id")
      )
    ),
    shinydashboard::tabItem(
      tabName = "menu_4",
      fluidPage(
        h1("Homepage 4")
      )
    ),
    shinydashboard::tabItem(
      tabName = "sub_4_1",
      fluidPage(
        h1("Principal Component Analysis Explained"),
        tabsetPanel(
          tabPanel("Method", sub_4_1_1_UI("sub_4_1_1_id")),
          tabPanel("Loadings", sub_4_1_2_UI("sub_4_1_2_id")),
          tabPanel("KMO-Test", sub_4_1_3_UI("sub_4_1_3_id")),
          tabPanel("Advantages of PCA", sub_4_1_4_UI("sub_4_1_4_id")),
        )
      )
    ),
    shinydashboard::tabItem(
      tabName = "sub_4_2",
      fluidPage(
        sub_4_2_UI("sub_4_2_id")
      )
    ),
    shinydashboard::tabItem(
      tabName = "sub_4_3",
      fluidPage(
        sub_4_3_UI("sub_4_3_id")
      )
    ),
    shinydashboard::tabItem(
      tabName = "sub_4_4",
      fluidPage(
        sub_4_4_UI("sub_4_4_id")
      )
    ),
    shinydashboard::tabItem(
      tabName = "sub_4_5",
      fluidPage(
        sub_4_5_UI("sub_4_5_id")
      )
    ),
    shinydashboard::tabItem(
      tabName = "sub_4_6",
      fluidPage(
        sub_4_6_UI("sub_4_6_id")
      )
    ),
    
    shinydashboard::tabItem(
      tabName = "sub_4_7",
      fluidPage(
        sub_4_7_UI("sub_4_7_id")
      )
    ),
    
    shinydashboard::tabItem(
      tabName = "sub_4_8",
      fluidPage(
        sub_4_8_UI("sub_4_8_id")
      )
      
    ),
    
    shinydashboard::tabItem(
      tabName = "sub_4_9",fluidPage(
        h1("PCA based on synthetic Indices"),
        tabsetPanel(
          tabPanel("Method", sub_4_9_1_UI("sub_4_9_1_id")),
          tabPanel("Group Plots", sub_4_9_2_UI("sub_4_9_2_id")),
          tabPanel("Std. Groups", sub_4_9_3_UI("sub_4_9_3_id")),
          tabPanel("Factor Groups", sub_4_9_4_UI("sub_4_9_4_id")),
          tabPanel("Synthetik Index", sub_4_9_5_UI("sub_4_9_5_id")),
          
          tabPanel("Rolling Window", sub_4_9_6_UI("sub_4_9_6_id")),
          tabPanel("Moving Average", sub_4_9_7_UI("sub_4_9_7_id")),
          tabPanel("Loading Histograms", sub_4_9_8_UI("sub_4_9_8_id")),
          tabPanel("Evolving Themes", sub_4_9_9_UI("sub_4_9_9_id")),
        )
      
    )
    ),
    
    shinydashboard::tabItem(
      tabName = "sub_4_10",fluidPage(
        h1("Siginifican Variables in Rolling Windows"),
        tabsetPanel(
          tabPanel("Explanation", sub_4_10_1_UI("sub_4_10_1_id")),
          tabPanel("PC1 Variables", sub_4_10_2_UI("sub_4_10_2_id")),
          tabPanel("PC2 Variables", sub_4_10_3_UI("sub_4_10_3_id")),
          tabPanel("PC1 P-Values", sub_4_10_4_UI("sub_4_10_4_id")),
          tabPanel("PC2 P-Values", sub_4_10_5_UI("sub_4_10_5_id"))
          )
      )
    )
  )
)


# build ui  ----------------------------------------------------------
######################################################################
######## build ui  ###################################################
###################################################################### 
ui <- shinydashboard::dashboardPage(header, sidebar, body, skin = "yellow")


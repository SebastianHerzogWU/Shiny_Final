# Global Setup   -----------------------------------------------------
######################################################################
######## Global Setup  ###############################################
######################################################################

installed <- utils::installed.packages()
packages_to_check <- c("rstudioapi", "tidyverse", "tidyquant", "shiny", "shinydashboard",
                       "shinycssloaders","pdftools", "here", "caret","shinythemes","shinyjs",
                       "magrittr","cowplot","reactlog","DT","gridExtra","reshape2")

for (package in packages_to_check) {
  if (any(package == as.vector(installed[, 1]))) {
    cat("Package ", package, " found.\n")
    library(package, character.only = TRUE)
  } else {
    install.packages(package)
    library(package, character.only = TRUE)
  }
}
file_directory <- rstudioapi::getSourceEditorContext()$path
setwd(dirname(file_directory))
rm(list = ls())

# Setting Directories ----------------------------------------------------
############################################################################
########  Setting Directories  #############################################
############################################################################

# Specify the folder containing PDF files and returning a list
minutes_folder <- here::here("WWW", "PDF", "Minutes")
minutes_files <- list.files(minutes_folder, pattern = "\\.pdf$", full.names = TRUE)

presentation_folder <- here::here("WWW", "PDF", "Presentation")
presentation_files <- list.files(presentation_folder, pattern = "\\.pdf$", full.names = TRUE)

resources_folder <- here::here("WWW", "PDF", "Resources")
resources_files <- list.files(resources_folder, pattern = "\\.pdf$", full.names = TRUE)


# Load Data files ----------------------------------------------------
######################################################################
########  Load Data files ############################################
######################################################################

load(file = "www/Data/Macro.RData")
macro_data <- df
load(file = "www/Data/Index.RData")
index_data <- df

df <- na.omit(index_data)
#df_pca_combined <- readRDS(file = "www/Data/merged_PC1_PC2.RData")
df <- as.data.frame(df)


# Additional Settings  ---------------------------------------------------
###########################################################################
########  additional Settings  ############################################
###########################################################################
# Options for Spinner
options(spinner.color="#0275D8", spinner.color.background="#ffffff", spinner.size=2)

# Option for Reactlog
#reactlog_enable()

# Additional Computation  -------------------------------------------------
###########################################################################
########  additional Computation  #########################################
###########################################################################
#### df_raw
df_raw <- as.data.frame(df) |> 
  tibble::rownames_to_column(var = "Date") |> 
  dplyr::mutate(Date = zoo::as.Date(Date))

### Global for significant PCA analysis
na.omit(df)
#Standardize
df_standardized <- as.data.frame(lapply(df, function(x) (x - mean(x)) / sd(x)))
df_standardized$Date <- as.Date(rownames(df))

#delete date column
df1 <- df_standardized[, sapply(df_standardized, is.numeric)]
highly_correlated_cols <- caret::findCorrelation(cor(df1), cutoff = 0.85) #correlation threshold

# Remove highly correlated columns
df1_no_high_correlation <- df1[, -highly_correlated_cols]
df1_no_high_correlation <- subset(df1_no_high_correlation, select = -c(HO1.Comdty))
df1_no_high_correlation$CL1.Comdty <- df1$`CL1 Comdty`
df1 <- df1_no_high_correlation
comp <- prcomp(df1)$x #FULL PCA, Extract the principal components (scores)

# Plot the first 8 principal components WICHTIG
comp <- as.data.frame(cbind(rownames(df), comp))
    

    
    
# Source Shiny Modules  ----------------------------------------------------
############################################################################
########  Source Shiny Modules  ############################################
############################################################################    

    source("utils.R")
#Source 1.x
    source("modules/sub_1_0.R")
    source("modules/plot_Ui.R")
    source("modules/sub_1_2.R")
    source("modules/sub_1_3.R")
    source("modules/sub_1_4.R")
    source("modules/sub_1_5.R")
    
#Source 3.x    
    source("modules/sub_3_1.R")
    source("modules/sub_3_2.R")
    source("modules/sub_3_3.R")
    source("modules/sub_3_4.R")
#Source 4.x 
    #Source 4.1
    source("modules/sub_4_1/sub_4_1_1.R") # PCA Basics
    source("modules/sub_4_1/sub_4_1_2.R") # Loading
    source("modules/sub_4_1/sub_4_1_3.R") # KMO
    source("modules/sub_4_1/sub_4_1_4.R") # KMO
  
    source("modules/sub_4_2.R")
    source("modules/sub_4_3.R")
    source("modules/sub_4_4.R")
    source("modules/sub_4_5.R")
    source("modules/sub_4_6.R")
    source("modules/sub_4_7.R")
    source("modules/sub_4_8.R")
    #Source 4.9
      source("modules/sub_4_9/sub_4_9_1.R")
      source("modules/sub_4_9/sub_4_9_2.R")
      source("modules/sub_4_9/sub_4_9_3.R")
      source("modules/sub_4_9/sub_4_9_4.R")
      source("modules/sub_4_9/sub_4_9_5.R")
      source("modules/sub_4_9/sub_4_9_6.R")
      source("modules/sub_4_9/sub_4_9_7.R")
      source("modules/sub_4_9/sub_4_9_8.R")
      source("modules/sub_4_9/sub_4_9_9.R")
    #Source 4.10
      source("modules/sub_4_10/sub_4_10_1.R")
      source("modules/sub_4_10/sub_4_10_2.R")
      source("modules/sub_4_10/sub_4_10_3.R")
      source("modules/sub_4_10/sub_4_10_4.R")
      source("modules/sub_4_10/sub_4_10_5.R")
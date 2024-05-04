sub_4_10_1_UI <- function(id) {
  ns <- NS(id)
  tagList(
    fluidPage(
      h3('If the method is approved in the meeting, this page serves as an initial explanation to the used methodology')
      
    )
  
  )
}

sub_4_10_1_Server <- function(id, sharedPcaData) {
  moduleServer(
    id,
    function(input, output, session) {
      
# Create general Dataframe for PC1 and PC2 Data ------------------------------------
####################################################################################
########  PC1 and PC2 Data  ########################################################
####################################################################################
      
      sharedPcaData$tbl_all_significant <- reactive({
        # Setup -------------------------------------------------------------------
        ###########################################################################
        ########   Setup     ######################################################
        ###########################################################################
        #standardize the data 
        selected_macro_data <- macro_data
        macro <- selected_macro_data[, sapply(selected_macro_data, is.numeric)]
        df_standardized2 <- as.data.frame(lapply(macro, function(x) (x - mean(x)) / sd(x)))
        df_standardized2$Date <- as.Date(rownames(macro))
        macro <- df_standardized2[, sapply(df_standardized2, is.numeric)]
        
        
        #create INDEXES -------------------------------------------------------------------
        ###########################################################################
        ########   create INDEXES     #############################################
        ###########################################################################
        macro_unc <- macro 
        
        combine_columns <- function(data, columns) {
          indexed_data <- apply(data[, columns], 1, mean)
          data <- data[, !(names(data) %in% columns)]
          return(list(indexed_data, data))
        }
        
        columns_to_combine_Asia_CPI <- c("CNCPIYOY.Index", "JNCPIYOY.Index", "HKCPIY.Index", "AUCPIYOY.Index", "EHPIASP.Index")
        result_Asia_CPI <- combine_columns(macro_unc, columns_to_combine_Asia_CPI)
        macro_unc <- result_Asia_CPI[[2]]
        macro_unc$Asia_CPI <- result_Asia_CPI[[1]]
        
        
        columns_to_combine_Europe_CPI <- c("CPEXEMUY.Index", "ITCPNICY.Index", "FRCPEECY.Index", "SPIPCYOY.Index")
        result_Europe_CPI <- combine_columns(macro_unc, columns_to_combine_Europe_CPI)
        macro_unc <- result_Europe_CPI[[2]]
        macro_unc$Europe_CPI <- result_Europe_CPI[[1]]
        
        
        columns_to_combine_Asia_UR <- c("EHUPCN.Index", "EHUPJP.Index", "EHUPHK.Index", "EHUPASAY.Index")
        result_Asia_UR <- combine_columns(macro_unc, columns_to_combine_Asia_UR)
        macro_unc <- result_Asia_UR[[2]]
        macro_unc$Asia_UR <- result_Asia_UR[[1]]
        
        
        columns_to_combine_Europe_UR <- c("EHUPEU.Index", "EHUPES.Index", "EHUPIT.Index", "EHUPGB.Index", "EHUPFR.Index")
        result_Europe_UR <- combine_columns(macro_unc, columns_to_combine_Europe_UR)
        macro_unc <- result_Europe_UR[[2]]
        macro_unc$Europe_UR <- result_Europe_UR[[1]]
        
        
        
        columns_to_combine_NorthAmerica_UR <- c("EHUPUS.Index", "EHUPMX.Index", "EHUPCA.Index")
        result_NorthAmerica_UR <- combine_columns(macro_unc, columns_to_combine_NorthAmerica_UR)
        macro_unc <- result_NorthAmerica_UR[[2]]
        macro_unc$NorthAmerica_UR <- result_NorthAmerica_UR[[1]]
        
        
        columns_to_combine_Developed_GPD <- c("EHGDDEY.Index", "EHGDUSY.Index", "EHGDEUY.Index", "EHGDFRY.Index", "EHGDESY.Index", 
                                              "EHGDITY.Index", "EHGDGBY.Index", "EHGDMXY.Index", "EHGDNOY.Index", "EHGDEEUY.Index")
        result_Developed_GPD <- combine_columns(macro_unc, columns_to_combine_Developed_GPD)
        macro_unc <- result_Developed_GPD[[2]]
        macro_unc$Developed_GPD <- result_Developed_GPD[[1]]
        
        
        columns_to_combine_Asia_GDP <- c("EHGDCNY.Index" ,"EHGDHKY.Index", "EHGDASPY.Index")
        result_Asia_GDP <- combine_columns(macro_unc, columns_to_combine_Asia_GDP)
        macro_unc <- result_Asia_GDP[[2]]
        macro_unc$Asia_GDP <- result_Asia_GDP[[1]]
        
        
        
        #delete high correlated data ----------------------------------------------
        ###########################################################################
        ######## delete high correlated data ######################################
        ###########################################################################
        
        macro <- macro_unc
        #dealing with high correlations
        correlation_threshold <- 0.75
        # Find highly correlated columns
        cor_matrix <- cor(macro)
        highly_correlated_cols <- findCorrelation(cor_matrix, cutoff = correlation_threshold)
        
        # Remove highly correlated columns
        macro <- macro[, -c(1,13,14)]
        
        cor_matrix <- cor(macro)
        highly_correlated_cols <- findCorrelation(cor_matrix, cutoff = correlation_threshold)
        macro_no_high_correlation <- macro[, -highly_correlated_cols]
        
        macro$Dates <- df_standardized2$Date
        
        
        current_observation <- 80
        target_msa <- 0.85
        
        
        
        perform_pca <- function(matrix_data) {
          pca_result <- prcomp(matrix_data, scale = TRUE)
          return(pca_result$sdev^2/sum(pca_result$sdev^2))  
        }
        n_rows <- nrow(df1)
        roll_principal_components <- lapply(1:(n_rows - current_observation + 1), function(i) {
          window_data <- df1[i:(i + current_observation - 1), , drop = FALSE]
          perform_pca(window_data)
        })
        
        PC1 <- sapply(roll_principal_components, function(x) x[1])
        PC2 <-  sapply(roll_principal_components, function(x) x[2])
        
        Dates <-rownames(df)
        Dates <-Dates[current_observation:length(Dates)]
        
        PC1 <-as.data.frame(PC1)
        rownames(PC1) <- Dates
        
        PC2 <-as.data.frame(PC2)
        rownames(PC2) <- Dates
        PC1$Dates <- row.names(PC1)
        PC2$Dates <- row.names(PC2)
        
        PC1$Dates <- as.Date(rownames(PC1))
        PC2$Dates <- as.Date(rownames(PC2))
        
        
# Final Step: merge macro and pca AND EXPORT -------------------------------
###########################################################################
######## merge macro and pca          #####################################
###########################################################################
        merged_df1 <- merge(macro, PC1, by = "Dates") # Merge for df1
        dates <- merged_df1$Dates
        rownames(merged_df1) <- merged_df1$Dates
        
        merged_df2 <- merge(macro, PC2, by = "Dates") # Merge for df2
        rownames(merged_df2) <- merged_df2$Dates
        
        merged_list <- list(merged_df1, merged_df2) # Create a list containing merged_df1 and merged_df2
        tbl_all_significant <- merged_list
        return(tbl_all_significant)
      })
      
# Return merged_df1 -------------------------------------------------------
###########################################################################
########   Return merged_df1     ##########################################
###########################################################################
      
      sharedPcaData$merged_df1 <- reactive({
        merged_list <- sharedPcaData$tbl_all_significant()
        merged_df1 <- merged_list[[1]]
        return(merged_df1)
      })
      
# Return merged_df1 -------------------------------------------------------
###########################################################################
########   Return merged_df1     ##########################################
###########################################################################
      
      sharedPcaData$merged_df2 <- reactive({
        merged_list <- sharedPcaData$tbl_all_significant()
        merged_df2 <- merged_list[[2]]
        return(merged_df2)
      })
      
      
    }
  )
}
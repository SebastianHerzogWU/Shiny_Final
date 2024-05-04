# Functions Definition ----------------------------------------------------
############################################################################
########  Functions  #######################################################
############################################################################


## function for standardizing columns based on date row name index
standardize_columns <- function(df) {
  original_row_names <- rownames(df) # Store original row names
  df_standardized <- as.data.frame(lapply(df, function(x) { # Apply the standardization function to each column
    if(is.numeric(x)) {
      (x - mean(x, na.rm = TRUE)) / sd(x, na.rm = TRUE)
    } else {
      x # Skip non-numeric columns
    }
  }))
  rownames(df_standardized) <- original_row_names # Reassign the original row names to the standardized dataframe
  return(df_standardized)
}


# Functions for sub_4_9 ---------------------------------------------------

## aligning the length of two dataframes
align_dataframes_by_date_Index <- function(df1, df2) {
  df1$Date <- as.Date(rownames(df1)) # Convert row names to a date column for merging
  df2$Date <- as.Date(rownames(df2))
  merged_data <- merge(df1, df2, by = "Date", all = FALSE) # Merge the two dataframes by their Date columns
  df1_aligned <- merged_data[, colnames(merged_data) %in% colnames(df1)] # Separate the merged data back into df1 and df2 with matching dates
  df2_aligned <- merged_data[, colnames(merged_data) %in% colnames(df2)]
  rownames(df1_aligned) <- df1_aligned$Date # Restore the Date column as row names for both dataframes
  rownames(df2_aligned) <- df2_aligned$Date
  df1_aligned <- df1_aligned[, colnames(df1_aligned) != "Date"] # Remove the Date column now that it's been set as row names
  df2_aligned <- df2_aligned[, colnames(df2_aligned) != "Date"]
  return(list(df1_aligned, df2_aligned)) # Return the aligned dataframes
}

## standardization function
standardize_columns_Index <- function(df) {
  original_row_names <- rownames(df) # Store original row names
  df_standardized <- as.data.frame(lapply(df, function(x) { # Apply the standardization function to each column
    if(is.numeric(x)) {
      (x - mean(x, na.rm = TRUE)) / sd(x, na.rm = TRUE)
    } else {
      x # Skip non-numeric columns
    }
  }))
  rownames(df_standardized) <- original_row_names # Reassign the original row names to the standardized dataframe
  return(df_standardized)
}

## Plot function
plot_time_series_Index <- function(df, value_name = "Value", title = "Time Series Data") {
  df_long <- df %>%   # Convert row names to a column and ensure Date column is of type Date
    rownames_to_column(var = "Date") %>%
    mutate(Date = as.Date(Date)) %>%
    gather(key = "Series", value = value_name, -Date) # Convert from wide to long format
  
  ggplot(df_long, aes(x = Date, y = value_name, group = Series, color = Series)) +   # Plot the data using ggplot2
    geom_line() + # Use a line plot for time series data
    xlab("Date") +
    ylab(value_name) +
    ggtitle(title) +
    scale_x_date(date_breaks = "1 year", date_labels = "%Y") + # Ensure x-axis is formatted for dates
    theme(legend.position = "right") +
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    theme_minimal()
}

## Correlation Exclusiont based on Dataframe length
remove_to_target_count_Index <- function(df, target_count, execute = TRUE) {
  if (!execute || ncol(df) <= target_count) {
    return(df)  # If not executing or the number of columns is already at or below the target, return the original dataframe
  }
  cor_matrix <- cor(df, use = "complete.obs")  # Calculate the correlation matrix, excluding NA values
  while (ncol(df) > target_count) {
    high_cor_pair <- which(abs(cor_matrix) == max(abs(cor_matrix[upper.tri(cor_matrix)])), arr.ind = TRUE)[1, ] # Find the pair with the highest absolute correlation
    col_to_remove <- which.max(apply(abs(cor_matrix[, -high_cor_pair]), 2, mean)) # Identify the column to remove (one with the highest mean correlation to other variables)
    df <- df[, -col_to_remove] # Remove the identified column from the dataframe and correlation matrix
    cor_matrix <- cor_matrix[-col_to_remove, -col_to_remove]
  }
  return(df)
}

## Correlation Exclusiont based on threshold
remove_highly_correlated_Index <- function(df, cutoff = 0.85, execute = TRUE) {
  if (!execute) {
    return(df)  # If execute is FALSE, return the original dataframe unchanged
  }
  cor_matrix <- cor(df, use = "complete.obs")  # Calculate the correlation matrix, excluding NA values
  highly_correlated_cols <- findCorrelation(cor_matrix, cutoff = cutoff)  # Find highly correlated columns
  df_no_high_correlation <- df[, -highly_correlated_cols]  # Remove highly correlated columns
  return(df_no_high_correlation)
}

## aligning the length of two dataframes
align_dataframes_by_date_Index <- function(df1, df2) {
  df1$Date <- as.Date(rownames(df1)) # Convert row names to a date column for merging
  df2$Date <- as.Date(rownames(df2))
  merged_data <- merge(df1, df2, by = "Date", all = FALSE) # Merge the two dataframes by their Date columns
  df1_aligned <- merged_data[, colnames(merged_data) %in% colnames(df1)] # Separate the merged data back into df1 and df2 with matching dates
  df2_aligned <- merged_data[, colnames(merged_data) %in% colnames(df2)]
  rownames(df1_aligned) <- df1_aligned$Date # Restore the Date column as row names for both dataframes
  rownames(df2_aligned) <- df2_aligned$Date
  df1_aligned <- df1_aligned[, colnames(df1_aligned) != "Date"] # Remove the Date column now that it's been set as row names
  df2_aligned <- df2_aligned[, colnames(df2_aligned) != "Date"]
  return(list(df1_aligned, df2_aligned)) # Return the aligned dataframes
}

## create equally weighted index
create_equally_weighted_index <- function(df, index_name_prefix = "INDEX") {
  if ("Date" %in% names(df)) { # Ensure that Date is not included in the dataframe calculations
    df <- df[, names(df) != "Date"]
  }
  index_values <- rowMeans(df, na.rm = TRUE) # Calculate the equally weighted index
  index_name <- paste(index_name_prefix, "EquallyWeighted", sep = "_") # Create a new dataframe for the index with the specified prefix
  index_df <- data.frame(Date = rownames(df), 
                         Index = index_values, 
                         row.names = NULL)
  rownames(index_df) <- index_df$Date  # Set the row names as dates
  names(index_df)[2] <- index_name # Name the index column with the specified prefix
  index_df <- index_df[, -1, drop = FALSE] # Remove the Date column as it is now the row names
  return(index_df)
}

## rolling PCA
perform_pca_Index <- function(matrix_data) {
  pca_result <- prcomp(matrix_data, scale = TRUE)
  return(pca_result$sdev^2/sum(pca_result$sdev^2))  
}

perform_pca_loading_Index <- function(matrix_data) {
  pca_result <- prcomp(matrix_data, scale = TRUE)
  loadings <- pca_result$rotation
  loadings_pc1 <- loadings[, 1]
  return(loadings_pc1)  
}

# Function to plot histogram (bar chart) for a given dataframe and timeframe
plot_histogram_for_timeframe_Index <- function(df, start_date, end_date) {
  if (start_date == "Start") { # Filter the dataframe for the given timeframe
    df_filtered <- df %>% filter(Date <= as.Date(end_date))
  } else if (end_date == "Present") {
    df_filtered <- df %>% filter(Date >= as.Date(start_date))
  } else {
    df_filtered <- df %>% filter(Date >= as.Date(start_date) & Date <= as.Date(end_date))
  }
  
  # Sum up the values for each column
  col_sums <- colSums(df_filtered[, -which(names(df_filtered) == "Date")], na.rm = TRUE)
  
  # Convert to dataframe for ggplot
  df_sums <- data.frame(variable = names(col_sums), sum = col_sums, row.names = NULL)
  # Plot bar chart
  p  <- ggplot(df_sums, aes(x = variable, y = sum, fill = variable)) +
    geom_bar(stat = "identity") +  # Use geom_bar for continuous data with stat="identity"
    labs(title = paste("Sum of Values from", start_date, "to", end_date),
         x = "Variable",
         y = "Sum of Values") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1), legend.position = "none") # Rotate x-axis labels and remove legend
  return(p)
}

export_combined_dataframes_as_RData <- function(dataframes_list, filename, dir_path, execute = TRUE) {
  if (!execute) {
    return(invisible())  # If execute is FALSE, the function does nothing and returns invisibly
  }
  
  # Combine all dataframes into a single list
  combined_data <- list()
  for (df_name in names(dataframes_list)) {
    combined_data[[df_name]] <- dataframes_list[[df_name]]
  }
  
  # Export the combined list of dataframes to a single .RData file
  file_path <- file.path(dir_path, paste0(filename, ".RData"))
  save(list = names(combined_data), file = file_path)
}

plot_lines_for_timeframe_Index <- function(df, start_date, end_date) {
  if (start_date == "Start") { # Filter the dataframe for the given timeframe
    if (end_date == "Present") {
      df_filtered <- df # unfiltered
    } else {
      df_filtered <- df %>% filter(Date <= as.Date(end_date))
    }
  } else if (end_date == "Present") {
    df_filtered <- df %>% filter(Date >= as.Date(start_date))
  } else {
    df_filtered <- df %>% filter(Date >= as.Date(start_date) & Date <= as.Date(end_date))
  }
  
  #print(df_filtered)
  df_filtered <- df_filtered |> 
    group_by(variable) |> 
    mutate(csum = cumsum(value))
  
  # Plot lines chart
  p <- ggplot(data = df_filtered, aes(x = Date, y = csum, color = variable, group = variable)) +
    geom_line(na.rm = TRUE) +  # Remove NA values resulting from the rolling average calculation
    labs(x = "Date", y = "Influence accumulated", color = "Variable") +
    scale_x_date(date_breaks = "1 year", date_labels = "%Y") +  # Display only years on x-axis
    theme_minimal() +
    theme(legend.position = "right") +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
  
    if (start_date == "Start") { # Filter the dataframe for the given timeframe
      if (end_date == "Present") {
        p <- p + geom_vline(xintercept = as.Date(c("2007-01-01","2008-12-31", "2012-12-31", "2019-12-31", "2024-04-01")), linetype = "dashed", color = "red")
      }
    }
    
  return(p)
}


#### end functions for sub_4_9
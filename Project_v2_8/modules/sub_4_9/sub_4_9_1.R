sub_4_9_1_UI <- function(id) {
  ns <- NS(id)
  tagList(
    fluidPage(
    mainPanel(
      h3("Process:"),
      HTML(
              "<ol>
          <li><strong>Package Loading:</strong> The script begins by loading a set of required R packages for data manipulation, visualization, and statistical analysis.</li>
          <li><strong>Function Definitions:</strong> A series of custom functions are defined to standardize data columns, plot time series data, exclude highly correlated variables, align dataframes by date, create equally weighted indices, perform PCA, and plot histograms for given timeframes.</li>
          <li><strong>Setup:</strong> Paths to data files are defined, and data is loaded into the R environment. The <code>index_data</code> and <code>macro_data</code> dataframes are aligned by date.</li>
          <li><strong>Grouping Indicators:</strong> Financial indicators are grouped into categories such as indices, bonds, Fama-French factors, currencies, commodities, and macroeconomic indicators.</li>
          <li><strong>Standardization:</strong> The grouped data is standardized using the <code>standardize_columns_Index</code> function.</li>
          <li><strong>Plotting (Optional):</strong> Time series plots are generated for each standardized group using the <code>plot_time_series_Index</code> function.</li>
          <li><strong>Exclusion of Highly Correlated Variables:</strong> The script removes highly correlated variables from each group based on a target number of variables or a correlation threshold.</li>
          <li><strong>Creation of Equally Weighted Indices:</strong> For each group, an equally weighted index is created using the <code>create_equally_weighted_index</code> function.</li>
          <li><strong>Plotting Combined Indices:</strong> The equally weighted indices are combined and plotted to visualize the aggregated trends.</li>
          <li><strong>Rolling Window Regression:</strong> PCA is performed on a rolling window basis to extract principal components and loadings for each window.</li>
          <li><strong>Moving Average:</strong> A rolling average is calculated for the time series data.</li>
          <li><strong>Cleanup:</strong> Unnecessary variables and functions are removed from the workspace.</li>
          <li><strong>Histogram of Influence:</strong> Histograms are plotted for different timeframes to visualize the frequency of variables having the highest values within each timeframe.</li>
        </ol>")
    )
      
      
    )
  
  )
}

sub_4_9_1_Server <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      
    }
  )
}


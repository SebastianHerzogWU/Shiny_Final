sub_4_1_4_UI <- function(id) {
  ns <- NS(id)
  tagList(
    fluidPage(
      column(
        width = 12,
        HTML("
          <div>
            <h2>Why PCA?</h2>
            <h3>Factor Analysis (FA):</h3>
            <p>Another dimensionality reduction technique similar to PCA, often used when the underlying factors influencing the data are assumed to be correlated. Like PCA, FA aims to identify latent variables that explain the correlations among observed variables.</p>
            <h3>Advantages of PCA:</h3>
            <p>In our case, we started with a variable X and wanted to explore the underlying patterns across financial time series data, PCA's orthogonality property (components are uncorrelated) are advantageous for this goal. It simplifies the interpretation of the identified components by ensuring that each captures unique variation in the data, without overlap due to correlations among factors.</p>
            <p>Additionally, PCA is computationally less complex compared to FA, which can be beneficial when dealing with large datasets or when computational resources are limited.</p>
            <h3>Cluster Analysis:</h3>
            <p>A method used to identify groups, or clusters, of similar observations within a dataset. It could be considered to identify distinct groups of financial assets or time periods based on their characteristics.</p>
            <h3>Advantages of PCA:</h3>
            <p>While Cluster Analysis is effective for identifying groups within data, it may not directly address our objective of uncovering underlying drivers or themes across time series. PCA, on the other hand, focuses on capturing patterns of variation across variables, making it more suitable for identifying common themes or factors that drive the behavior of our financial data.</p>
            <p>PCA's ability to condense information into principal components allows for a more concise representation of the underlying structure in the data, facilitating interpretation and subsequent regression analysis with macroeconomic indicators.</p>
            <h3>Multiple Regression Analysis:</h3>
            <p>Multiple Regression Analysis could be used directly on our original dataset to model the relationship between financial variables and macroeconomic indicators, without dimensionality reduction.</p>
            <h3>Advantages of PCA:</h3>
            <p>While Multiple Regression Analysis provides direct estimates of the relationships between individual variables and outcomes, it may encounter issues such as multicollinearity when dealing with highly correlated predictors, as is often the case with financial time series data.</p>
            <p>PCA addresses multicollinearity by creating orthogonal components, allowing us to capture the most significant sources of variation without the need to explicitly specify relationships between variables. This can lead to more stable regression results and enhanced interpretability, particularly when assessing how financial data load on macroeconomic indicators across different time frames.</p>
            <p>In summary, PCA was chosen as the preferred method for our analysis due to its ability to handle high-dimensional datasets, identify underlying drivers or themes across financial time series, mitigate multicollinearity issues in regression analysis, and facilitate interpretation of relationships across different time frames. Compared to alternative methods like Factor Analysis, Cluster Analysis, or Multiple Regression Analysis, PCA offered a more suitable approach tailored to our specific objectives and dataset characteristics.</p>
          </div>
        ")
      )
    )
  )
}


sub_4_1_4_Server <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      # Server logic for PCA pros and cons module can go here
    }
  )
}
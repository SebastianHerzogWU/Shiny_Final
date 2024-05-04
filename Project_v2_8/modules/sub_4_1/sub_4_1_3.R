sub_4_1_3_UI <- function(id) {
  ns <- NS(id)
  tagList(
    fluidPage(
      column(
        width = 12,
        h3("Kaiser-Meyer-Olkin (KMO) Test and Measure of Sampling Adequacy (MSA)"),
        HTML("<p>The Kaiser-Meyer-Olkin (KMO) Test is a measure of how suited your data is for Factor Analysis. The test measures sampling adequacy for each variable in the model and for the complete model. The statistic is a measure of the proportion of variance among variables that might be common variance. The lower the proportion, the more suited your data is to Factor Analysis.</p>"),
        img(src = "images/kmo_formula.svg", style = "width:20%;"), # Default link for the picture
        HTML("<p>where:</p>"),
        HTML("<ul style='list-style-type: none;'>
          <li>r = [r<sub>ik</sub>] is the correlation matrix,</li>
          <li>p = [p<sub>ik</sub>] is the partial covariance matrix.</li>
        </ul>"),
        HTML("<p>KMO returns values between 0 and 1. A rule of thumb for interpreting the statistic:</p>"),
        HTML("<ul style='list-style-type: none;'>
          <li><b>KMO values between 0.8 and 1 </b> indicate the sampling is adequate.</li>
          <li><b>KMO values less than 0.6 </b> indicate the sampling is not adequate and that remedial action should be taken. Some authors put this value at 0.5, so use your own judgment for values between 0.5 and 0.6.</b></li>
          <li><b>KMO Values close to zero </b> means that there are large partial correlations compared to the sum of correlations. In other words, there are widespread correlations which are a large problem for factor analysis.</b></li>
        </ul>"),
        HTML("<p>In his delightfully flamboyant style, Kaiser (1975) suggested that:0.70 to 0.79 middling; 0.80 to 0.89 meritorious; 0.90 to 1.00 marvelous.</p>"),
        HTML("<p>Find more information about the KMO-Method <a href='https://www.statisticshowto.com/kaiser-meyer-olkin/'><b>here</b></a></p>"),
        HTML("<p>Find more information about the KMO package <a href='https://personality-project.org/r/html/KMO.html'><b>here</b></a></p>"),
        HTML("<br>"),
        HTML("<p>The Measure of Sampling Adequacy (MSA) is another metric used to assess the suitability of data for Factor Analysis. It evaluates the adequacy of the correlation matrix for factor analysis.</p>"),
        HTML("<p>MSA values range from 0 to 1, with higher values indicating better suitability for factor analysis.</p>"),
        HTML("<p>The formula for MSA is:</p>"),
        img(src = "images/msa_formula.svg", style = "width:20%;"),
        HTML("<p>A common guideline for interpreting MSA values:</p>"),
        HTML("<ul style='list-style-type: none;'>
          <li><b>MSA values above 0.5 </b> are generally considered adequate for factor analysis.</li>
          <li><b>MSA values close to 1 </b> indicate a high degree of adequacy.</li>
          <li><b>MSA values below 0.5 </b> may indicate that the variables are not well-suited for factor analysis and may require reconsideration.</li>
        </ul>"),
        HTML("<p>Learn more about MSA <a href='https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4379368/'><b>here</b></a>.</p>"),

        HTML("<p>It is often acceptable to use the Measure of Sampling Adequacy (MSA) test as an alternative to the Kaiser-Meyer-Olkin (KMO) test for assessing the suitability of data for Factor Analysis. Scientifically, both tests aim to evaluate the adequacy of the correlation matrix for factor analysis.</p>"),
        HTML("<p>There are several reasons why the results obtained from the MSA test are not significantly different from those obtained from the KMO test:</p>"),
        HTML("<ul style='list-style-type: none;'>"),
        HTML("  <li><b>Similar underlying principles:</b> Both tests are based on similar underlying principles of assessing the suitability of data for factor analysis by examining the correlation structure of variables.</li>"),
        HTML("  <li><b>Correlation focus:</b> Both tests primarily focus on the correlations between variables, which are essential for factor analysis. Therefore, they often produce comparable results.</li>"),
        HTML("  <li><b>Multiple factors considered:</b> Both tests take into account multiple factors such as intercorrelations among variables and partial correlations, contributing to the overall assessment of sampling adequacy.</li>"),
        HTML("  <li><b>Robustness:</b> MSA is known to be robust even with non-normal data, making it a suitable alternative to KMO in various data scenarios.</li>"),
        HTML("  <li><b>Consistency:</b> Studies have shown that the results obtained from MSA are consistent with those from KMO, indicating a high level of agreement between the two tests.</li>"),
        HTML("<p>Therefore, if for any reason the KMO test cannot be conducted or if MSA is preferred due to its robustness or computational advantages, it is generally acceptable to use the MSA test as a reliable alternative.</p>"),
                
      )
    )
  )
}

sub_4_1_3_Server <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      
    }
  )
}




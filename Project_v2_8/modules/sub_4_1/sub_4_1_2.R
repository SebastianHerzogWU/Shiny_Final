sub_4_1_2_UI <- function(id) {
  ns <- NS(id)
  tagList(
    fluidPage(
      column(
        width = 12,
        h3("Factor Loadings"),
        HTML("<p>It is important to realize that principal components are less interpretable and don’t have any real meaning since they are constructed as linear combinations of the initial variables. But we can analyze the loadings which describe the importance of the independent variables.</p>"),
        HTML("<p>The first principal component (Y1) is given by a linear combination of the variables X1, X2, …, Xp, and is calculated such that it accounts for the greatest possible variance in the data.</p>"),
        img(src = "images/PCAequation1.png", style = "width:20%;"), # Default link for the picture
        HTML("<p>Of course, one could make the variance of Y1 as large as possible by choosing large values for the weights a11, a12, … a1p. To prevent this, the sum of squares of the weights is constrained to be 1.</p>"),
        img(src = "images/PCAequation3.png", style = "width:20%;"), # Default link for the picture
        HTML("<p>For example, let’s assume that the scatter plot of our data set is as shown below. Can we guess the first principal component? Yes, it’s approximately the line that matches the purple marks because it goes through the origin and it’s the line in which the projection of the points (red dots) is the most spread out. Or mathematically speaking, it’s the line that maximizes the variance which is the average of the squared distances from the projected points (red dots) to the origin.</p>"),
        img(src = "images/PCA_rotation.gif", style = "width:60%;"),
        HTML("<p>The second principal component is calculated in the same way, with the conditions that it is uncorrelated with (i.e., perpendicular to) the first principal component and that it accounts for the next highest variance.</p>"),
        HTML("<p>This continues until a total of p principal components have been calculated, that is, the number of principal components is the same as the original number of variables. At this point, the total variance on all of the principal components will equal the total variance among all of the variables. In this way, all of the information contained in the original data is preserved; no information is lost: PCA is just a rotation of the data.</p>"),
        HTML("<p>The elements of an eigenvector, that is, the values within a particular row of matrix, are the weights aij. These values are called the loadings, and they describe how much each variable contributes to a particular principal component.</p>"),
        HTML("<p>Large loadings (+ or -) indicate that a particular variable has a strong relationship to a particular principal component.</p>"),
        HTML("<p>The sign of a loading indicates whether a variable and a principal component are positively or negatively correlated.</p>")
      )
    )
  )
}

sub_4_1_2_Server <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      
    }
  )
}

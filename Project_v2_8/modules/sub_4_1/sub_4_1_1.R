sub_4_1_1_UI <- function(id) {
  ns <- NS(id)
  tagList(
    fluidPage(
      column(
        width = 12,
        h3("Principal Component Analysis"),
        HTML("
          <p><strong>Unsupervised Learning</strong> is a type of machine learning where algorithms infer patterns from a dataset without reference to known or labeled outcomes. Unlike supervised learning, where models are trained on labeled data, unsupervised learning works with unlabeled data, and its goal is to model the underlying structure or distribution in the data to learn more about it.</p>
          <p>Within the realm of unsupervised learning, PCA is a powerful technique for <strong>dimensionality reduction</strong>. It simplifies the complexity in high-dimensional data while retaining trends and patterns. PCA does not require the data to be labeled as the technique is purely based on the feature set's variance. It is considered unsupervised because the principal components are derived from the data without any associated external outcomes or predictions.</p>
          <p>PCA can be used in unsupervised learning to:</p>
          <ul>
            <li>Discover the internal structure of the data.</li>
            <li>Visualize the organization and grouping of complex data.</li>
            <li>Reduce the number of variables to make analysis computationally less expensive and more interpretable.</li>
          </ul>
          <p>The distinction between unsupervised and supervised learning is significant:</p>
          <ul>
            <li><strong>Supervised learning</strong> algorithms are trained on labeled data, meaning each training example is paired with an output label. The model learns to predict the output from the input data.</li>
            <li><strong>Unsupervised learning</strong> algorithms are trained on data without labels, and the system tries to learn the patterns and the structure from the input data alone.</li>
          </ul>
          <p>Now, let's consider an easy-to-understand example of PCA. Imagine we have a dataset of various cars, including attributes like weight, horsepower, and fuel efficiency. These attributes are related; heavier cars tend to have more horsepower and less fuel efficiency. By applying PCA, we can reduce these three dimensions into principal components that summarize the essential patterns in the data. For example, the first principal component might measure overall 'car performance,' combining weight and horsepower, while the second might capture 'efficiency' aspects that contrast fuel efficiency with the other two attributes.</p>
          <p>Principal Component Analysis (PCA) is a statistical procedure that utilizes an orthogonal transformation to convert a set of observations of possibly correlated variables into a set of values of linearly uncorrelated variables called principal components.</p>
          <p><strong>Eigenvalues</strong> (<i>λ</i>) are coefficients attached to eigenvectors that give the amount of variance carried in each Principal Component. An eigenvalue tells us how much variance in the overall data is explained by its associated eigenvector.</p>
          <p><strong>Eigenvectors</strong> are unit vectors with a length of one, which are oriented at right angles to each other. They point in the direction of the largest spread of data and are the directions along which the data is most variable.</p>
          <p><strong>Eigenvalue Decomposition</strong> is a process that decomposes a matrix into its constituent parts to find out the principal components. It involves solving for the eigenvectors and eigenvalues of a matrix, which is essentially finding the principal axes of variance in the data. Mathematically, it solves the following equation:</p>
          <p><i>Cov(X) * v = λ * v</i></p>
          <p>Where <i>Cov(X)</i> is the covariance matrix of the data <i>X</i>, <i>v</i> is an eigenvector, and <i>λ</i> is the corresponding eigenvalue.</p>
          <p>The <strong>loadings</strong> are calculated by multiplying each eigenvector by the square root of its corresponding eigenvalue, which helps in understanding how much each variable contributes to each principal component.</p>
          <p><i>Loading = Eigenvector * √Eigenvalue</i></p>
          <p><strong>Understanding PCA Visually in 2-Dimensions:</strong></p>
          <p>When applied to a 2-dimensional dataset, PCA seeks to identify the direction in which the data varies the most. This direction becomes the first principal component (PC1). The second principal component (PC2) is orthogonal to the first, meaning it captures the variance in the data that is not captured by PC1.</p>
          <p>Imagine a scatter plot of a 2-dimensional dataset where the x and y axes represent two different variables. PCA looks for a new 'axis' that best aligns with the spread of the data. This new axis is PC1, and it is positioned in such a way that when we project our data points onto it, the spread (or variance) along it is maximized.</p>
          <p>Once PC1 is established, PCA finds another axis, PC2, which is orthogonal to PC1. In 2D, this simply means that PC2 is at a right angle to PC1. The orthogonality ensures that the variance measured by PC2 is not related to the variance already captured by PC1.</p>
          <p>Visually, the length of the projection of the data points onto PC1 and PC2 indicates how much variance each principal component captures. The longer the projection, the more variance is captured. If we were to draw these principal components on the original scatter plot, they would appear as lines that provide a new reference frame for our data.</p>
          <p><strong>Orthogonality of PC1 and PC2:</strong></p>
          <p>Orthogonality is a key concept in PCA, especially when it comes to understanding the relationship between different principal components. In the context of PCA, orthogonality ensures that the principal components are statistically independent or uncorrelated with each other. This means that the information captured by PC1 is completely different from the information captured by PC2.</p>
          <p>Mathematically, two vectors are orthogonal if their dot product is zero. In PCA, this translates to the covariance between any two principal components being zero. This property is crucial because it allows us to reduce the dimensionality of the data without losing important, independent variance signals in the process.</p>
          <p>The orthogonality of PC1 and PC2 in a 2-dimensional space can be visualized as a pair of perpendicular lines that intersect at the origin of the scatter plot, each line representing a principal component. These orthogonal lines form the axes of a new coordinate system that best describes the variance in the original data.</p>
          <p>These loadings can be used to interpret the principal components in terms of the original variables.</p>
          <p>PCA is commonly used for exploratory data analysis, data visualization, and feature extraction. It helps in identifying patterns and relationships in high-dimensional data, making it easier to interpret and analyze.</p>
          <p>In the context of Shiny applications, PCA can be used for interactive data exploration and visualization. It allows users to interactively select variables, explore the variance explained by each principal component, and visualize the data in a lower-dimensional space.</p>
        "),
        column(
          width = 12,
          img(src = "images/Eigenvectors_joke.png", width = "25%"),
          tags$figcaption("Eigenvectors")
        )
      )
    )
  )
}



sub_4_1_1_Server <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      
    }
  )
}

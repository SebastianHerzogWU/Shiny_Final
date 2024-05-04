sub_3_1_UI <- function(id) {
  ns <- NS(id)
  tagList(
    h1("Data Sources"),
    div(
      style = "width: 100%; border-top: 1px solid black;",
      HTML('<img src="images/Bloomberg.png" style="width:20%;">'),
      tags$figcaption(em("Bloomberg")),
      HTML('<p>Bloomberg is a global financial information and news provider. It offers real-time and historical data on various financial instruments, market trends, and economic indicators.</p>'),
      HTML('<p>To access Bloomberg data, you typically need a subscription or access through a financial institution that has a Bloomberg terminal. Additionally, Bloomberg provides API access for programmatic data retrieval.</p>'),
      HTML('<p>Bloomberg provides data on stocks, bonds, commodities, currencies, and economic indicators.</p>')
    ),
    div(
      style = "width: 100%; border-top: 1px solid black;",
      HTML('<img src="images/Reuters.png" style="width:20%;">'),
      tags$figcaption(em("Reuters")),
      HTML('<p>Reuters is a multinational news and information provider focusing on financial markets, business, and politics. It offers real-time news, analysis, and market data.</p>'),
      HTML('<p>Reuters provides various data feeds and APIs for accessing its news and market data. Users can subscribe to different data packages depending on their needs.</p>'),
      HTML('<p>Reuters offers data on stocks, bonds, commodities, currencies, and economic news.</p>')
    ),
    div(
      style = "width: 100%; border-top: 1px solid black;",
      HTML('<img src="images/LSEG.png" style="width:20%;">'),
      tags$figcaption(em("LSEG (London Stock Exchange Group)")),
      HTML('<p>LSEG is a global financial markets infrastructure business. It operates stock exchanges, derivatives markets, and provides data services to financial institutions worldwide.</p>'),
      HTML('<p>LSEG offers various data products including real-time and historical market data, indices, and analytics. Access to LSEG data is typically through subscription services or institutional access.</p>'),
      HTML('<p>LSEG provides data on stocks, bonds, derivatives, indices, and market analytics.</p>')
    ),
    div(
      style = "width: 100%; border-top: 1px solid black;",
      HTML('<img src="images/FRED.png" style="width:20%;">'),
      tags$figcaption(em("St. Louis Fed FRED")),
      HTML('<p>The Federal Reserve Economic Data (FRED) is provided by the Federal Reserve Bank of St. Louis. It offers a vast collection of economic data, including economic indicators, interest rates, and demographic data.</p>'),
      HTML('<p>FRED provides free access to its data through its website and also offers API access for programmatic data retrieval. Users can download data in various formats for analysis and research purposes.</p>'),
      HTML('<p>FRED offers economic indicators, interest rates, employment data, and demographic data.</p>')
    ),
    div(
      style = "width: 100%; border-top: 1px solid black;",
      HTML('<img src="images/SP_Global.png" style="width:20%;">'),
      tags$figcaption(em("Standard and Poors Global")),
      HTML('<p>S&P (Standard and Poor’s) is a leading provider of financial market intelligence. It offers data on stock market indices, credit ratings, and market research.</p>'),
      HTML('<p>Access to S&P data is available through subscription services, financial institutions, and data vendors.</p>'),
      HTML('<p>S&P provides data on stock market indices, credit ratings, and market research.</p>')
    )
  )
}

sub_3_1_Server <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      
    }
  )
}

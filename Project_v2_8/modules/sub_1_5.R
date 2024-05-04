sub_1_5_UI <- function(id) {
  ns <- NS(id)
  tagList(
    fluidPage(
      tags$div(
        HTML('<img src="images/R_Tools.png" style="width:100%;">')
      ),
      titlePanel("APP FAQ"),
      # Enhanced description of Shiny
      HTML("<h4>Q: What is Shiny?</h4>
           <p>A: Shiny is an R package that enables the creation of interactive web applications directly from R. It provides an extensive range of tools to build user interfaces, server-side calculations, and reactive elements that update in response to user input without requiring a background in web development.</p>"),
      # Enhanced description of Imperative vs. Reactive Programming
      HTML("<h4>Q: What is Imperative vs. Reactive Programming?</h4>
           <p>A: Imperative programming is a paradigm where developers write code that describes the step-by-step logic to achieve a result. In contrast, reactive programming in Shiny involves defining reactive sources (like user inputs) and reactive endpoints (like outputs), with the framework automatically managing the dependencies and updating outputs when inputs change. This leads to more streamlined and responsive applications.</p>"),
      # Enhanced description of reactlog
      HTML("<h4>Q: What is Reactlog?</h4>
           <p>A: Reactlog is an invaluable debugging tool for Shiny developers. It visualizes how reactive elements in your application are interconnected and how data flows through these elements. By using reactlog, developers can optimize performance by identifying bottlenecks or unnecessary reactive dependencies and gain a deeper understanding of the reactive execution context within their applications.</p>"),
      # Enhanced code structure organization
      HTML("<h4>Q: How is the code structure organised?</h4>
           <p>A: The code structure in this Shiny application is meticulously organized to promote modularity and reusability. Functions and Shiny modules are the backbone of this organization, with functions handling repetitive tasks and modules encapsulating UI and server logic. This separation of concerns not only makes the code more maintainable but also enables collaboration as different parts of the application can be developed in parallel.</p>"),
      # Additional FAQ points
      HTML("<h4>Q: How can you integrate Shiny with databases?</h4>
           <p>A: Shiny's integration with databases is facilitated through R packages that provide a comprehensive set of tools for database operations. The `DBI` package serves as the foundation, offering a consistent interface to communicate with relational databases. The `pool` package manages a pool of database connections that can be reused, enhancing performance. The `dplyr` package can be used to interact with databases using its data manipulation verbs, which are automatically translated to SQL queries behind the scenes.</p>"),
      HTML("<h4>Q: How do you set up and manage a SQLite database for use in a Shiny application?</h4>
     <p>A: SQLite is a widely-used database engine that is an ideal choice for small to medium-sized applications, including Shiny apps. It is self-contained, serverless, and zero-configuration, meaning it doesn't require a separate server process or setup. In R, the RSQLite package provides an interface to SQLite, allowing you to create databases and manage data with SQL commands directly from R. The dbplyr package enables you to work with database tables as if they were in-memory data frames by translating dplyr code into SQL on the fly.</p>
     <p>Setting up a SQLite database is straightforward. First, you establish a connection to the database file using the <code>dbConnect()</code> function from RSQLite. With this connection, you can begin creating tables and loading data using the <code>dbWriteTable()</code> function. This function takes your data frame and writes it to the specified SQLite database as a new table, allowing you to store and manage large datasets efficiently.</p>
     <p>Once your data is in the database, you can interact with it using dplyr verbs through a remote table connection established with the <code>tbl()</code> function. Operations on this remote table are lazy, meaning they don't pull data into memory until you explicitly collect it with the <code>collect()</code> function. This approach is efficient for working with large datasets, as it minimizes memory usage and leverages the database's processing power.</p>
     <p>For database maintenance, you might need to optimize the database file size over time, especially after deleting data. This is where the <code>VACUUM</code> SQL command comes in handy, as it rebuilds the database file, reclaiming unused space. You can run this command in R using the <code>dbSendQuery()</code> function.</p>
     <p>Finally, you can list all tables in the database using the <code>dbListTables()</code> function, which helps you verify the structure of your database and the names of the tables it contains. The SQLite database file is portable and can be shared across different devices and programming languages, making it a versatile option for data storage in Shiny applications.</p>
     <p>For more detailed guidance on setting up and managing a SQLite database, including examples and best practices, refer to the 'tidy-finance' book <a href='https://www.tidy-finance.org/r/accessing-and-managing-financial-data.html#setting-up-a-database' target='_blank'>here</a>.</p>")
    )
  )
}

sub_1_5_Server <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      # Server logic for the module, if any
    }
  )
}

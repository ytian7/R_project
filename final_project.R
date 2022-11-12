#install.packages("shinydashboard")

## ui.R ##
library(shinydashboard)
library(shiny)

ui <- dashboardPage(
  dashboardHeader(title = "Cancer analysis"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Input data", tabName = "inputdata"),
      menuItem("Numerical Variable", tabName = "numerical_variable"),
      menuItem("Category Variable", tabName = "category_variable"),
      menuItem("Kaplan", tabName = "kaplan"),
      menuItem("Comparation", tabName = "comparation"),
      menuItem("Summary", tabName = "Summary")
    )
  ),
  dashboardBody(
    tabItems(
      # Second tab content
      tabItem(tabName = "inputdata",
              fluidPage(
                sidebarLayout(
                  sidebarPanel(
                    fileInput("file1", "Choose CSV File", accept = ".csv"),
                    checkboxInput("header", "Header", TRUE)
                  ),
                  mainPanel(
                    tableOutput("contents")
                  )
                )
              )
      )
    )
  )
)

server <- function(input, output) { 
  output$contents <- renderTable({
    file <- input$file1
    ext <- tools::file_ext(file$datapath)
    
    req(file)
    validate(need(ext == "csv", "Please upload a csv file"))
    
    read.csv(file$datapath, header = input$header)
  })
  }

shinyApp(ui, server)


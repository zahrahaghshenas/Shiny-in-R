# Load the shiny package
library(shiny)

# Define the user interface
ui <- fluidPage(theme = shinytheme("united"),
                navbarPage(
  # Title of the app
  title = "BMI Calculator",
  
  # Tab for the BMI calculator
  tabPanel(
    title = "Home",
    
    # Sidebar layout with input and output definitions
    sidebarLayout(
      # Sidebar panel for inputs
      sidebarPanel(
        # Input: Enter the weight in kilograms
        numericInput("weight", "Weight (kg):", value = 70, min = 0, max = 300, step = 0.1),
        
        # Input: Enter the height in meters
        numericInput("height", "Height (m):", value = 1.75, min = 0, max = 3, step = 0.01)
      ),
      
      # Main panel for outputs
      mainPanel(
        # Output: Display the BMI value
        textOutput("bmi"),
        
        # Output: Display the BMI category
        textOutput("category")
      )
    )
  ),
  
  # Tab for the BMI result table
  tabPanel(
    title = "BMI Result Table",
    
    # Main panel for output
    mainPanel(
      # Output: Display the BMI table
      tableOutput("table")
    )
  ),
  
  # Tab for the about information
  tabPanel(
    title = "About",
    
    # Main panel for output
    mainPanel(
      # Output: Display the about text
      textOutput("about")
    )
  )
)
)

# Define the server logic
server <- function(input, output) {

  # Render the BMI value
  output$bmi <- renderText({
    bmi <-input$weight / input$height^2
    paste("Your BMI is", round(bmi, 2))
  })
  
  # Render the BMI category
  output$category <- renderText({
    bmi <-input$weight / input$height^2
    
    if (bmi < 18.5) {
      "You are underweight"
    } else if (bmi < 25) {
      "You are normal weight"
    } else if (bmi < 30) {
      "You are overweight"
    } else {
      "You are obese"
    }
  })
  
  # Render the BMI table
  output$table <- renderTable({
    data.frame(
      Weight_Statu = c("Underweight", "Normal weight", "Overweight", "Obese"),
      BMI = c("< 18.5", "18.5 - 24.9", "25 - 29.9", ">= 30")
    )
  })
  
  # Render the about text
  output$about <- renderText({
    "This is a simple BMI calculator software written in R for Shiny. It allows you to enter your weight and height and calculates your BMI and displays your BMI category. It also shows you a table of BMI results and their corresponding categories. This software is for educational purposes only and does not provide medical advice."
  })
}

# Run the shiny app
shinyApp(ui = ui, server = server)

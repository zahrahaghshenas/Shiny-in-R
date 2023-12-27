# Load the shiny and ggplot2 packages
library(shiny)
library(ggplot2)

# Define the user interface
ui <- fluidPage(
  # Title of the app
  #titlePanel("Scatter plot and histogram for mtcars dataset"),
  wellPanel(style = "background-color: purple", 
            h2("Scatter plot and histogram for mtcars dataset", align = "center")),
  
  fluidRow(
    column(2,
           # Input: Select two variables from the mtcars dataset
           fluidRow(
             column(6,radioButtons("var1", "Select the first variable:", choices = names(mtcars))),
             column(6,radioButtons("var2", "Select the second variable:", choices = names(mtcars))),
             
             # Input: Select a categorical variable for grouping the dot plot
             radioButtons("group", "Select a grouping variable:", 
                          choices = c("None", "Cylinders", "Transmission", "Gears"))
           )
    )
    ,
    
    # Main panel for outputs
    mainPanel(
      # Output: Scatter plot for the two variables
      column(6,plotOutput("scatterplot")),
      
      # Output: Histogram for the first variable
      
      column(6,plotOutput("histogram"))
    )
    
  )
)


# Define the server logic
# Server logic
server <- function(input, output) {
  output$scatterplot <- renderPlot({
    
    x <- mtcars[[input$var1]]
    y <- mtcars[[input$var2]]
    
    p <- ggplot(mtcars, aes_string(x=input$var1, y=input$var2)) +
      geom_point(alpha = 0.5)
    
    if(input$group == "Cylinders") {
      p <- p + aes(color = factor(mtcars$cyl)) 
    } else if(input$group == "Transmission") {
      p <- p + aes(color = mtcars$am)
    } else if(input$group == "Gears") { 
      p <- p + aes(color = factor(mtcars$gear))
    }
    
    print(p+ggtitle(paste("scatterplot of ",input$var1,"vs",input$var2)))
    
  })
  
  
  
  
  
  
  
  output$histogram <- renderPlot({
    
    x <- mtcars[[input$var1]]
    
    hist(x, 
         main = paste("Histogram of", unique(input$var1)),
         xlab = input$var1,
         col = "Purple")
    
  })
  
  
}


# Complete app
shinyApp(ui, server)
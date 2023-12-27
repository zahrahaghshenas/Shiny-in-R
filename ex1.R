library(shiny)

ui <- fluidPage(
  
  titlePanel("Simple Plot"),
  
  fluidRow(
    column(2, 
           sliderInput("rng", "Select data range", min = -20, max = 20, 
                       value = c(-7,7), step = 1)),
    
    column(2,
           fluidRow(
             column(6, selectInput("color", "Select Points Color",
                                   selected = "green",
                                   choices = c("black", "red", "blue", "green"))),
             
             column(6, selectInput("color2", "Select Line Color",
                                   selected = "pink",
                                   choices = c("black", "red", "blue", "green", "pink")))
           ),
           
           fluidRow(
             column(6, radioButtons("point_size", 
                                    "Choose points size:",
                                    choices = c("1", "3", "5", "7", "9"))),
             
             column(6, radioButtons("line_size", 
                                    "Choose line size:",
                                    choices = c("1", "1.5", "2", "2.5", "3", "3.5", "4", "4.5", "5")))
           )
    ),
    
    column(8, 
           plotOutput("plot", width = "400px"))
  )
)

server <- function(input, output, session) {
  
  output$plot <- renderPlot({
    
    x <- seq(input$rng[1], input$rng[2])
    y <- x^2
    
    plot(x, y, col = input$color, pch = 19,lwd = input$point_size) 
    lines(x,y, col = input$color2,lwd = input$line_size)
    
  },res = 96)
  
}

shinyApp(ui, server)
options(rgl.useNULL=TRUE)
require(shiny)
require(rgl)
require(shinyRGL)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Linear regression with two explanatory variables"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      h1("Create the data set"),
      sliderInput("n",
                  "Number of observations \\(n\\):",
                  min = 3,
                  max = 500,
                  value = 50),
      sliderInput("a0",
                  "Coefficient \\( \\alpha_0 \\):",
                  min = 0,
                  max = 10,
                  value = 5),
      sliderInput("a1",
                  "Coefficient \\( \\alpha_1 \\):",
                  min = 0,
                  max = 10,
                  value = 5),
      sliderInput("a2",
                  "Coefficient \\( \\alpha_2 \\):",
                  min = 0,
                  max = 10,
                  value = 5),
      sliderInput("sigma",
                  "Coefficient \\(  \\sigma \\):",
                  min = 0,
                  max = 10,
                  value = 5)      
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h1("Data generation model"),
      withMathJax(p("$$ Y = \\alpha_0 + \\alpha_1 X_1 + \\alpha_2X_2 + \\sigma \\mathcal{N}(0,1)$$")),
      h1("Summary of the regression coefficients"),
      tableOutput("summary"),
      h1("3DPlot of data and regression plan"),
      webGLOutput("plot")
    )
  )
))

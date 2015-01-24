options(rgl.useNULL=TRUE)
require(shiny)
require(rgl)
require(shinyRGL)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # Data generation
  X  <- reactive({
    X <- matrix(data = c(runif(n = 2* input$n)),
                ncol = 2)
    return(X)
  })
  Y  <- reactive({
    input$a0 + X() %*% c(input$a1,input$a2) + input$sigma * rnorm(n = input$n)
  })
  
  info <- reactive({
    info  <- data.frame(as.data.frame(X()),
                       data.frame(Y()))
    names(info)  <- c("x1","x2","y")
    return(info)
  })
  # Linear regression
  fit <- reactive({
    lm(formula = y~.,data = info())
  })
  output$summary <- renderTable(expr = {
    summary(fit())$coefficients
  },digits = 5)
  
  # Plot the generated data and the regression plan
  output$plot <- renderWebGL(expr = {
    plot3d(info()$x1,info()$x2,info()$y, type="p", col="red", xlab="X1", ylab="X2", zlab="Y", site=5, lwd=15)
    my_surface(f, coeff = fit()$coefficients,alpha=.2 )
  })
})

my_surface <- function(f, n=10, coeff,...) { 
  ranges <- rgl:::.getRanges()
  x <- seq(ranges$xlim[1], ranges$xlim[2], length=n)
  y <- seq(ranges$ylim[1], ranges$ylim[2], length=n)
  z <- outer(x,y,f,coeff)
  surface3d(x, y, z, ...)
}

f <- function(x1, x2, coeff){
  coeff["(Intercept)"] + coeff["x1"]* x1 + coeff["x2"]* x2
}
shinyUI(pageWithSidebar(
    
    headerPanel("Specify car parameters"),
    sidebarPanel(
        helpText("Enter parameters for the car you're looking for. ",
                 "On the right side the diagram is with the data of car mileage is shown.",
                 "When you enter appropriate values, ",
                 "the graph shows mileage as a blue triangle and actual predicted value below."),
        h3('Parameters for the car'),
        numericInput('disp', 'Engine displacement in 10s of cu.in.', 100, 
                     min = 70, max = 500, step = 10),
        checkboxInput("isManual", "Is it a manual gearbox", FALSE),
        sliderInput("numCyl", "Number of cylinders:",
                    min = 4, max = 8, value=4, step=2)
    ),
    mainPanel(
        h3('Car fuel consumption prediction'),
        plotOutput("mpgPlot"),
        splitLayout(
        span('Predicted fuel consumption (mpg):'),
        textOutput("Predicted")),
        splitLayout(
            span('uses:'),
            code("lm(mpg~am+disp+cyl, data=mpgData)"))
    )
    
))
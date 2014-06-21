library(datasets)
library(shiny)
library(ggplot2)

mpgData <- mtcars
mpgData$am <- factor(mpgData$am, labels = c("Automatic", "Manual"))

fit<-lm(mpg~am+disp+cyl, data=mpgData)

# Define server logic required to plot various variables against mpg
shinyServer(function(input, output) {
    
    
    prediction<-reactive({
        df<-data.frame(
                am = factor(ifelse(input$isManual,"Manual","Automatic")),
                disp = input$disp,
                cyl= input$numCyl
            )
        predict(fit, df)
    })
    
    data<-reactive({
        data.frame(xval=input$disp,yval=prediction())})
    
    output$mpgPlot <- renderPlot({
        gp <- ggplot(data=mpgData, 
                     aes(x=disp, y=mpg, 
                         colour=am), 
                     main="Fuel consumption by engine size",
                     xlab = "Displacement", ylab="Miles per gallon")
        gp<-gp + geom_point(aes(x=xval, y=yval),data=data(), color="blue",
                            size=5, shape=2)+
            geom_point() + stat_smooth(method="lm")
        print(gp)
        
    })
    output$Predicted<-renderText({round(prediction(),2)})
})
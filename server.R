library(shiny)
library(shinyjs)
library(ggplot2)

shinyServer(function(input, output) {

# m/z calculator #
    
vals <- reactiveValues()
observe({
    vals$mz2 <- input$mz1
    vals$z2 <- input$z1
    vals$adduct2 <- input$adduct
})
output$mass1 <- renderText({
    (vals$mz2*vals$z2)-vals$z2*vals$adduct2
    })

# random problems #

number <- sample(500:3000, 1)
number2 <- sample(1:3, 1)

new_question <- observeEvent(input$update_question,{
    number <- sample(500:3000, 1)
    number2 <- sample(1:3, 1)
    output$number1 <- renderText({
        print(number)
    })
    
    output$number3 <- renderText({
        print(number2)
    })

observe({
    vals$answer <- input$answer
})

expected <- round((number+number2)/number2, digits=2)

output$expected <- renderText({
    round((number+number2)/number2, digits=2)
})

output$check_answer <- eventReactive(input$submit_answer, {
    isolate({
    if(input$answer == expected){
        answers <- "Correct"
    }
    else{
        answers <- "Please Try Again!"
    }
    })
    answers
})

})

# isotope #

new_plot <- observeEvent(input$update_plot,{
isopos <- c(0.2, 0.25, 0.33, 0.5, 1)
firstiso <- sample(isopos, 1)
secondiso <- firstiso*2
thirdiso <- firstiso*3
massiso <- sample(500:2000, 1)

firstmass <- firstiso + massiso
secondmass <- secondiso + massiso
thirdmass <- thirdiso + massiso

range <- c(100,50,12.5)
isotopes <- c(firstmass, secondmass, thirdmass)
namesmass <- c(firstmass, secondmass, thirdmass)

graph2 <- data.frame(namesmass, isotopes, range)

output$plot2 <- renderPlot({
    ggplot(data=graph2, aes(x=range, y=isotopes))+
        geom_segment(aes(x=isotopes, xend=isotopes, y=0, yend=range), color= "black", size=2)+
        ggtitle("Mass Spectrum")+
        geom_label(data=graph2, aes(x=isotopes, y=range+5,  label = isotopes), color="black", fontface="bold", size=5, family="sans")+
        xlim(firstmass-1, thirdmass+1)+
        ylim(0, 110)+
        xlab("m/z")+
        ylab("Intensity (%)")+
        theme(axis.text=element_text(size=17,family="sans"),
              axis.title=element_text(size=17,face="bold",family="sans"),
              #strip.text.y = element_text(size=12,family="sans"), 
              plot.title=element_text(size=20,face="bold",family="sans"),
              panel.background = element_rect(fill = "white", color="grey", size=0.5),
              panel.grid = element_blank())
        #theme_classic(base_size = 16)
})

observe({
    vals$answermass <- input$answermass
})

expectedmass <- round(1/(secondiso-firstiso), digits=0)

output$expectedmass <- renderText({
    round(1/(secondiso-firstiso), digits=0)
})

output$check_answermass <- eventReactive(input$submit_answermass, {
    isolate({
        if(input$answermass == expectedmass){
            answersmass <- "Correct"
        }
        else{
            answersmass <- "Please Try Again!"
        }
    })
    answersmass
})

})



# protein #

new_plot2 <- observeEvent(input$update_plot2,{
    firstiso2 <- sample(5:20, 1)
    dec <- c(0.2, 0.25, 0.33, 0.5)
    massiso2 <- sample(20000:60000, 1) + sample(dec, 1)
    secondiso2 <- 0
    
    firstmass2 <- round((massiso2+firstiso2)/(firstiso2), digits=2)
    secondmass2 <- round((massiso2+(firstiso2+1))/(firstiso2+1), digits=2)
    thirdmass2 <- round((massiso2+(firstiso2+2))/(firstiso2+2), digits=2)
    fourthmass2 <- round((massiso2+(firstiso2+3))/(firstiso2+3), digits=2)
    fifthmass2 <- round((massiso2+(firstiso2+4))/(firstiso2+4), digits=2)
    sixthmass2 <- round((massiso2+(firstiso2+5))/(firstiso2+5), digits=2)
    seventhmass2 <- round((massiso2+(firstiso2+6))/(firstiso2+6), digits=2)
    eigthmass2 <- round((massiso2+(firstiso2+7))/(firstiso2+7), digits=2)
    ninthmass2 <- round((massiso2+(firstiso2+8))/(firstiso2+8), digits=2)
    
    range2 <- c(6,12.5,35,50,90,100,85,50,20)
    isotopes2 <- c(firstmass2, secondmass2, thirdmass2, fourthmass2, fifthmass2, sixthmass2, seventhmass2, eigthmass2, ninthmass2)

    graph3 <- data.frame(isotopes2, range2)
    
    output$plot3 <- renderPlot({
        ggplot(data=graph3, aes(x=range2, y=isotopes2))+
            geom_segment(aes(x=isotopes2, xend=isotopes2, y=0, yend=range2), color= "black", size=2)+
            ggtitle("Mass Spectrum")+
            geom_label(data=graph3, aes(x=isotopes2, y=range2+5,  label = isotopes2), color="black", fontface="bold", size=5, family="sans")+
            xlim(ninthmass2-100, firstmass2+100)+
            ylim(0, 110)+
            xlab("m/z")+
            ylab("Intensity (%)")+
            theme(axis.text=element_text(size=17,family="sans"),
                  axis.title=element_text(size=17,face="bold",family="sans"),
                  #strip.text.y = element_text(size=12,family="sans"), 
                  plot.title=element_text(size=20,face="bold",family="sans"),
                  panel.background = element_rect(fill = "white", color="grey", size=0.5),
                  panel.grid = element_blank())
        #theme_classic(base_size = 16)
    })
    
    observe({
        vals$answermass2 <- input$answermass2
    })
    
    expectedmass2 <- round(((firstmass2-1.01)*(secondmass2-1.01))/(firstmass2-secondmass2), digits=0)
    
    output$expectedz2 <- renderText({
        round((secondmass2-1.01)/(firstmass2-secondmass2), digits=0)
    })
    
    output$expectedmass2 <- renderText({
        round(((firstmass2-1.01)*(secondmass2-1.01))/(firstmass2-secondmass2), digits=0)
    })
    
    output$check_answermass2 <- eventReactive(input$submit_answermass2, {
        isolate({
            if(input$answermass2 == expectedmass2){
                answersmass2 <- "Correct"
            }
            else{
                answersmass2 <- "Please Try Again!"
            }
        })
        answersmass2
    })
    
    output$show2_answermass2 <- eventReactive(input$show_answermass2, {
        isolate({
            if(input$show_answermass2 == "show"){
                answersmass3 <- expectedmass2
            }
            else{
                answersmass3 <- " "
            }
        })
        answersmass3
    })
    
    output$show2_hint2 <- eventReactive(input$show_hint2, {
        isolate({
            if(input$show_hint2 == "show"){
                hint <- "Molecular Weight = (M1 - A) * (M2 -A) / (M1 − M2) . Use 1.001 for protonated adduction (A) ."
            }
            else{
                hint <- " "
            }
        })
        hint
    })
    
})



})


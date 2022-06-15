
library(shiny)

shinyUI(
navbarPage("",  theme = "custom.css",

tabPanel(title = "Mass Spectrometry Student Practice",

    sidebarLayout(
        sidebarPanel(id="sidebar",
          img(src="logo.png", width = "100%"),
          h4(icon("clipboard-check"), "Instructions"),
          p("All calculations are for positive mode MS."),
          p("Follow prompts to use the calculator or reset practice problem.")
        ),

        mainPanel(
            tabsetPanel(
            tabPanel("Intact Mass Calulcator",
                div(
                br(),
                span(id="blockspan2",
                # print(withMathJax("$$\\text{Display formula in heading }X_n=X_{n-1}-\\varepsilon$$")),
                numericInput("mz1", "Enter m/z of interest:", "1000"),
                numericInput("z1", "Enter charge (z):", "2"),
                numericInput("adduct", "Enter mass of charge carrier:", "1.007"),
                p("Mass"),
                textOutput("mass1")
                ),
                span(id="blockspan2", 
                     h4("Common Mass Adducts"),
                     h4("H - 1.007"),
                     h4("Na - 22.989"),
                     h4("K - 38.963")
                     )
                )
            ),
            tabPanel("Protein Mass",
                br(),
                plotOutput("plot3"),
                span(id="blockspan",
                     h4("Click to Start"),
                     actionButton("update_plot2","New Question"), 
                ),
                br(),
                div(
                span(id="blockspan3",
                numericInput("answermass2", "Answer (Rounded to Integer)", value = 0),
                actionButton("submit_answermass2","Submit"),
                textOutput("check_answermass2"),
                ),
                span(id="blockspan3",
                radioButtons("show_hint2","Show Hint", c("hide", "show")),
                textOutput("show2_hint2"),
                ),
                span(id="blockspan3",
                radioButtons("show_answermass2","Show Answer", c("hide", "show")),
                textOutput("show2_answermass2"),
                ),
                
                ),
            ),
            tabPanel("Calculating Charge State",
                # print(withMathJax("$$\\text{Display formula in heading }X_n=X_{n-1}-\\varepsilon$$")),
                plotOutput("plot2"),
                div(
                span(id="blockspan2",
                h4("Click to Start"),
                actionButton("update_plot","New Question"), 
                ),
                span(id="blockspan2",
                radioButtons("answermass", "Answer", c(1,2,3,4,5), inline=TRUE),
                actionButton("submit_answermass","Submit"),
                textOutput("check_answermass"),
                ),
                ),
            ),
            # Future Calculator
            # tabPanel("Test2",
            #     textOutput("number1"),
            #     textOutput("number3"),
            #     numericInput("answer", "Answer", value = 0),
            #     actionButton("submit_answer","Submit"),
            #     textOutput("check_answer"),
            #     actionButton("update_question","New Question"),     
            # 
            # )
        )
    )
)
)

))

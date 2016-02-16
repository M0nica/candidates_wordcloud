
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
library(shiny)
# ui.R

shinyUI(fluidPage(
  titlePanel("Tweets per Candidate"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Choose a specific candidate, visualize their wordcloud"),
      
      selectInput("var", 
                  label = "Choose a variable to display",
                  choices = c("Hillary Clinton", "Bernie Sanders", "Ted Cruz", "Donald Trump", "Marco Rubio"),
                              #, "Jeb Bush", "John Kasich",
                              #"Ted Cruz", "Marco Rubio","Donald Trump", "Ben Carson", "Chris Christie", "Carly Fiorina"),
                  selected = "Percent White"),
      sliderInput("wordCount", 
                  label = "Max words to display",
                  min = 5, max = 250, value = 100)
  #   ,
      
#    sliderInput("range", 
#                 label = "Range of time",
#                   min = 0, max = 200, value = c(0, 200))
     ),
    
    mainPanel(
      
      textOutput("text1"),
      plotOutput("wordcloudT",click = "plot_click"),
      verbatimTextOutput("info_click"),
      plotOutput("freq_plot")
     
    )
    
  )
  
))

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
      
      #users select which candidate they would like to visualize
      selectInput("var", 
                  label = "Choose a variable to display",
                  choices = c("Hillary Clinton", "Bernie Sanders", "Ted Cruz", "Donald Trump", "Marco Rubio"),
                  selected = "Percent White"),
      #users can choose the maximum amount of words they would like the wordcloud to display
      sliderInput("wordCount", 
                  label = "Max words to display",
                  min = 5, max = 250, value = 100)

     ),
    
    mainPanel(
      
      textOutput("text1"),
      plotOutput("wordcloudT",click = "plot_click"),
      verbatimTextOutput("info_click"),
      plotOutput("freq_plot")
     
    )
    
  )
  
))
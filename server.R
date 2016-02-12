# server.R

library(streamR)
library(tm)
library(wordcloud)

#load("my_oauth.Rdata")
#load("all_candidates.json")
shinyServer(function(input, output) {
  
  
  tweets_shiny.df <- parseTweets("all_candidates.json", simplify = TRUE)
  
  tweets_shiny.df$text <- sapply(tweets_shiny.df$text, function(row) iconv(row, "latin1", "ASCII", sub = ""))

  TweetCorpus <- paste(unlist(tweets_shiny.df$text), collapse =" ") 
  TweetCorpus <- Corpus(VectorSource(TweetCorpus))
  TweetCorpus <- tm_map(TweetCorpus, PlainTextDocument)
  TweetCorpus <- tm_map(TweetCorpus, removePunctuation)
  TweetCorpus <- tm_map(TweetCorpus, removeWords, stopwords('english'))
  TweetCorpus <- tm_map(TweetCorpus, stemDocument)
  TweetCorpus <- tm_map(TweetCorpus, content_transformer(tolower),lazy=TRUE)
  TweetCorpus <- tm_map(TweetCorpus, PlainTextDocument)
  #want to remove candidates from their own wordcloud
  TweetCorpus <- tm_map(TweetCorpus, removeWords, c("this", "presid", "end", "while", "doesnt", "httpstcoau9loazlxp", "https", "chrischristi", "that", "httpstco", "httpst", "http", "car", "chris", "christi", "hillaryclinton","johnkasich", "marcorubio", "hillari", "carlyfiorina", "fiorina", "hillary",  "berniesand", "sander", "berni", "realdonaldtrump", "bernie", "sanders", "donald", "trump", "clinton", 
                                                    "hillary clinton", "bernie sanders", "jeb bush", "marco rubio", "ted cruz", "donald trump", "john kasich", "ben carson", "chris christie", "carly fiorina", "hillaryclinton", 
                                                    "jebbush", "berniesanders", "marcorubio", "chrischristie", "bencarson", "johnkasich", "donaldtrump", "tedcruz", "carlyfiorina"
))

  
  times <- as.POSIXct(tweets_shiny.df$created_at, format="%a %b %d %H:%M:%S %z %Y")
 
 output$freq_plot<- renderPlot({
  # hist(times, breaks="mins")
   hist(times, breaks=30)
   #xlim= (input$range))
  })
  
  output$wordcloudT <- renderPlot({
   # wordcloud(TweetCorpus, max.words = 250, random.order = FALSE,scale=c(8,1),colors=brewer.pal(8, "Dark2"))
   # made scale smaller so that it will fit all of the tweets
    #filters to only include the candidate that is selected from the dropdown menu
    tweets_shiny.df$text <- sapply(tweets_shiny.df$text, function(row) iconv(row, "latin1", "ASCII", sub = input$var))
  
     wordcloud(TweetCorpus, max.words = input$wordCount, random.order = FALSE,scale=c(5,.05),colors=brewer.pal(8, "Dark2"))
  })
  
  output$info_click <- renderText({
    paste0("x=", input$plot_click$x, "\ny=", input$plot_click$y)
  })
  
  output$text1 <- renderText({ 
    paste("You have selected this", input$var)
  })
  
  
}
)
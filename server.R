# server.R

library(streamR)
library(tm)
library(wordcloud)
source("Untitled.R")

#load("my_oauth.Rdata")
#load("all_candidates.json")

tweets_shiny.df <- parseTweets("all_candidates.json", simplify = TRUE)
# 
# HillaryClinton <- tweets_shiny.df[grep("Hillary Clinton", tweets_shiny.df$text), ]
# HillaryClinton_wo <- tweets_shiny.df[grep("HillaryClinton", tweets_shiny.df$text), ]
# HillaryTotals <- rbind(HillaryClinton, HillaryClinton_wo)
# 
# BernieSanders<- tweets_shiny.df[grep("Bernie Sanders", tweets_shiny.df$text), ]
# BernieSanders_wo <- tweets_shiny.df[grep("BernieSanders", tweets_shiny.df$text), ]
# BernieTotals <- rbind(BernieSanders, BernieSanders_wo)

toCorpus <- function(dframe) {
  text <- sapply(dframe$text, function(row) iconv(row, "latin1", "ASCII", sub = ""))
  #removes all http from text
  text <- gsub("(f|ht)tp(s?)://(.*)[.][a-z]+", "", text)
  TweetCorpus <- paste(unlist(text), collapse =" ") 
  TweetCorpus <- Corpus(VectorSource(TweetCorpus))
  TweetCorpus <- tm_map(TweetCorpus, PlainTextDocument)
  TweetCorpus <- tm_map(TweetCorpus, removePunctuation)
  TweetCorpus <- tm_map(TweetCorpus, removeWords, stopwords('english'))
  # TweetCorpus <- tm_map(TweetCorpus, stemDocument)
  TweetCorpus <- tm_map(TweetCorpus, content_transformer(tolower),lazy=TRUE)
  TweetCorpus <- tm_map(TweetCorpus, PlainTextDocument)
  #want to remove candidates from their own wordcloud
 TweetCorpus <- tm_map(TweetCorpus, removeWords, c("like","will", "president", "say", "realjameswood", "for", "think", "the", "dont", "new", "amp", "get", "now","via", "this", "presid", "end", "while", "doesnt", "httpstcoau9loazlxp",  "httpstcoatbyuvqbkp", "https", "chrischristi", "that", "httpstco", "httpst", "http", "car", "chris", "christi", "hillaryclinton","johnkasich", "marcorubio", "hillari", "carlyfiorina", "fiorina", "hillary",  "berniesand", "sander", "berni", "realdonaldtrump", "bernie", "sanders", "donald", "trump", "clinton", 
                                                   "hillary clinton", "bernie sanders", "jeb bush", "marco rubio", "ted cruz", "donald trump", "john kasich", "ben carson", "chris christie", "carly fiorina", "hillaryclinton", 
                                             "jebbush", "berniesanders", "marcorubio", "chrischristie", "bencarson", "johnkasich", "donaldtrump", "tedcruz", "carlyfiorina"
  ))
  return(TweetCorpus)
}

BernieCorpus <- toCorpus(BernieTotals)
HillaryCorpus <- toCorpus(HillaryTotals)
TedCorpus <- toCorpus(TedTotals)
MarcoCorpus <- toCorpus(MarcoTotals)
DonaldCorpus <- toCorpus(DonaldTotals)

#  times <- as.POSIXct(tweets_shiny.df$created_at, format="%a %b %d %H:%M:%S %z %Y")

shinyServer(function(input, output) {
  
  output$wordcloudT <- renderPlot({
    if (input$var == "Hillary Clinton"){
      corpus <- HillaryCorpus
    } else if (input$var == 'Bernie Sanders'){
      corpus <- BernieCorpus
    } else if (input$var == 'Ted Cruz'){
      corpus <- TedCorpus
    }
    else if  (input$var == 'Donald Trump'){
      corpus <-DonaldCorpus
    }
    else if  (input$var == 'Marco Rubio'){
      corpus <-MarcoCorpus
    }
    wordcloud(corpus, max.words = input$wordCount, random.order = FALSE,scale=c(3.75,.05), min.freq=2, colors=brewer.pal(8, "Blues"))
  })
  

 output$freq_plot<- renderPlot({
   #times <- sapply(tweets_shiny.df$text, function(row) iconv(row, "latin1", "ASCII", sub = "input$var"))
 #hist(times, breaks="secs")
  # tweets_shiny.df$text <- sapply(tweets_shiny.df$text, function(row) iconv(row, "latin1", "ASCII", sub = input$var))
   
  # tweets_shiny.df$created_at <- as.POSIXct(tweets_shiny.df$created_at, format="%a %b %d %H:%M:%S %z %Y")
 #  times <- as.POSIXct(tweets_shiny.df$created_at, format="%a %b %d %H:%M:%S %z %Y")
   
   
   if (input$var == "Hillary Clinton"){
     filename <- HillaryTotals
   } else if (input$var == 'Bernie Sanders'){
     filename <- BernieTotals
   } else if (input$var == 'Ted Cruz'){
     filename <- TedTotals
   }
   else if  (input$var == 'Donald Trump'){
     filename <-DonaldTotals
   }
   else if  (input$var == 'Marco Rubio'){
     filename <-MarcoTotals
   }
   
   times <- as.POSIXct(filename$created_at, format="%a %b %d %H:%M:%S %z %Y")
   hist(times, breaks=35)
 
 #  hist(times, breaks=10)
   #xlim= (input$range))
  })
  

 
 
  output$info_click <- renderText({
    paste0("x=", input$plot_click$x, "\ny=", input$plot_click$y)
  })
  
  output$text1 <- renderText({ 
    paste("You have selected ", input$var)
  })
  
  
}
)
library(streamR)

library(tm)
tweets_shiny.df <- parseTweets("all_candidates/all_candidates.json", simplify = TRUE)

tweets_shiny.df$text <- sapply(tweets_shiny.df$text, function(row) iconv(row, "latin1", "ASCII", sub=""))
TweetCorpus <- paste(unlist(tweets_shiny.df$text), collapse =" ") 
TweetCorpus <- Corpus(VectorSource(TweetCorpus))
TweetCorpus <- tm_map(TweetCorpus, PlainTextDocument)
TweetCorpus <- tm_map(TweetCorpus, removePunctuation)
TweetCorpus <- tm_map(TweetCorpus, removeWords, stopwords('english'))
TweetCorpus <- tm_map(TweetCorpus, stemDocument)
TweetCorpus <- tm_map(TweetCorpus, content_transformer(tolower),lazy=TRUE)
TweetCorpus <- tm_map(TweetCorpus, PlainTextDocument)
#gets rid of error that wierd characters caused 
TweetCorpus <- tm_map(TweetCorpus, function(x) iconv(enc2utf8(x), sub = "byte"))

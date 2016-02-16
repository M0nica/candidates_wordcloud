tweets_shiny.df <- parseTweets("all_candidates.json", simplify = TRUE)
#make tweets go to lowercase 
HillaryClinton <- tweets_shiny.df[grep("Hillary Clinton", tweets_shiny.df$text), ]
HillaryClinton_wo <- tweets_shiny.df[grep("HillaryClinton", tweets_shiny.df$text), ]
HillaryTotals <- rbind(HillaryClinton, HillaryClinton_wo)
write.csv(HillaryTotals, file = "HillaryClintonTotalsTest.csv")
#load(HillaryTotals)

#tweets_shiny.df <- parseTweets("all_candidates.json", simplify = TRUE)
BernieSanders<- tweets_shiny.df[grep("Bernie Sanders", tweets_shiny.df$text), ]
BernieSanders_wo <- tweets_shiny.df[grep("BernieSanders", tweets_shiny.df$text), ]
BernieTotals <- rbind(BernieSanders, BernieSanders_wo)

#tweets_shiny.df <- parseTweets("all_candidates.json", simplify = TRUE)
DonaldTrump<- tweets_shiny.df[grep("Donald Trump", tweets_shiny.df$text), ]
DonaldTrump_wo <- tweets_shiny.df[grep("DonaldTrump", tweets_shiny.df$text), ]
DonaldTotals <- rbind(DonaldTrump, DonaldTrump_wo)


#tweets_shiny.df <- parseTweets("all_candidates.json", simplify = TRUE)
TedCruz<- tweets_shiny.df[grep("Ted Cruz", tweets_shiny.df$text), ]
TedCruz_wo <- tweets_shiny.df[grep("TedCruz", tweets_shiny.df$text), ]
TedTotals <- rbind(TedCruz, TedCruz_wo)


#tweets_shiny.df <- parseTweets("all_candidates.json", simplify = TRUE)
MarcoRubio<- tweets_shiny.df[grep("Marco Rubio", tweets_shiny.df$text), ]
MarcoRubio_wo <- tweets_shiny.df[grep("MarcoRubio", tweets_shiny.df$text), ]
MarcoTotals <- rbind(MarcoRubio, MarcoRubio_wo)
#load(MarcoTotals)

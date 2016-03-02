# candidates_wordcloud_NH
generates wordclouds from tweets for presidential candidates (Shiny App)
url: https://monicapowell.shinyapps.io/all_candidates/

The Shiny application in the all_candidates folder visualizes 1120 tweets that were streamed from Twitter over 30 minutes. 
with the following keywords: 
Hillary Clinton, Bernie Sanders, Jeb Bush, Marco Rubio, Ted Cruz, Donald Trump, John kasich, Ben Carson, Chris Christie, Carly Fiorina, Hillaryclinton, Jebbush, Berniesanders, Marcorubio, Chrischristie, Bencarson, Johnkasich, Donaldtrump, Tedcruz, CarlyFiorina

The application allows users to switch between 5 presidential candidates (Hillary Clinton Marco Rubio, Bernie Sanders, Ted Cruz and Donald Trump) in order to visualize information related to the tweets that mentioned that particular candidate. The frequency of tweets is represented with a histogram that records the density of tweets mentioning a candidate during segments of time during the 30 minutes that the tweets were collected. The actual content of the tweets is represented with a wordcloud in which words that appeared more frequently are more prominent and users can manually choose howm any of these words they would like to display (min = 5, max = 250, default = 100).

library('dplyr')
library('data.table')
library('lubridate')
library('stringr')
library('shinydashboard')
library('plotly')
library('shiny')
library('shinyjs')
library("DT")
library('markdown')
library('tidyr')
library("tidyverse")
library('tm')
library('wordcloud')
library('memoise')
set.seed(123)


dat <- read_csv("data/winemag-data-130k-v2.csv")

# The list of valid books
# books <<- list("A Mid Summer Night's Dream" = "summer",
#                "The Merchant of Venice" = "merchant",
#                "Romeo and Juliet" = "romeo")

wines <- unique(dat$variety)

# Using "memoise" to automatically cache the results
getTermMatrix <- memoise(function(wine_description) {
  # Careful not to let just any name slip in here; a
  # malicious user could manipulate this value.
  
  text <- paste0(wine_description,collapse = ' ')
  
  myCorpus = Corpus(VectorSource(text))
  myCorpus = tm_map(myCorpus, content_transformer(tolower))
  myCorpus = tm_map(myCorpus, removePunctuation)
  myCorpus = tm_map(myCorpus, removeNumbers)
  myCorpus = tm_map(myCorpus, removeWords,
                    c(stopwords("SMART"), "thy", "thou", "thee", "the", "and", "but"))
  
  myDTM = TermDocumentMatrix(myCorpus,
                             control = list(minWordLength = 1))
  
  m = as.matrix(myDTM)
  
  sort(rowSums(m), decreasing = TRUE)
})
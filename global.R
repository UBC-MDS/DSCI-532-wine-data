library('dplyr')
library('data.table')
library('plotly')
library("ggplot2")
library("DT")
library('maps')
library('stringr')
library('shinydashboard')
library('shiny')
library('shinyjs')
library('markdown')
library('tidyr')
library("tidyverse")
library('tm')
library('wordcloud')
library('memoise')
library("ggjoy")
set.seed(123)


dat <- read_csv("winemag_data_130k_v2.csv")
dat <- unique(dat[,-1])

extract_year <- function(string){
  regx <- regmatches(string, regexec("[0-9]{4}", string))
  sapply(regx, function(x){
    if(length(x)>0) return(as.numeric(x))
    else return(NA)
  })
}

dat$vintage_year <- extract_year(as.character(dat$title))

wines <- unique(dat$variety)

countries <- unique(dat$country)

dat2 = dat[sample(nrow(dat), 1000),]

# Using "memoise" to automatically cache the results
getTermMatrix <- memoise(function(text) {
  
  text <- paste0(text,collapse = ' ')
  
  myCorpus = Corpus(VectorSource(text))
  myCorpus = tm_map(myCorpus, content_transformer(tolower))
  myCorpus = tm_map(myCorpus, removePunctuation)
  myCorpus = tm_map(myCorpus, removeNumbers)
  myCorpus = tm_map(myCorpus, removeWords,
                    c(stopwords("SMART"), "thy", "thou", "thee", "the", "and", "but","wine","flavors"))
  
  myDTM = TermDocumentMatrix(myCorpus,
                             control = list(minWordLength = 1))
  
  m = as.matrix(myDTM)
  
  v = sort(rowSums(m), decreasing = TRUE)
})
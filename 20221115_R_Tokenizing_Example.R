#https://towardsdatascience.com/create-a-word-cloud-with-r-bde3e7422e8a

library(readr)
library(tm)

#import spreadsheet
nj_police_covid <- read_csv("~/Documents/2022 NJ COVID Enforcement Combined Master Data Spread Sheet.csv")

#save the text column we want to tokenize as grounds and combine all rows into one vector
grounds <- nj_police_covid$Grounds
g <- Corpus(VectorSource(grounds))

#clean up the text by removing numbers, punctuation, whitespace, and stop words (e.g., "the","or", "and", etc.)
#convert all words to lower-case for consistency
g <- g %>%
  tm_map(removeNumbers) %>%
  tm_map(removePunctuation) %>%
  tm_map(stripWhitespace)
g <- tm_map(g, content_transformer(tolower))
g <- tm_map(g, removeWords, stopwords("english"))

#create a matrix of all the words in the text
g_tdm <- TermDocumentMatrix(docs) 
m <- as.matrix(g_tdm) 
words <- sort(rowSums(m),decreasing=TRUE) 

#create a dataframe with two columns: 1) the word 2) the # times the word shows up
g_df <- data.frame(word = names(words),freq=words)




# Directions:

# This file contains homework questions for the lecture on data visualization.
# Questions appear as comments in the file. 

# Please see the Grading Criteria Canvas Page for specific guidance on what
# we expect from you regarding assignment responses.

# Once you have completed the assignment, follow the Submission Instructions 
# on Canvas Pages section to add, commit, and push this to your GitHub repository. 

# Some questions have multiple parts - make sure to read carefully and
# answer all of them. The majority of points lost in homework come from
# careless skipping over question parts.  

###############################################################################

# library(stringr)
# library(tm)
# library(ggplot2)
# library(forcats)
# library(lubridate)
# library(tokenizers)

# Write a R code snippet that uses regular expressions to find all occurrences of 
# dates in the string variable text that are in the format "dd/mm/yyyy" and replace 
# them with the format "yyyy-mm-dd". The text variable contains multiple dates in 
# the "dd/mm/yyyy" format interspersed with other text. For example, if text is 
# "The event was held on 23/04/2021 and the next event will be on 05/10/2022.", 
# the output should be "The event was held on 2021-04-23 and the next 
# event will be on 2022-10-05.".
#
# Ensure your code dynamically handles the text variable, meaning it should work 
# for any string input following the mentioned pattern. Use relevant functions from 
# the stringr package, any other package, or base R for your solution. 
# [Code completion + comprehension]


text = "The event was held on 23/04/2021 and the next event will be on 05/10/2022." # example string assigned to text variable
text = "My birthday party was held on 03/04/2025 this year, and will be on 03/04/2026 next year." # tried with different
# string to see if it still worked 

str_view(text, "(\\d{2})/(\\d{2})/(\\d{4})") # test to see if we're capturing what we want to capture

new_text = str_replace_all(text, "(\\d{2})/(\\d{2})/(\\d{4})", "\\3-\\2-\\1") # backslashes escape the special characters
# and captures the two digit of the day, two digits of the month, and four digits of the year (that are separated by forward slashes),
# and then replaces them in the test string in the correctly formatted date (year, month, day; separated by dashes)

print(new_text) # print output

# Write an R code snippet that assigns the string "I am here.  Am I alive" to
# a variable "x" and uses an Escape Sequence to put a newline between the two
# sentences. [Code completion + comprehension]

x = "I am here.  Am I alive" # assigns string to the variable
new_x = str_replace_all(x,"\\.\\s+", ".\n") # the backslash escapes the special character and the
# \\. matches the period and the \\s+ matches the white space and replaces it with a period and a new line
cat(new_x) # prints the newly structured sentences to the console


# Write an R code snippet that assigns the following string to the variable "y:"
#
# She said, "Hi!"
# [Code completion + comprehension] 

y = cat('She said, "Hi!"') # to use double quotes in the sentence you need to use single quotes to define the string 


# [TEXT ANSWER] Explain what a Text Encoding is:
# [Comprehension]

#' Text encoding is the assigning of a unique numeric code to characters (letters, numbers, or symbols) 
#' so they are able to be processed by computers. There are various text encodings at are able to
#' support certain numbers of characters. The most common encoding scheme is Unicode and
#' text coding is important as it allows for text to be correctly stored and displayed across
#' different systems.


# Write an R code snippet that creates a vector of all containing the words in the string, 
# "He wanted to say hello but was afraid".  Then use the stringr library to locate any 
# occurrences of the string "hello" in your vector.
# [Code completion + interpretation]

y = "He wanted to say hello but was afraid." # assigns string to variable 
words_clean <- unlist(str_split(str_replace_all(y, "[[:punct:]]", " "), "\\s+")) 
# replaces punctuation with a space and then splits the string at the spaces, then since str_spilt returns a list 
# we need to use unlist as to returns a vector containing all the words
z = str_locate_all(words_clean, "hello") # locate instances of the string 'hello'
print(z) # prints out the starting and ending position of hello in the variable words_clean

# Section "15.7 Corpus Analytics" of the reader contains a tutorial on performing
# corpus analytics on a Document Term Matrix of 19th Century novels.  A Document Term
# Matrix is a matrix that contains information about the number of times that a work 
# appears in each text in a corpus.  In class, we calculated the word frequencies for
# the novel _Wuthering Heights_.  There "data" folder in the Files area of Canvas for 
# this course contains a file names dtm.rds which holds this type of count information
# for every normalized text in the collection of novels we worked with in class. 
# 
#     First, download that file to your course working directory.   
#     Then, recreate a working version of the code in section 15.8 of the reader below.
#     Note that before you can use the code in that section you will need to read 
#     dtm.rds file into the dtm variable so that the data in the DTM is available to
#     the rest of the code.
# [Code completion + interpretation]

dtm = readRDS("~/sts115_denapham/data/dtm.rds") # read in the file containing
# the frequencies of term across a whole corpus, this format allows use to easily compare 
# words across multiple documents 

cleaned_corpus <- readRDS("~/sts115_denapham/data/C19_novels_cleaned.rds")
# read in file contain the cleaned corpus, this corpus was created by taking a 'raw' file
#' containing our novels, collapsing the paragraphs into a single stream of text and then
#' wrapping it a corpus object. This corpus was then cleaned with the tm_map function. This function
#' removed stop words (or words without much significant meaning), made all the letters lower cased,
#' and removed punctuation/numbers (this effectively tokenized the words making later analysis simpler).

manifest <- read.csv("~/sts115_denapham/data/C19_novels_manifest.csv", row.names = 1) #load in manifest of metadata
dtm$dimnames$Docs <- manifest$title # use the manifest to give the give names to the documents as currently they are just
# numbers in a vector

term_counts <- as.matrix(dtm) 
term_counts <- data.frame(sort(colSums(term_counts), decreasing = TRUE))
# transform dtm into matrix and then into a data frame, sorting by word frequency 
term_counts <- cbind(newColName = rownames(term_counts), term_counts) # extracts row names and creates a new column with the row names 
colnames(term_counts) <- c("term", "count") # names column contain row names 'term' and column with their freq. 'count'

ggplot(term_counts[1:50, ]) + # subsets the top 50 words
  aes(x = fct_reorder(term, -count), y = count) + # the y-axis plots the word counts in descending order
  geom_bar(stat = "identity") + # a bar plot showing word count rather that relative frequencies 
  theme(
    axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1) # rotates the text so it doesn't overlap
  ) +
  labs(
    title = "Top 50 words in 18 Nineteenth-Century Novels",
    x = "Word",
    y = "Count"
  ) # labels both axis and the graph 


dtm_tfidf <- DocumentTermMatrix(
  cleaned_corpus,
  control = list(weighting = weightTfIdf) #creates a new dtm, however this time we are taking into consideration the word's TF-IDF score
)
# TF-IDF score adjusts for common words across the corpus, proportion increases with word frequency within a document 
# however it is offset by the number of docs that contain the word. This 'boost' rare/unique terms -- this is useful as the previous 
# graph just contained many of the most common English words and told us nothing about our specific texts 

tfidf_counts <- as.matrix(dtm_tfidf)
tfidf_counts <- data.frame(sort(colSums(tfidf_counts), decreasing = TRUE))
# transform dtm into matrix and then into a data frame, sorting by word frequency 
tfidf_counts <- cbind(newColName = rownames(tfidf_counts), tfidf_counts) # extracts row names and creates a new column with the row names
colnames(tfidf_counts) <- c("term", "tfidf") # names column contain row names 'term' and column with their TF-IDF scores 'tfidf'

ggplot(data = tfidf_counts[1:50, ]) + # subsets the top 50 words
  aes(x = fct_reorder(term, -tfidf), y = tfidf) + # the y-axis plots the word scores in descending order
  geom_bar(stat = "identity") + # a bar plot showing TF-IDF scores
  theme(
    axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1) # rotates the text so it doesn't overlap
  ) +
  labs(
    title = "Words with the 50-highest TF-IDF scores in 18 Nineteenth-Century Novels",
    x = "Word",
    y = "TF-IDF"
  ) # labels both axis and the graph 

# some ways to analysis texts using TF-IDF scores include finding term correlations 
findAssocs(dtm_tfidf, terms = "boat", corlimit = .85) # example showing which words often occur with the word boat

# you could also split up the novels to look at each book individually 
tfidf_df <- as.matrix(dtm_tfidf)
tfidf_df <- as.data.frame(t(tfidf_df)) # turns dtm into df, and turns the documents into columns and the words into rows
colnames(tfidf_df) <- manifest$title

ordering <- order(tfidf_df$Frankenstein, decreasing = TRUE) # to illustrate we can look at the most unique terms specifically in Frankenstein
rownames(tfidf_df[ordering[1:50], ])

#Calculating the tf-idf be useful for researchers working with text data as it could allow us to see underling trends with a text. In this
# example we could investigate how the tone of gothic novels compares to non-gothic novels; or we could reveal surprising commonalities in
# in various novels! 

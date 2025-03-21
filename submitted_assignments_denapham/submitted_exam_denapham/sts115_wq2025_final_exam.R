############
# BEGINNING OF EXAM
# You have read the README file, pushed the exam files up to GitHub,
# and synced your repositories.

# Good job - move on to the next question!

############
# QUESTION 1 (5 points)
# The variable `events`, defined below, contains the dates for several
# important events in the 20th century. Write code to convert these dates 
# into R `Date` objects. Then, in a few sentences explain why using a 
# standardized date format is or isn't a good idea.

events = c("Fri August-15 in 1969", "Tue Jun-6 in 1944", "Sat Jan-1 in 2000") # events variable

library(stringr) # load library

# Code Answer:

# clean up the string
events_cleaned <- str_remove(events, "^.{4}") # remove first 4 characters (weekday)
events_cleaned <- str_replace(events_cleaned, "-", " ")  # replace dash with a space
events_cleaned <- str_remove(events_cleaned, " in")  # remove " in" 

# convert to date objects in the correct format
event_dates <- as.Date(events_cleaned, format = "%B %d %Y")

# print the date
print(event_dates)

class(event_dates) # check that the class is a date object

# Narrative Answer:
#' Using a standardized date format is a good idea as it allow use to do 'work' with the data,
#' when we covert into a date class you are able preform statistical analysis. For example you could
#' plot in a histogram when certain events happened and from this you are able to extract information.
#' You could see if a certain year in the 20th had fewer important events or you could see if important events
#' are more likely to happen later in the year to illustrate.


############
# QUESTION 2 (15 points)
# 2.1. The variable `menu`, defined below, contains a string from a local
# restaurant's online menu. Use string processing to convert this string into a
# data frame with separate columns for 'item' and 'price'. Next, combine your
# data-frame with the data frame 'guads', below. This combined data frame should 
# have a populated column called 'restaurant' so it's clear which row came from 
# Mayas (the original 'menu' data) and which came from Taqueria Guadalajaras ('guads').

# Tip! Print the variable after you instantiate it and before you try to write 
# code to answer the rest of the question. This will help you to form a better 
# strategy for splitting the string. You can also use the Regex validator at 
# https://regex101.com/ to verify that your Regex works correctly before you 
# use it in your R code.

menu = "MAYAS
Street taco ......... 3.99
Crispy taco ........... 6.99
Potato taco .......... 4.99
Veggie burrito ........ 7.49
Regular ............. 13.99
Super ............... 15.99
Chimichanga ......... 14.00
Beans, rice & cheese .... 10.99"


guads = data.frame(
  type = c("Taco de camaron", "Taco de pescado", "Taco dorado","Veggie burrito", "Regular", "Super", "Super Giant", "Chimichanga", "Beans, rice & cheese"),
  price = c(3.99, 3.99, 4.29, 9.49, 8.99, 10.99, 20.99, 11.99, 5.99)
)


# Code Answer:

# split the string into lines and remove the first line
menu_lines <- unlist(strsplit(menu, "\n"))[-1]

str_view(str_trim(str_extract(menu_lines, "^[^.]+")))
str_view((str_extract(menu_lines, "\\d+\\.\\d{2}")))
# separate item names and prices (capture text before dots and the price)
menu_items <- str_trim(str_extract(menu_lines, "^[^.]+"))  # capture item before the dots
menu_prices <- (str_extract(menu_lines, "\\d+\\.\\d{2}"))  # capture price

# create the data frame
menu_df <- data.frame(
  type = menu_items,
  price = menu_prices,
  restaurant = "Mayas" # create new column for the resturant 
)

# given data frame 
guads <- data.frame(
  type = c("Taco de camaron", "Taco de pescado", "Taco dorado", "Veggie burrito", "Regular", 
           "Super", "Super Giant", "Chimichanga", "Beans, rice & cheese"),
  price = c(3.99, 3.99, 4.29, 9.49, 8.99, 10.99, 20.99, 11.99, 5.99),
  restaurant = "Taqueria Guadalajaras" # create new column for the resturant 
)

# combine the two data frames
combined_df <- rbind(menu_df, guads)

# print the result
print(combined_df)

# Narrative Answer:
#' first split the menu into lines and remove mayas title, use regex to extract the item names and prices
#' create new data frame and bind with old from guads (remember to create new column)


# 2.2. Write code to generate a single data visualization to show the price by
# item per restaurant. In a few sentences, describe how your data visualization 
# may be easier to use than looking at the online menus when you and your friends 
# are deciding where to go for lunch.

# Code Answer:

library(ggplot2)

# create a bar plot to show price by item per restaurant
ggplot(combined_df, aes(x = type, y = price, fill = restaurant)) + # x-axis is the item, y is the price point, colors bars by resturant
  geom_bar(stat = "identity", position = "dodge") +  # position the bar side by side
  labs(title = "Price of Items at Mayas and Guads", # title and lable the graph
       x = "Menu Item",
       y = "Price",
       fill = "Restaurant") +
  theme(axis.text.x = element_text(angle = 90))  # rotate item labels

# Narrative Answer:
#' The data vis would be easier to read as when the prices are plotted side by side it make it simpler for your brain
#' to quickly compare the prices of certain items, as we know that our brains can more efficiently look at length of lines
#' rather than reading prices.


#############
# QUESTION 3 (15 points)
# Use the Cat Facts API documentation at 
# https://alexwohlbruck.github.io/cat-facts/docs/ to make a request to 
# the Cat Facts "facts" endpoint and retrieve 5 random facts about cats. 

# Note: you must properly construct the URL for your request by adding the 
# "endpoint" for your specific request as documented on the site to the 
# "base URL for all endpoints" which is also documented on the site.  
# All of the information that you need to construct a well-formed URL for your 
# request appears somewhere in the documentation, and you should be able to do 
# this using your knowledge of how URLs are constructed.

# Code Answer:

result = GET("https://cat-fact.herokuapp.com/facts/random?animal_type=cat&amount=5")
# parameter stating we want facts about cats, and the amount saying we want to retrieve 5 facts

#############
# QUESTION 4 (20 points)
# Wikipedia has a table of female Nobel Laureates at: 
# https://en.wikipedia.org/wiki/List_of_female_Nobel_laureates

# Write code that scrapes the page to get a data frame with the 
# year, name, country, and category for each laureate. You DO NOT need to worry
# about cleaning up the text to remove footnotes, parenthetical notes, 
# dual countries, or dual categories for this question.
library("xml2")
library(rvest)

# Code Answer:
wiki_url = "https://en.wikipedia.org/wiki/List_of_female_Nobel_laureates"
wiki_doc = read_html(wiki_url) # reads the url and assigns to variable

tables = xml_find_all(wiki_doc, "//table")
tables # there's 13 tables, the code is copied from the reader but I intend to go back and inspect the webpage
# and refine the x path route to be more specific as to extract the date and assign it to a data frame

tab = xml_find_all(tables, "//*[contains(@class, 'sortable')]")
names = html_table(tab, fill = TRUE)
names = names[[2]]
head(names)

######################################
# QUESTION 5 (20 points)
# The file `nobel_laureates_messy.rds` (included in the zip file you downloaded 
# that contains this exam file) contains a data frame with information about 
# female Nobel Laureates, scraped from Wikipedia. 

# 5.1. This new data frame is terribly messy. One issue is that while each row 
# corresponds to one laureate,  the `Laureate` column sometimes contains a 
# parenthetical note in addition to the laureate's name. Separate the name of 
# each laureate from these notes, so that the name is alone in the `Laureate` 
# column, and the note is stored in a new column called `Note`.

# Make sure there are no parentheses in the text in the `Note` column. For rows
# where there is no note, the value of the note should be `NA` or the empty 
# string `""` (either is acceptable, but don't use a mix of both).  This question 
# will require you to apply various skills that we learned in this course, 
# including manipulating the columns of a data frame and using regular expressions
# to identify substrings within a string.  

# Hint: The question asks you to apply computational operations across all 
# rows/observations in the data frame.  There are several ways to apply the same 
# function to all observations in R.  Before you begin coding, think about 
# how you will accomplish this iteration.  

nobel_messy <- readRDS("~/Desktop/dena_sts/nobel_laureates_messy.rds")                                                                                                   

# Code Answer:
#' After looking at the data frame I would use stringr to split the laureate column on the parenthese
#' then I would store the note into a new column named note, to loop across the df you could use an apply function or
#' you can create a loop that would take in each row as an interrattion 


# 5.2. What is something else you noticed about this data frame that should be
# cleaned before it is used in an analysis?

# Narrative Answer:
# When the nobel is shared between multiple laureates there can be multiple countries listed 
# this could be separated like the how we did with the names, so there could be two columns 
# with NA where both laureates are from the same country or their was only one winner of the prize

##############
# QUESTION 6 (25 points)
# For this question you will need add the carData package to your environment.
# Next, run this code: 

# install.packages("carData")
# library(carData)

demo <- carData::MplsDemo

# 6.1. In a paragraph, describe what 'demo' is about and define the variables 
# it contains. Include an explanation of how you determined your answers.

# Narrative Answer:
#' Demo is a data frame containing information about 84 neighborhoods (the neighborhood column is a list of characters)
#' The rest of the columns are all numeric and contain demographic characteristics about each neighborhood. For example,
#' their population, percentage of white/black/foreign born individuals, the average house hold income, the degree of poverty,
#' and the percentage of the population that are college graduates. 

# 6.2. Investigate this dataset and provide a short answer to the questions below.

# a. How many rows and columns are in the data set?
# Narrative Answer: There are 84 rows and 8 columns

# b. What are the names and classes of the columns in the data set?
# Narrative Answer: Names of the colums include "neighborhood", "population", "white", "black", "foreignBorn" 
#, "hhIncome", "poverty", "collegeGrad". The neighborhood column is character while the rest are numeric

# c. How many missing values are in each column?
# Narrative Answer: There are no missing values.

# d. How many missing values are in the data set in total?
# Narrative Answer: There are no missing values.

# Code Answer: Add any code here that you wrote to help you answer questions a-d above.
str(demo)
summary(demo)
colnames(demo)
nrow(demo)
ncol(demo)
class(demo$population)
class(demo$neighborhood)
lapply(demo, is.na)

# 6.3. Write code to help you identify any outliers in 'demo'. You can use 
# statistics or plotting to determine your answer. Return the index of any 
# outliers you discover.

# Code Answer
# load in dataset
install.packages("carData")
library(carData)

demo <- carData::MplsDemo
 
boxplot(demo$population, ylab = 'number of people in the neighborhood')


# I would create a loop that would go through the "population", "white", "black", "foreignBorn" 
# "hhIncome", "poverty", "collegeGrad" columns of demo, this loop would plot the data on a box and whisker plot
# any data points that would fall outside the 1st and 3rd quartile bounds would be considered an outlier 

# 6.4. Write a question to investigate using this data. Then, write code to 
# generate a data visualization that helps address your question.

# Your research question: Do neighborhood with a higher percentage of college graduates 
# have a lower percentage of poverty?

# Code Answer
ggplot(demo) +
  aes(x = collegeGrad, y = poverty) + # creates a dot plot, that shows poverty against college graduation rates 
  geom_point()
# looking at the plot there does seem to be a mild negative relationship between the two variables, that is the higher 
# the percentage of college graduates the lower the poverty rate in the neighborhood 

#############
# END OF EXAM
# Save and push your exam files to GitHub.
#############

# Congratulations, you're done! We wish you a restful spring break.
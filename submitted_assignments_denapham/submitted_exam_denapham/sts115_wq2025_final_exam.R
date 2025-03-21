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

events = c("Fri August-15 in 1969", "Tue Jun-6 in 1944", "Sat Jan-1 in 2000")

# Code Answer:


# Narrative Answer:




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





# Narrative Answer:

 


# 2.2. Write code to generate a single data visualization to show the price by
# item per restaurant. In a few sentences, describe how your data visualization 
# may be easier to use than looking at the online menus when you and your friends 
# are deciding where to go for lunch.

# Code Answer:





# Narrative Answer:




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





#############
# QUESTION 4 (20 points)
# Wikipedia has a table of female Nobel Laureates at: 
# https://en.wikipedia.org/wiki/List_of_female_Nobel_laureates

# Write code that scrapes the page to get a data frame with the 
# year, name, country, and category for each laureate. You DO NOT need to worry
# about cleaning up the text to remove footnotes, parenthetical notes, 
# dual countries, or dual categories for this question.


# Code Answer:




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
                                                                                                        

# Code Answer:





# 5.2. What is something else you noticed about this data frame that should be
# cleaned before it is used in an analysis?

# Narrative Answer:




##############
# QUESTION 6 (25 points)
# For this question you will need add the carData package to your environment.
# Next, run this code: 
demo <- carData::MplsDemo

# 6.1. In a paragraph, describe what 'demo' is about and define the variables 
# it contains. Include an explanation of how you determined your answers.

# Narrative Answer:





# 6.2. Investigate this dataset and provide a short answer to the questions below.

# a. How many rows and columns are in the data set?
# Narrative Answer: 

# b. What are the names and classes of the columns in the data set?
# Narrative Answer: 

# c. How many missing values are in each column?
# Narrative Answer: 

# d. How many missing values are in the data set in total?
# Narrative Answer: 



# Code Answer: Add any code here that you wrote to help you answer questions a-d above.



# 6.3. Write code to help you identify any outliers in 'demo'. You can use 
# statistics or plotting to determine your answer. Return the index of any 
# outliers you discover.

# Code Answer





# 6.4. Write a question to investigate using this data. Then, write code to 
# generate a data visualization that helps address your question.

# Your research question:




# Code Answer





#############
# END OF EXAM
# Save and push your exam files to GitHub.
#############

# Congratulations, you're done! We wish you a restful spring break.
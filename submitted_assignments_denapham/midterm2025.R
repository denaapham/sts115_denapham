################################################################
# This file contains questions for the midterm exam for STS115 #
# Winter Quarter, 2025.                                        #
#                                                              #
# This is exam is designed to provide you with the chance      #
# to demonstrate your understanding of both the concepts       #
# and syntax of the methods deployed by Data Scientists.       #
# As such, even if you are unable to provide working code      #
# for questions that require you to code, we encourage you     #
# to provide pseudo code and/or a textual explanation          #
# of your understanding of how one would approach the          #
# problem computationally, or even how the computer itself     #
# would approach the problem given your knowledge of how       #
# computers and programming languages work.                    #
#                                                              #
# Because problem solving is an essential part of being a      #
# Data Scientist, you are allowed to use any resources at      #
# your disposal to respond to the questions in this exam.      #
# This includes, but is not limited to, resources such as      #
# Google, Stack Overflow, the Course Reader, etc.              #
# The only restriction is that you may not use live chat,      # 
# messaging, email, discourse, Slack, or any other method of   # 
# real-time communication with another member of the course    #
# or any other person to formulate your response.              #
#                                                              #
# Questions appear as comments in this file.  As with the      #
# homework assignments, place your answers to each question    #
# immediately following the question prompt. Some questions    #
# require you to write computer code (R or Shell Script) as    #
# an answer and other questions ask you to provide text only   #
# explanations of computing and Data Science concepts.         #
# The phrase "[Text Answer]" appears immediately following     #
# each question that requires a text only answer. As noted     #
# above, you are encouraged to include text explanation of     #
# your code answers in all cases to increase your chances      #
# of earning partial credit for a question in the event that   #
# your code solution is incorrect.                             #
#                                                              #
# The exam duration is 1.5 hours.                              #                                                             #                                                              #
# Submit your completed exam and generated files via Github    #
# using the same workflow that you have used to submit your    #
# class homework.                                              #
################################################################


# Question 1. What is the command line symbol that provides 
# a shortcut to your "home" directory on your system.  For 
# example, what symbol would you use in place of "x" in the 
# command "cd x" if you wanted to use the cd command to move 
# into your home directory:

"cd ~" # shortcut to home directory


# Question 2. Write R code to assign the value 7 to a variable "x":

x <- 7 


# Question 3. Write R code that subtracts 3 from the variable "x" 
# and assigns the results to a variable "y":

y = x - 3


# Question 4. Assign the values 1, 23, 6, 2, 19, 7 to a vector:

nums = c(1,23,6,2,19,7) # assigns the values to a vector, named nums

# Question 5. Run the code `“four” < “five”`. Paste the output 
# from R into a comment and explain why you think it provided 
# that result: [Text Answer]

'four' < 'five'
# FALSE
class("four")

# FALSE was the output, this is the result as each character in the alphabet 
# gets a value assigned to it so the program is comparing each character in 
# the string. i comes before o in the alphabet which means it is less than 
# making the boolean false


# Question 6. Write a for loop that loops through each element in
# the vector you created in your answer to Question 4 and prints
# each value to screen:
for (x in nums){
  print(x)
}
# loop iterates through each value in the vector and print it to the 
# console

# Question 7. Assign the value 3 to a variable "x" and write
# a conditional statement that tests whether x is less than 5.  
# If it is, print "Yay!" to screen:

x = 3
if ( x < 5){
  print("Yay!")
}

# loop tests the conditional if the variable is less than 5, it's 3
# so yay is printed 

# Question 8. Download the "wine_enthusiast_rankings.csv" file from
# the "data" directory in the "Files" area of the course Canvas
# website and then write code to load it into a variable called "wine_revs":

wine_revs = read.csv("~/sts115_denapham/data/wine_enthusiast_rankings.csv")


# Question 9.  Write code to determine the class of the "wine_revs"
# data object you created in Question 8 above:

class(wine_revs) 
# the class returned is a data frame 


# Question 10. Write code that returns the column/variable
# names of the "wine_revs" object:

colnames(wine_revs)

# the variable names include:

# "X"                     "country"               "description"          
# "designation"           "points"                "price"                
# "province"              "region_1"              "region_2"             
# "taster_name"           "taster_twitter_handle" "title"                
# "variety"               "winery" 

# Question 11. Write code to load all observations from the
# "price" column/variable of the "wine_revs" object into
# a vector called "wine_prices":

wine_prices = c(wine_revs$price)

# indexes the data frame, finding the price column and assigns it to
# the vector wine_prices 

# Question 12. Subset the "wine_revs" object to create a new 
# data.frame named "wine_revs_truncated" that contains all 
# observations for only the numeric ID, Points, Price, Variety, 
# and Winery columns/variables in "wine_revs": 

wine_revs_truncated = data.frame(wine_revs$X,wine_revs$points,wine_revs$price, wine_revs$variety, wine_revs$winery)

# creates a smaller date frame containing only some of the columns
# by indexing by the sought out for variables 

# Question 13. Save the "wine_revs_truncated" that you created 
# in Question 12 to your course working directory 
# as an RDS file named "wine_revs_truncated.rds":

saveRDS(wine_revs_truncated, file = "wine_revs_truncated.rds")

# saves our new shortened data frame wine_revs_truncated into a file called
# "wine_revs_truncated.rds"

# Question 14. Below is an R function that receives a single 
# argument (an integer) and returns the square root of that
# argument.  Write code (below the function) that calls the 
# function sending it the value 144 as its argument and assigns
# the returned result to a variable "z".  Note:  Be sure to run
# code of the function to load it into your environment before
# you try to call it in your answer or you won't be able to test
# your answer.

getSqrt <- function(argument_1) {
  retval <- sqrt(argument_1) 
  return(retval)
}

z = getSqrt(144) # returns 12


# Question 15. Write code that you would use to install the "fortunes"
# package onto your local machine and then load it into the working
# R environment:

install.packages("fortunes")
library(fortunes)

# Question 16. Why doesn't R automatically load every installed package when 
# it starts: [Text Answer]

# If R were to load every package when it start it would slow the process
# of starting program each session and take up unnecessary memory when the 
# package may not even be needed for that session


# Question 17. What command(s) create a repository and put that
# directory under git control:

# git init 'name of repository'
# git sees if that directory exist, if it doesn't it creates a new repository


# Question 18. List an advantage and a disadvantage for each of the
# following data file formats: [Text Answer]
#   
#     a. RDS files
# RDS files 'remember' the data structures that they were assigned, and know
# which objects were factors, list, etc. However this same advantage makes them
# specific to R and makes it more difficult to share to other programming languages

#
#     b. CSV files
# CSV are text file that record tabular data with commas separating the columns
# making the text readable and easily moved between different programs (ie. excel to R)
# However data classes aren't preserved (numeric vs character) and data structures (
# list or factors)


# Question 19. Discuss what statisticians mean when they talk about
# finding the "center" of a data set: [Text Answer]

# The "center" of the data can be summarized a few ways. Mode is the data value
# that occurs most often within a data set. Mean, is an average, or a summation 
# of all the values in the set of data, divide by the number of values. Median
# is calculated by sorting the data from least to greatest and find the middle
# value.


# Question 20.  Explore the "wine_revs" data object that you created in 
# Question 8 above and calculate some summary statistics. Include in your 
# answer the code that you used to generate the statistics and outputs,
# a text explanation of the statistics you generated, and an interpretation
# of what those statistics mean.
#
# [Code Answer]
str(wine_revs)
summary(wine_revs)

library(ggplot2)
ggplot(wine_revs) + 
  aes(x=price, y=points) +
  geom_point(alpha = 0.2)

mean(wine_revs$price, na.rm = TRUE)
sd(wine_revs$price, na.rm = TRUE)

# [Text Answer]
# the str function returns the class of each column and the first few 
# values of the column 

# the summary function returns the number of observations and statistics 
# that related to the median ie. the range, 1st/3rd quartile, and median 
# if the column is numeric 

# plotted the points a wine received against the price of the wine. Looking at the plot
# there does seem to be a correlation between the price and the points, The more expessive the 
# the more likely it is to be rated higher on average.

# A bottle of wine on average was $35.36 and we can expect any bottle we choose to vary
# to be $41.02 dollars away from this mean on average.


# Directions:

# This file contains homework questions for the lecture on data forensics
# and statistics. Questions appear as comments in the file. 

# The first four questions are narrative only, meaning you can just write an
# answer and do not need to write computer code. For other questions, please 
# see the Grading Criteria Canvas Page for specific guidance on what
# we expect from you regarding assignment responses.

# Once you have completed the assignment, follow the Submission Instructions 
# on Canvas Pages section to add, commit, and push this to your GitHub repository. 

# Some questions have multiple parts - make sure to read carefully and
# answer all of them. The majority of points lost in homework come from
# careless skipping over question parts.  

###############################################################################

library("lubridate")

# 1. What is Deviation a measure of? [comprehension]

# How far an observed value is from the mean of the sample.


# 2. What is Standard Deviation? [comprehension]

# On average how far is a data point away from the mean. If the normally
# distributed 68% of the data will fall within one st dev, 95% is within 2 st
# dev, and 99.7% of the with be within 3 st dev.


# 3. Load the Craigslist data and then compute:

cl = read.csv('data/cl_rentals.csv')

#     a. The number of rows and columns. [code completion + comprehension]
dim(cl)
# the function returns the number of rows and columns, being 2987 and 20 respectively 

#     b. The names of the columns. [code completion + comprehension]
colnames(cl)
# returns a vector containing all the names of the columns:
# "title"        "text"         "latitude"     "longitude"    "city"        
# "date_posted"  "date_updated" "price"        "deleted"      "sqft"        
# "bedrooms"     "bathrooms"    "pets"         "laundry"      "parking"     
# "craigslist"   "shp_place"    "shp_city"     "shp_state"    "shp_county" 

#     c. A structural summary of the data. [code completion + comprehension]
str(cl)
# returns the class of each column and the first few values of the column 

#     d. A statistical summary of the data. [code completion + comprehension]
summary(cl)
#returns the number of observations and statistics that related to the median
# ie. the range, 1st/3rd quartile, and median if the column is numeric 

# 4. The goal of this exercise is to compute the number of missing values in
#    every column of the Craigslist data.
#
#    a. Write a function called `count_na` that accepts a vector as input and
#       returns the number of missing values in the vector. Confirm that your
#       function works by testing it on a few vectors. 
#.      [code completion + comprehension]
count_na <- function(x){
  sum(is.na(x))
}
count_na(cl$longitude)
count_na(cl$sqft)
count_na(cl$shp_city)
# function adds together the number of NA values in certain columns 

#    b. Test your function on the `pets` column from the Craigslist data. The
#       result should be 14. If you get an error or a different result, try
#       part a again.
#       [code completion + comprehension]
count_na(cl$pets)
# does return the result of 14

#    c. Use an apply function to apply your function to all of the columns in
#       the Craigslist data set. Include the result in your answer.
#       [code completion + comprehension]
apply(cl, MARGIN = 2, count_na)
# title         text     latitude    longitude         city  date_posted 
# 0            0            3            3          952            0 
# date_updated        price      deleted         sqft     bedrooms    bathrooms 
# 1801           35            0          347           10           10 
# pets      laundry      parking   craigslist    shp_place     shp_city 
# 14            0            0            0           24          650 
# shp_state   shp_county 
# 3            3 
# applies the count_na function across the columns in the data frame

#    d. Which columns have 0 missing values? [comprehension]
# text, date_posted, deleted, laundry, parking, craigslist


# 5. What time period does this data cover? Hint: convert the `date_posted`
#    column to an appropriate data type, then use the `range` function.
#    [code completion + comprehension]
cl$date_posted = ymd_hms(cl$date_posted)
range(cl$date_posted)

# changes the class of the date_posted column from character, therefore 
# the dates are able to be sorted and we can see that the dates range from 
# January 30, 2012 to March 4, 2021

# 6. Compute the mean price for each pets category. Based on the means, are
#    apartments that allow pets typically more expensive? Explain, being
#    careful to point out any subtleties in the result.
#    [code completion + comprehension + interpretation]
unique(cl$pets)
table(cl$pets)

pet_both = cl[cl$pets == "both", "price"]
mean_both = mean(pet_both, na.rm = TRUE)
mean_both # 1771.407

pet_cats = cl[cl$pets == "cats", "price"]
mean_cats = mean(pet_cats, na.rm = TRUE)
mean_cats #  1531.63

pet_dogs = cl[cl$pets == "dogs", "price"]
mean_dogs = mean(pet_dogs, na.rm = TRUE)
mean_dogs # 1828.742

pet_none = cl[cl$pets == "none", "price"]
mean_none = mean(pet_none, na.rm = TRUE)
mean_none #1740.128

# The mean for apartments that allow for both or neither pet are close in price
# the price point for apt that only allow for dogs tend to be the most expensive,
# which the ones that only allow for cats are the less expensive. Given this 
# information there does not seem to be a correlation between an apt's
# policy on pets and it's price.

# 7. The `sort` function sorts the elements of a vector. For instance, try
#    running this code:
#
#    x = c(4, 5, 1)
#    sort(x)
#    
#    Another way to sort vectors is by using the `order` function. The order
#    function returns the indices for the sorted values rather than the values
#    themselves:
#
#    x = c(4, 5, 1)
#    order(x)
#
#    These can be used to sort the vector by subsetting:
#
#    x[order(x)]
#    
#    The key advantage of `order` over `sort` is that it can also be used to
#    sort one vector based on another, as long as the two vectors have the same
#    length.
#    
#    Create two vectors with the same length, and use one to sort the elements
#    of the other. Explain how it (should) work.
#    [code completion + comprehension]

x = c(4,1,9,8)
y = c(0,2,4,3)
y[order(x)]
# output: 2 0 3 4
# the values in the factor y are being printed in order by the sorted values of x

# 8. Use the `order` function to sort the rows of the Craigslist data set
#     based on the `sqft` column. [code completion + comprehension]
sorted_sqft = cl[order(cl$sqft, na.last = FALSE),]
# retrieved the sorted the sqft column by indexing the cl data frame, needed to put
# na values first since ran into a bug when first running the code, 'largest' 5 values were random 
# na values. 

#     a. Compute a data frame that contains the city, square footage, and price
#        for the 5 largest apartments. [code completion + comprehension]
large_5 = sorted_sqft[2982:2987, c("city","sqft","price")]
print(large_5)
# got the largest five apts by indexing the last 5 values in the sorted list, and got the 
# city, square footage, and price of each.

#               city  sqft price
# 1866 Sacramento , CA  1998  2000
# 1210       Roseville  2282  2600
# 1065          Folsom  2296  3500
# 922   Rancho Cordova  2500  4000
# 1261    Roseville CA  8190  1995
# 2461      SACRAMENTO 88900  1370

#     b. Do you think any of the 5 square footage values are outliers? Explain
#        your reasoning. [interpretation]
# The apt in Roseville that is 8190 sqft is likely an outlier since is ~4 times as
# large as the next largest apt, meaning that it is multiple standard deviations 
# away from the mean value. 

#     c. Do you think any of the 5 square footage values are erroneous
#        (incorrect in the data)? [interpretation]
# I believe that the apt that is 88900 is likely a erroneous values as it ten times
# greater than the next largest values, an extra zero may have been added in the data entry
# making its' square footage so large.


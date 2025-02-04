# Directions:

# This file contains homework questions for the lecture on working with files
# and data exploration. Questions appear as comments in the file. 

# Please see the Grading Criteria Canvas Page for specific guidance on what
# we expect from you regarding assignment responses.

# Once you have completed the assignment, follow the Submission Instructions 
# on Canvas Pages section to add, commit, and push this to your GitHub repository. 

# Some questions have multiple parts - make sure to read carefully and
# answer all of them. The majority of points lost in homework come from
# careless skipping over question parts.  

###############################################################################

# 1. Write out the file extension and explain what it means for the following
#    files: [comprehension]
#
#       a. `myscript.py`
#       The .py  extension indicates that the file is a python script 

#       b. `/home/arthur/images/selfie.jpg`
#       An absolute path that begins at the the root directory that 'walks' 
# through the file system and directs towards an JPEG image file 

#       c. `~/Documents/data.csv`
#.      A relative path that begins at the home directory (as denoted by the 
# tilde) and opens a comma-seperated vaules text file 


# 2. Which command line utility can be used to determine the type of a file? 
# [code completion]
# file [file name]

# 3. Why is it a bad idea to explicitly call the `setwd` function within an R
#    script? [comprehension]
# It makes it more difficult to share code as a different person would have
# a different user/home directory and various naming conventions for their files 

# 4. List one advantage and one disadvantage for each of these formats:
# [comprehension]
#   
#     a. RDS files
#     RDS files 'remember' the data structures that they were assigned, and know
# which objects were factors, list, etc. However this same advantage makes them
# specific to R and makes it more difficult to share to other programming languages

#     b. CSV files
#     CSV are text file that record tabular data with commas separating the columns
# making the text readable and easily moved between different programs (ie. excel to R)
# However data classes aren't preserved (numeric vs character) and data structures (
# list or factors)

# 5. Why doesn't R automatically load every installed package when it starts?
# [comprehension]
# If R were to load every package when it start it would slow the process of starting 
# program each session and take up unnecessary memory when the package may not even
# be needed for that session. 

# 6. Load the dogs data from the `dogs.rds` file provided in lecture.
dogs <- readRDS("~/sts115_denapham/data/dogs.rds")
summary(dogs)

#     a. How many missing values are in the `height` column? 
#       [code completion + comprehension]
num_missing_height = sum(is.na(dogs$height)) #added together the number of NA values by 
# indexing the height column
num_missing_height # there are 13 missing values in the height column 
#
#     b. Think of a strategy to check the number of missing values in every
#        column using no more than 3 lines of code. Hint: think about last
#        week's lecture. Explain your strategy in words. 
#       [code completion + comprehension]
is_there_missing = function(df){
  colSums(is.na(df))
} 
#by creating a function we can check the number of missing values in each column without
# repeating the same lines of code multiple times (used colSums to find the sum of each column
# rather than of the whole data frame, found help on 'geeksforgeeks' site)
#
#     c. Which column has the most missing values? Try to solve this by
#        implementing your strategy from part b. If that doesn't work, you can
#        use the `summary` function to get the number of missing values in each
#        column as well as a lot of other information (we'll discuss this
#        function more next week).
#       [code completion + comprehension]
is_there_missing = function(df){
  colSums(is.na(df))
}

is_there_missing(dogs) # plugged in the dogs data frame and results printed that weight had the most
# missing data with 86 NA values 

# 7. Use indexing to get the subset of the dogs data which only contains large
#    dogs that are good with kids (the category `high` in the `kids` column
#    means good with kids). [code completion + comprehension]
results = dogs[dogs$size == "large" & dogs$kids == "high",]

# results are assigned to the condition of being both large and good with kids (using the logical
# comparison of and, &, meaning both condition need to be met)

# 8. With the dogs data:
#
#     a. Write the condition to test which dogs need daily grooming (the result
#        should be a logical vector). Does it contain missing values? 
#       [code completion + comprehension]
daily_groom = dogs$grooming == "daily"
class(daily_groom)
daily_groom
# created a condition to see which dogs need daily grooming, those who do are assigned 
# TRUE it does contain missing NA values 

#     b. Use the condition from part a to get the subset of all rows containing
#        dogs that need daily grooming. How many rows are there?
#       [code completion + comprehension]
num_groom = nrow(dogs[daily_groom,])
num_groom # there are 83 rows
# added the number of rows that met the indexing condition of containing daily grooming

#     c. Use the `table` function to compute the number of dogs in each
#        grooming category. You should see a different count than in part b for
#        daily grooming. What do you think is the reason for this difference?
#       [code completion + interpretation]
table(dogs$grooming)
# Using the table function we can see that there are 23 dogs that need daily grooming
# I think this is different from the result I got in part B since the NA values may have
# also been counted.

#     d. Enclose the condition from part a in a call to the `which` function,
#        and then use it to get the subset of all rows containing dogs that
#        need daily grooming. Now how many rows are there? Does the number of
#        rows agree with the count in part c?
#       [code completion + comprehension]
daily_groom2 = which(dogs$grooming == "daily")
num_groom2 = nrow(dogs[daily_groom2,])
num_groom2
?which
# Since the 'which' function returns the true indices of a logical object the number
# of rows now equal 23 and agree with the count from part C
# 
# 9. Compute a table that shows the number of dogs in each grooming category
#    versus size. Does it seem like size is related to how often dogs need to
#    be groomed? Explain your reasoning. [code completion + interpretation]
table(dogs$size, dogs$grooming)
# It doesn't seem like the size of dog is related to how often it needs to be groomed
# around ~30 dogs from each size need to be groomed weekly, however slightly more small dogs 
# need to be groomed daily

# 10. Compute the number of dogs in the `terrier` group in two different ways:
#
#     a. By making a table from the `group` column. 
#       [code completion + comprehension]
table(dogs$group)
# After displaying the table we can see that there are 28 terrier dogs

#     b. By getting a subset of only terriers and counting the rows.
#       [code completion + comprehension]
terrier_dogs = which(dogs$group == "terrier")
num_terrier = nrow(dogs[terrier_dogs,])
num_terrier
# Created a condition to find which rows in dogs group contains 'terrier', if this condition 
# was met, thus being TRUE the row was counted and thus returned a computation of 28 terriers 

#     c. Computing the table is simpler (in terms of code) and provides more
#        information. In spite of that, when would indexing (approach b) be more
#        useful? [comprehension + interpretation]

# Indexing in useful since we can 'extract' more data from its return and apply multiple conditions at once.
# For example we couldn't have found the dogs where were terrier, needed daily grooming, and 
# their food cost < $500. Also, indexing makes finding values like the mean and range easier since you can just 
# apply the function. Finally, it simpler to update the data by extraction so you can manipulate it by 
# applying mathematical operations or reassigning values.

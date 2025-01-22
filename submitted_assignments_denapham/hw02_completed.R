my_data <- read.csv("~/sts115_denapham/data/my_data.csv")

# 1. Interview 5 people from outside of STS115 and add their data to the “my_data” data
# frame from class to create a new data frame called “our_data”. You will use this for the
# subsequent questions. (Please do not interview someone who a classmate has already
# interviewed. You can call, Zoom, etc. but you need to actually talk to other human
# beings to complete this assignment!)

# created vectors contain my 5 friends' data and combined into a data frame named "dena_date" 
#combined this with the classes' data

response <- c("Food Science", "Neurobiology, Physiology and Behavior", "Sustainable Environmental Design", "Neurobiology, Physiology and Behavior", "Human Development")
major <- c("FST", "NPB", "SCD", "NPB", "HDE")
study <- c("Mon Davi", "Dorm Study Room", "Hunt Hall Court Yard", "Bridge by Olson Hall", "MU") 
location <- c("Ali Baba","Canes","Open Rice Kitchen", "Mishkas", "Thai Canteen")
pet <- c("Woof", "Woof","Cats rule, dogs drool","Cats rule, dogs drool","Cats rule, dogs drool")
distance.mi <- c(1.5,.2,3,2,1.5)
time.min <- c(10,1,15,30,10)

dena_data <- data.frame(response, major, study, location, pet, distance.mi, time.min)

our_data <- rbind(my_data, dena_data)


# 2. Come up with a yes/no or true/false question you’d have liked the survey to have
# asked. Make up these data for every subject in the survey, then create it as a logical
# vector and add it to the data frame.

# questions is does the student own a car, found command to create random logical vector on stack
# overflow

car.own <- sample(x = c("TRUE","FALSE"), size = 71, replace = TRUE)

our_data$car.own <-car.own

# 3. Use a single function to return the class of each column in the data frame.

# use lapply command to find the class of every column
lapply(our_data,class)

# 4. Look up how to use the function `max`. Use it to calculate the longest commute
# distance and travel time.

# found the index of max value in each column and then found its' value
which.max(our_data$distance.mi)
which.max(our_data$time.min)

our_data$distance.mi[57]

our_data$time.min[70]

# 5. Calculate travel speed across subjects as miles per minute. Assign this to a new
# vector `mi.per.min` and add it to the data frame.

# created vector that calc travel speed, added it to the data frame

mi.per.min <- (our_data$distance.mi/our_data$time.min)

our_data$mi.per.min <- mi.per.min

# 6. Use a function to return the total number of elements in mi.per.min.

length(mi.per.min) #returns num of elements in the vector

# 7. Index/subset the vector `major` to get a new vector that contains the 3rd, 1st, and
# 9th elements (in that order).

# created new vector with the correct elements in a certain order

major_2 <- c(our_data$major[3],our_data$major[1],our_data$major[3])

# 8. R’s `[` indexing operator accepts several different types of indexes, not only positive
# whole numbers. For example, the operator accepts negative numbers as indexes. Using
# the vector `places`, try out three to five different negative indexes. Based on the results,
# what do you think the [ operator does with negative indexes?
our_data$location[-4]
our_data$location[-1]
our_data$location[-2]

# i think by using a neg num as the index you're removing that data point (the data only return 70 element
# in that vector)

# 9. Consider the R code `c(3, 3.1, “4”, -1, TRUE)`.
# a. WITHOUT running the code, what data type you think the result will have and why?
# i think it will return a list since there are many different data types

# b. Now run the code to check whether your guess was correct. If it was not
# correct, explain what the actual data type is and why. If your guess was correct, write a
# new, different line of code that yields the same resulting data type.
example <- c(3, 3.1, "4", -1, TRUE)

class(example)
# I guess was incorrect the class of the vector was character the numeric vaules became converted into text strings
# 10. Run the code `“four” < “five”`. Paste the output from R into a comment and explain
# why you think it provided that result.

# FALSE was the output, this result could have been the result since the each character in the alphabet get a value assigned to it
# so the program is comparing each character in the string. i comes before o in the alphabet which means it is less than 
# making the boolean false

# 11. There are several major mistakes in the data entered in class.
# a. Describe in complete sentences what at least 2 of the errors are. Make some
# guesses as to how those errors may have happened, and how they might affect
# analyses and/or re-use of these data.

# Some of the responses entered for the students' major did not match with with their 3 letter code/did not 
# account for their double majors. Case (upper/lower) also varied between people's responses so if we want to, for example,
# see how many people preferred study location was the library we would need to clean up the data before
# doing our analysis.

# b. Pretend the data frame was too big for you to view it manually. List specific
# function calls you could use in R to help you find these mistakes programmatically.

# class() type() head() tail() str() table() tolower() toupper()

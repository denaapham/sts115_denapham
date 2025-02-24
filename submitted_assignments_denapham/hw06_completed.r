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


# 1. All of the questions in this homework use the Best in Show data set. 
#      The data is the file `dogs.rds`.
#   a. Load the data set and use R functions to inspect the number of 
#      columns, number of rows, names of columns, and column data types.
#      [code completion + comprehension]

dogs <- readRDS("~/sts115_denapham/data/dogs.rds")
# loading the file and assigned it to the name dogs
head(dogs)
dim(dogs)
# there are 172 rows and 18 columns 
colnames(dogs)
# column names include 
# [1] "breed"             "group"             "datadog"           "popularity_all"    "popularity"        "lifetime_cost"    
# [7] "intelligence_rank" "longevity"         "ailments"          "price"             "food_cost"         "grooming"         
# [13] "kids"              "megarank_kids"     "megarank"          "size"              "weight"            "height"  
str(dogs)
sapply(dogs, class)
#applies the class function across the data frame and returns:
# breed             group           datadog    popularity_all        popularity 
# "character"          "factor"         "numeric"         "integer"         "integer" 
# lifetime_cost intelligence_rank         longevity          ailments             price 
# "numeric"         "integer"         "numeric"         "integer"         "numeric" 
# food_cost          grooming              kids     megarank_kids          megarank 
# "numeric"          "factor"          "factor"         "integer"         "integer" 
# size            weight            height 
# "factor"         "numeric"         "numeric"

#   b. Make a scatter plot that shows the relationship between height and
#      weight. In 2-3 sentences, discuss any patterns you see in the plot.
#      [code completion + comprehension + interpretation]

library(ggplot2) # loaded in the plotting package 
ggplot(dogs) +
  aes(x=height, y = weight)+
  geom_point()
# created a dot plot with height as the x-values and weight as the y-values
# There a positive correlation between height and weight. The taller the dogs the most likely they are to be heavier.

#   c. Set the color of the points in the scatter plot from part b to a single 
#      color of your choosing. (Tip: Choose a color from one of the sites 
#      shared in the lesson (e.g. https://coolors.co/palettes/trending))
#      [code completion + comprehension]

ggplot(dogs) +
  aes(x=height, y = weight)+
  geom_point(color = "#219ebc") 
# changed the colors of points to a teal

# 2.
#   a. Make a bar plot that shows the number of dogs in each "group" of dogs.
#      [code completion + comprehension]
unique(dogs$group)
# there are 7 levels in the factor of group
ggplot(dogs) +
  aes(x = group) + # x axis shows the levels of the group
  geom_bar(stat = "count") # creates a bar graph with the y axis being the count of each kind of dog

#   b. Are any groups much larger or smaller than the others? Describe what your 
#       visualization shows.
#      [interpretation]
# The groups of dogs are not drastically different. From the graph we can see that there are between 15 and 20 
# non-sporting and toy dog breeds, while there are at least 25 or more of the other dog groups.

#   c. Fill in the bars based on the size of the dog, and set the position 
#       argument of the bar geometry to the one you think best communicates the 
#       data. Explain why you chose this position.
#      [code completion + comprehension + interpretation]
ggplot(dogs) +
  aes(x = group, fill = size) + # fill bars based on size
  geom_bar(stat = "count", position = 'dodge')
# positioned the bar side by side rather that stacked since it makes comparing the 
# number of each size of dog easier, making the graph more readable 

# 3.
#   a. Which geometry function makes a histogram? Use the ggplot2 website or
#      cheat sheet to find out.
#      [code completion + comprehension]
ggplot() +
  aes() +
  geom_histogram() # this function creates a histogram

#   b. Make a histogram of longevity for the dogs data. How long do most dogs
#      typically live? Explain in 1-2 sentences.
#      [code completion + comprehension + interpretation]
ggplot(dogs) +
  aes(x=longevity) + # x-axis is the life span of the dog
  geom_histogram()
# Most dogs in this sample tend to live 9-12.5 years, since by look at the graph
# mos of the data is 'piled' around these values.

#   c. Inside the geometry function for histograms, play around with the bins
#      argument. (e.g. bins = 10, bins = 50). What do you think this is doing?
#      [code completion + comprehension]
ggplot(dogs) +
  aes(x=longevity) + 
  geom_histogram(bins = 10)
ggplot(dogs) +
  aes(x=longevity) + 
  geom_histogram(bins = 50)
# I think that bin width is determining the size of the interval on the 
# x-axis, thus by changing the amount of data that is group together.

# 4.
#   a. Modify your plot from Question 1 so that the shape of the points is
#      determined by the "group" of the dog. [code completion + comprehension]
ggplot(dogs) +
  aes(x=height, y = weight, shape = group)+ # shape of the point is determined by group
  scale_shape_manual(values=1:nlevels(dogs$group)) + # manually specify shapes as working dogs were coming up as blank
  geom_point()

#   b. Do height and weight effectively separate the different groups of dogs?
#      In other words, are there clear boundaries between the groups in the
#      plot (as opposed to being mixed together)? Are some groups better
#      separated than others?
#      [interpretation]
# There are not completely clear boundaries between group of dog and their sizes but some trends do emerge.
# Some clear example are toy and working dogs they are strongly correlated with being smaller and larger, 
# respectively. However, some groups of dogs tend to be more spread out, meaning they are more likely to vary in size,
# sporting dogs tend to follow this pattern.

#   c. How might you improve the readability of this graph in order to visualize
#      this potential relationship more clearly?
#      [interpretation]
# You could change the color of the groups or make some points larger to make the graph more readable,
# as to enable more clear interpretation of the relationship between the group and weight/height of the dogs.

# 5. In a paragraph, answer the following questions for the “Best in Show” 
#    visualization (https://informationisbeautiful.net/visualizations/best-in-show-whats-the-top-data-dog/) 
#    that was built using the dogs dataset.
#    a. Who do you think is the intended audience for this data visualization? 
#        How do you think that could influence data collection, metrics calculations, 
#        and graphics choices?
#       [interpretation]
#' From Looking at the graph I would assume that it is intended for those who are looking for 
#' a new pet. Knowing this is the target audience it would impacted the sort of variables 
#' are deemed to be important, going off the assumption that were looking for a dog for a typical 
#' American family the data would be judge based off what is affordable for the typical household, 
#' how regularly would they be willing to groom the dog, and what their likelihood of getting sick.
#' The graphic are visually pleasing and the quadrants makes it simple to scan over multiple 
#' dog breeds -- quickly visualizing a large amount of information.
#' 
#    b. Who/what is included in this data visualization and who is left out? 
#        What do you think the impact of that decision could be on conclusions drawn
#        from viewers of the data visualization? 
#       [interpretation]
# Some more specific attributes of dogs qualities are left out in their data score. For example,
# are is the dog breed good with kids or the energy level of the dog(how often will they need to 
# be walked). Also, the graph makes the assumption that those looking for a dog is look at purebread
# dogs. This may impact the viewer impression of mix-breed dogs, leading them to look for breeders
# rather than adopting.

#    c. What could the potential impact of this visualization be on those 
#       who are left-out? [interpretation]
# There may be lower adoption rates of mixed breed dogs, which is especially impactful as many dogs in
# shelter are mixed, also people may judge the dog purely based on the breed rather than the 
# individual temperament of the dog.


# 6. Select your favorite data visualization from https://viz.wtf/ 
# (that was not featured during class or in the reader). 
#   a. Type the direct url to the viz you selected here: https://viz.wtf/post/662596946453839872/linear-time-is-an-illusion-your-weeks-are-just#notes
#   b. Describe in a few sentences the "data story" you think that this visualization 
#       is trying to tell.
# I think this data visualization is trying to show a relationship between the number of weekly
# unemployment insurance claims and time in the state of Alabama.Perhaps with an emphasis on specific weeks
# with a large amount of insurance claims since they are positioned on the outside ring of the graph.

#   c. In a paragraph, what makes this a "bad" visualization? Evaluate the visualization 
#       based on the visualization principles and perception rules discussed in class 
#       (i.e., Gestalt principles, plot type, accessibility, critical reading, etc.), 
#       and suggest a few changes to improve the graphic.
# This is a bad graph since by Gestalt principle we know that humans aren't as well suited
# to comparing area, in this case sizes of circles. Also, there are also many different
# colors that are not distinct from each other in value that would make it mores difficult for
# a person with color blindness to interpret the graph. Perhaps the most glaring issue is the 
# use of a bubble chart for displaying change over time, it would be more clear to display 
# time linearly through the use of a line graph or histogram. 

#   d. Describe in 1-2 sentences one thing that this visualization actually already does well.

# The graph is label making it clear the relationship of the variables, and dates are write and 
# recorded in a consistent format. 

# 7. Look at the plot posted with this assignment on Canvas.
#    a. Identify the marks and channels in this plot. Write them out for this answer
# The marks of this graph are the points representing the lifetime cost and longevity 
# of the dog. Channels include the shape and color of each point that represent the group
# the dog.
#    b. Write the code to generate this plot. (Hint: start with identifying the 
#        variables on each axis, then think about the types of channels).
ggplot(dogs) +
  aes(x=longevity, y = lifetime_cost, shape = group, color = group)+ # plot lifetime cost by longevity and make each group a different shape/color
  geom_point() +
  labs(title = "Dogs", x = "Longevity (years)") # title the plot

#    c. Propose 4 improvements to the plot based on best practices.
# Use a color palette that is accessible. Rename the title to be more clear.
# Write units for the y-axis. Add jitters in case point are overlapping.

#    d. Modify the code to implement at least two of those changes.
ggplot(dogs) +
  aes(x=longevity, y = lifetime_cost, shape = group, color = group)+ # plot lifetime cost by longevity and make each group a different shape/color
  scale_shape_manual(values=1:nlevels(dogs$group)) + 
  geom_point() +
  scale_color_manual(values = c("#88CCEE", "#44AA99","#117733","#999933","#DDCC77", "#CC6677","#AA4499")) +
  labs(title = "Dogs' Longevity vs Lifetime Cost", x = "Longevity (years)", y = "Lifetime Costs ($)")


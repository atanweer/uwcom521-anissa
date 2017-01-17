# PC3
#Load the CSV file into R. Also make sure that you loaded the week 2 dataset file.
library(ggplot2)

# Find the dataset in my homework directory
setwd("/Users/anissa/Github/uwcom521-anissa")
list.files()
read.csv("week3_dataset-anissa.csv")
# Load the dataset into a variable called "wk.3.ds"
wk.3.ds <- read.csv("week3_dataset-anissa.csv")
# Also load the Week 2 dataset into a variable called "wk.3.ds"
load("~/Github/uwcom521-anissa/week_02_dataset-anissa.RData")

#PC4
#Get to know your data! Do whatever is necessary to summarize the new dataset. 
#Now many columns and rows are there? What are the appropriate summary statistics 
#to report for each variable? What are the ranges, minimums, maximums, means, 
#medians, standard deviations of the variables of variables? 
#Draw histograms for all of the variables to get a sense of what it looks like. 
#Save code to do all of these things.

#Find the number of columns and rows
nrow(wk.3.ds)
ncol(wk.3.ds)

#At first glance:
#x & y seem to be continuous numerical variables, so
#mean, median, mode, standard deviation, etc are appropriate summary statistics
#j & i are binary (only values are 0 & 1), so I would imagine they are yes and no
#k seems to be a categorical variable, given that all the answers are integers 0-3

#Get summary statistics (range, min, max, mean, median) for all

summary(wk.3.ds)

#Do histograms of each variable
hist(wk.3.ds$x)
hist(wk.3.ds$y)
hist(wk.3.ds$j)
hist(wk.3.ds$i)
hist(wk.3.ds$k)

#because j & i are binary (just one or zero, which I suspect represents yes and no)
#it doesn't make sense to report mean, median, mode, etc. for these. 
#instead, a frequency table would make sense

table(wk.3.ds$j)
table(wk.3.ds$i)

#same for k

table(wk.3.ds$k)


#PC5
#PC5. Compare the week2.dataset vector with the first column (x) of the data frame. 
#I mentioned in the video lecture that they are similar? Do you agree? How similar? 
#Write R code to demonstrate or support this answer convincingly.

summary(week2.dataset)
summary(wk.3.ds$x)
#Can see that the summary statistics are identical, which leads me to believe that
#the vectors are identical. But just to be sure ...

#First sort the two columns I want to compare
#Then make a new dataframe by combining the Week 2 vector and the x column of Week 3
#Then subtract the corresponding values from each column
#Check to see how many of them are not zero.
#If the answer is none, then the columns are identical

#Sort week2.dataset
sorted.wk2.ds <- sort(week2.dataset)
#Sort x column of wk.3.ds
sorted.wk3.ds <- sort(wk.3.ds$x)
#make a new vector by subtracting subtract each value from one another


#Make a new dataframe out of the newly sorted columns
#Pass it into a new variable called "comparison.df"
comparison.df <- cbind(sorted.wk2.ds,sorted.wk3.ds)

comparison.df

#Subtract each value in one column from the corresponding value in the other.
#Pass it into a new vector
wk2.minus.wk3 <- sorted.wk2.ds - sorted.wk3.ds

#Bind the new vector to the data frame so the difference can be viewed side by side

cbind(comparison.df, wk2.minus.wk3)

comparison.df

#Many of the numbers are off by teeny tiny numbers, indicating that the computer
#probably rounded some of the numbers differently. The numbers are so small that
#they are practically zero.


#PC6 
#Visualize the data using ggplot2 and the geom_point() function. 
#Graphing the x on the x-axis and y on the y-axis seem pretty reasonable! 
#If only it were always so easy! 
#Graph i, j, and k on other dimensions (e.g., color, shape, and size seems reasonable). 
#Did you run into any trouble? How would you work around this?

#First just get the x & y plotted
ggplot(data = wk.3.ds) + geom_point() + aes(x=x, y=y)

#Then add color to plot variable k; makes sense b/c this is a continuous variable. 

ggplot(data = wk.3.ds) + geom_point() + aes(x=x, y=y, color =k)

#i and j are binary, so I'm going to try to do shapes and something else for those
#Get an error when I use shape, though, b/c a continuous variable can't be mapped
#to a shape.
#So first I'm going to make i & j factors

as.factor(wk.3.ds$j)
as.factor(wk.3.ds$i)
as.factor(wk.3.ds$k)

#Then check the class just to make sure
class(as.factor(wk.3.ds$j))
class(as.factor(wk.3.ds$i))
#But this doesn't actually change those columns in the dataframe, so I would
#probably actually want to go back and make that change earlier in the code.
#Otherwise, I have to do "as.factor" when writing the line to plot. 

#That works, so plot "j" as shape
ggplot(data = wk.3.ds) + geom_point() + aes(x=x, y=y, color =as.factor(k), 
shape=as.factor(j))

#I'm running out of aesthetics I know that would be good for binary factors, 
#but I suppose I'll try "size"

ggplot(data = wk.3.ds) + geom_point() + aes(x=x, y=y, color=as.factor(k), 
shape=as.factor(j), size=as.factor(i))

#I get a warning that using size for a discrete variable isn't advised, but
#I don't know what else to do. Hollow versus filled, perhaps? 

ggplot(data = wk.3.ds) + geom_point() + aes(x=x, y=y, color=as.factor(k), 
                                            shape=as.factor(j), fill=as.factor(i))

#I thought this would make the 0's filled and the 1's not filled (or vice versa)
#but it doesn't. I can't figure out how to do that (looked for a while)


#PC7
#A very common step when you import and prepare for data analysis 
#is going to be cleaning and coding data. Some of that is needed here. 
#As is very common, i, j are really dichotomous "true/false" variables 
#but they are coded as 0 and 1 in this dataset. 
#Recode these columns as logical. 
#The variable k is really a categorical variable. 
#Recode this as a factor and change the numbers into textual "meaning" to make it easier.
#Here's the relevant piece of the codebook (i.e., mapping): 
#0=none, 1=some, 2=lots, 3=all. 
#The goals is to end up with a factor where those text strings are the levels 
#of the factor. I haven't shown you how to do exactly this but you can solve 
#this with things I have shown you. Or you can try to find a recipe online.

#Ok, so this time I'll actually pass the change back into the variables
#so that they're permanently like that, instead of just doing it on an ad hoc
#basis for mapping, like I did before when I treated them as a factor while plotting.

wk.3.ds$j <- wk.3.ds$j==1
wk.3.ds$i <-wk.3.ds$i==1

#Check that this turned out ok by printing the top of the dataframe
head(wk.3.ds)

#Now to tackle variable k.

#I think that first I need to make the numbers into a factor, so that I can replace
#them with other characters.
wk.3.ds$k <- as.factor(wk.3.ds$k)

#I found this solution online for re-assigning factors
library(plyr)
revalue(wk.3.ds$k, c("0"="NONE", "1"="SOME", "2"="LOTS", "3"="ALL"))
#Worked beautifully!

#Now I want to plot this again, just to see what happens. 

ggplot(data = wk.3.ds) + geom_point() + aes(x=x, y=y, color=k, 
                                            shape=j, fill=i)
#The fill aesthetic still seems pretty useless to me, but oh well. 


# PC8
#Take column i and set it equal to NA when if it is FALSE (i.e., 0). 
#Then set all the values that are NA back to 1. Sorry for the busy work! ;)

#Set FALSE values in column i to NA
#Found this piece of code on stack overflow:
#df[df == 0] <- NA
wk.3.ds$i[wk.3.ds$i == FALSE] <- NA
head(wk.3.ds)

#SET NA values in column i to 1 [I don't know why we would do this, now it will be mixed
#with characters and numbers. I think he meant to say that all the values that are NOT NA
#should be switched back to 1, which is what I'm going to do.]

wk.3.ds$i[wk.3.ds$i != NA] <- 1
head(wk.3.ds)


#PC9
#Now that you have recoded your data in PC7, generate new summaries 
#for those three variables. Also, go back and regenerate the visualizations. 
#How have these changed? How are these different from the summary detail you 
#presented above?

summary(wk.3.ds)
 
#The summary statistics for the other variables haven't changed.
#But now the summary statistics for variable i are pretty meaningless, because I've made
#it a numeric value again. 

#I don't think the plot should change that much, though, because I had mapped i with the
#fill aesthetic, which didn't really do anything. 

ggplot(data = wk.3.ds) + geom_point() + aes(x=x, y=y, color=k, 
                                            shape=j, fill=i)


#PC10
#As always, save your work for all of the questions above as an R script. 
#Commit that R script to your homework git repository and sync/push it to GitHub. 
#Verify that it is online on the GitHub website at the URL linked to from the 
#Statistics and Statistical Programming (Winter 2017)/List of student git repositories page.


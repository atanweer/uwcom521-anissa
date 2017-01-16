#Anissa's Week 2 Programming Challenges

load("~/Github/uwcom521-anissa/week_02_dataset-anissa.RData")

# PC3:
class(week2.dataset)
mean(week2.dataset)
median(week2.dataset)
var(week2.dataset)
sd(week2.dataset)
IQR(week2.dataset)

# PC4:

#MEAN
#find length of dataset
length(week2.dataset)
#find sum of dataset
sum(week2.dataset)
#compute the mean by deviding the sum by the length of the dataset
sum(week2.dataset)/length(week2.dataset)

#MEDIAN

#sort dataset
week2.dataset.sorted<-sort(week2.dataset)
#find length of dataset
length(week2.dataset.sorted)
#find the midpoint of the dataset
midpoint<-length(week2.dataset.sorted)/2
midpoint
#call the value that exists at the midpoint of the dataset
week2.dataset.sorted[midpoint]
#Note: This isn't actually the true median because there is an even number of
#entries in the dataset, so I should have averaged the 50th and 51st observations

#MODE
#sort dataset
week2.dataset.sorted<-sort(week2.dataset)
#find out how many times each value appears in the dataset
table(week2.dataset.sorted)
#all values appear only once, so we can do a histogram to see what segmented modes appear
hist(week2.dataset.sorted)
#Note: How Mako showed us to do this:
#week2.dataset.round <- round(week2.dataset)
#tail(sort(table(week2.dataset.round)))
#OR:
#max.count <- rev(sort(table(week2.dataset)))[1]
#could do that with the rounded dataset, but there usually aren't modes with
#continuous data
#OR: 
#table(week2.dataset.round)[table(week2.dataset.round) == max.count]
#saying give me each value in the table and tell me if each one is equal to max.count
#that way you get all the modes, not just the top one
#what the above is doing is creating a true-false vector, making a subset of the data
#going to be doing this over and over; using a vector to read into itself
#how to get only some of the lines of a data
#R's contribution to the world


#PC5:
#BOXPLOT
boxplot(week2.dataset)
#HISTOGRAM
hist(week2.dataset)
#DOTCHART
dotchart(week2.dataset)
#Note: How to do density plot:
#plot(density(week2.dataset))

#PC6:
#find all entries that are negative numbers in dataset
week2.dataset<0
#isolate all the entries that are negative numbers from the rest of the dataset
week2.dataset[week2.dataset<0]
#change the value of all the isolated entries that are negative numbers to "NA"
week2.dataset[week2.dataset<0] <- NA
#view the whole dataset with the negative values now changed to NA
week2.dataset
#view the sorted dataset to make sure all the non-NA entries are positive
sort(week2.dataset)
#generate a dataset that excludes the "NA" values
week2.dataset.pos <- sort(week2.dataset)
#print the dataset that excludes the "NA" values
#NOTE: THIS IS WHAT I WAS SUPPOSED TO DO: mean(week2.dataset, na.rm=TRUE)
#My sorting hack worked, but "mean(week2.dataset, na.rm=TRUE)" would have removed
#anything that's rm
week2.dataset.pos
#find the mean of the dataset that excludes the "NA" values
mean(week2.dataset.pos)
#this mean (56.56075) is larger than the mean that included negative values (37.31435)
#find the standard deviation of the dataset that excludes "NA" values
sd(week2.dataset.pos)
#this sd (38.22241) is smaller than the sd that included negative values (45.6457)


#PC7:
#log transform dataset (the new one that excludes negative numbers) and create new variable
week2.dataset.pos.log <- log(week2.dataset.pos)
#print the log transformed dataset
week2.dataset.pos.log
#create a boxplot of log tranformed data
boxplot(week2.dataset.pos.log)
#create a histogram of log transformed data
hist(week2.dataset.pos.log)
#calculate mean of log transformed data
mean(week2.dataset.pos.log)
#calculate median of log transformed data
median(week2.dataset.pos.log)
#calculate standard deviation of log transformed data
sd(week2.dataset.pos.log)





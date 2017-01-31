#PC0
#I've provided the full dataset from which I drew each of your samples in a TSV file 
#in the directory week_05 in class assignment git repository. These are tab delimited, not comma delimited. 
#TSV, is related to CSV and is also a common format. Go ahead and load it into R (HINT: read.delim()). 
#Take the mean of the variable x in that dataset. 
#That is the true population mean — the thing we have been creating estimates of in week 2 and week 3.

#First set the directory:
setwd("/Users/anissa/Github/uwcom521-anissa")

#Look for the file I'm supposed to import:
list.files("/Users/anissa/Github/uwcom521-anissa")

#Load the file into my environment as a new variable
population <- read.delim("com521_population.tsv")

#Look at the top of it
head(population)

#Take the mean of variable x (TRUE POPULATION MEAN)
mean(population$x)
# PC1. 
#Go back to the dataset I distributed for the week 3 problem set. 
#You've already computed the mean for this in week 2. 
#You should compute the 95% confidence interval for the variable x in two ways:
#(a) By hand using the normal formula for standard error 
#(b) Using the appropriate built-in R function. These number should be the same or very close. 
#After reading the OpenIntro, can you explain why they might not be exactly the same?
#(c) Compare the mean from your sample — and your confidence interval — to the true population mean. 
#Is the true mean inside your confidence interval?

#First, get my dataset loaded
load("week2_dataset-anissa.RData")
#note that it's changing the _character to a . and truncating -anissa.Rdata

#Look at to remind myself what it is
head(my.sample)
#Just a vector, that corresponds to x in the population, so I don't need to index into it

#Pass it into a new variable
my.sample <- week2.dataset

#Find the mean of my.sample
mean(my.sample)

#(a) compute the confidence interval by hand

my.conf.int <- mean(my.sample) + (1.96 * sd(my.sample) / sqrt(length(my.sample))) * c(-1, 1)
my.conf.int

#(b) find the confidence interval using an r function
t.test(my.sample)
#As to why they aren't they the same .... can't answer yet, haven't read OpenIntro

#(c) is the true population mean within the confidence interval of my.sample?
mean(my.sample) > my.conf.int[1] & mean(my.sample) < my.conf.int[2]
#YES, the true population mean is within the confidence interval of my sample mean

#PC2. 
#Let's look beyond the mean. 
#Compare the distribution from your sample of x to the true population. 
#Draw histograms and compute other descriptive and summary statistics. 
#What do you notice? Be ready to talk for a minute or two about the differences.

summary(population$x)
summary(my.sample)

hist((population$x))
hist((my.sample))

#The population has a much lower min. and a larger max (though the difference isn't quite as big)


#PC3. Compute the mean of y from the true population and then create the mean and confidence interval 
#from the y in your sample. Is it in or out?

#Oops, just realized I've been working from the week2 dataset instead of week3, which does
#actually have a y variable. So have to load that one up. 
#Pass it into a new variable (#This is going to get messy since I don't have x and y in the same variable)

week3.dataset <- read.csv("week3_dataset-anissa.csv")
head(week3.dataset)

my.sample.y <- week3.dataset$y

#Find the mean of my.sample
mean(my.sample.y)

#(a) compute the confidence interval by hand

my.conf.int.y <- mean(my.sample.y) + (1.96 * sd(my.sample.y) / sqrt(length(my.sample.y))) * c(-1, 1)
my.conf.int.y

#(b) find the confidence interval using an r function
t.test(my.sample.y)
#As to why they aren't they the same .... can't answer yet, haven't read OpenIntro

#(c) is the true population mean within the confidence interval of my.sample.y?
mean(my.sample.y) > my.conf.int.y[1] & mean(my.sample.y) < my.conf.int.y[2]
# TRUE, so yes, it's within the confidence interval




#PC4. I want you to run a simple simulation that demonstrates one of the most fundamental 
#insights of statistics:
#(a) Create a vector of 10,000 randomly generated numbers that are uniformly distributed between 0 and 9.
#(b) Take the mean of that vector. Draw a histogram.
#(c) Create 100 random samples of 2 items each from your randomly generated data and take the mean of each sample. 
#Create a new vector that contains those means. Describe/display the distribution of those means.
#(d) Do (c) except make the items 10 items in each sample instead of 2. Then do (c) again except with 100 items. 
#Be ready to describe how the histogram changes as the sample size increases. 
#(HINT: You'll make me very happy if you write a function to do this.)
            
#(a) First create the vector in a new variable then look take a look at the beginning
random.vector <- runif(n=10000, min=0, max=9)
head(random.vector)

#(b) Mean and histogram
mean(random.vector)
hist(random.vector)

#(c) 100 random samples of the 2 items from the random vector

find.sample.mean.2 <- function(i) {
  new.sample <- sample(random.vector, 2)
  mean(new.sample)
}

sample.means.2 <- sapply(rep(1, 100), find.sample.mean.2)

summary(sample.means.2)
hist(sample.means.2)

#(d) Repeat with 10 items 100 times

find.sample.mean.10 <- function(i) {
  new.sample <- sample(random.vector, 10)
  mean(new.sample)
}

sample.means.10 <- sapply(rep(1, 100), find.sample.mean.10)


# Repeat with 100 items 100 times

find.sample.mean.100 <- function(i) {
  new.sample <- sample(random.vector, 100)
  mean(new.sample)
}

sample.means.100 <- sapply(rep(1, 100), find.sample.mean.100)

#Compare the summary statistics and histograms of each of these sampling distributions

summary(sample.means.2)
summary(sample.means.10)
summary(sample.means.100)

hist(sample.means.2)
hist(sample.means.10)
hist(sample.means.100)

#It's not as distributed ... the min and max are much closer together. 


#PC5. Do PC4 again but with random data drawn from a normal distribution (mu = 42, sigma = 42)
#instead of a uniform distribution. How are you results different than in PC4?


#(a) First create the vector in a new variable then look take a look at the beginning
random.vector.2 <- rnorm(n=10000, mean=42, sd=42)
head(random.vector.2)

#(b) Mean and histogram
mean(random.vector.2)
hist(random.vector.2)

#(c) 100 random samples of the 2 items from the random vector

find.sample.mean.2 <- function(i) {
  new.sample <- sample(random.vector.2, 2)
  mean(new.sample)
}

sample.means.2 <- sapply(rep(1, 100), find.sample.mean.2)

summary(sample.means.2)
hist(sample.means.2)

#(d) Repeat with 10 items 100 times

find.sample.mean.10 <- function(i) {
  new.sample <- sample(random.vector.2, 10)
  mean(new.sample)
}

sample.means.10 <- sapply(rep(1, 100), find.sample.mean.10)


# Repeat with 100 items 100 times

find.sample.mean.100 <- function(i) {
  new.sample <- sample(random.vector.2, 100)
  mean(new.sample)
}

sample.means.100 <- sapply(rep(1, 100), find.sample.mean.100)

#Compare the summary statistics and histograms of each of these sampling distributions

summary(sample.means.2)
summary(sample.means.10)
summary(sample.means.100)

hist(sample.means.2)
hist(sample.means.10)
hist(sample.means.100)

#This time the sampling distribution is a closer representation of the population data
#because the population data was itself normally distributed.
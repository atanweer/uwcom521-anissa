#Ordering
order(mtcars$mpg)
mtcars[order(mtcars$mpg),]
mtcars[order(mtcars$mpg, mtcars$disp),]
mtcars[sort.list(mtcars$mpg),]
#Can only sort by one variable with sort, but by multiple with order
tmp<-mtcars
tmp

#Finding a subset:
mtcars$mpg < 15
tmp$mpg[tmp$mpg < 15]
tmp$mpg[tmp$mpg <15] <- NA
tmp

tmp$gear==3
tmp$gear[tmp$gear==3] <- NA
tmp

complete.cases(tmp)
#Returns false for any row that has NA's in it.
tmp[complete.cases(tmp),]
#Just created a subset of complete cases.

#Confidence Intervals
#CI is 1.96 X Standard Error

#Compute standard error, standard deviation divided by square root of n
sd(mtcars$mpg)
sd(mtcars$mpg) / sqrt(length(mtcars$mpg))
mean(mtcars$mpg)

#Multiply standard error by 1.96
1.96 * sd(mtcars$mpg) / sqrt(length(mtcars$mpg))

#Get the other end of that confidence interval by making a vector
#with the opposite sign
mean(mtcars$mpg) + (1.96 * sd(mtcars$mpg) / sqrt(length(mtcars$mpg))) * c(-1, 1)
(1.96 * sd(mtcars$mpg) / sqrt(length(mtcars$mpg))) * c(-1, 1)
#Gives you the two numbers on either side of the confidence interval
#95% confidence that the true value is between 18 and 22

#Function to do the same thing:
t.test(mtcars$mpg)
#Slightly different numbers because it's not assuming
#a normal distribution but a t distribution, which we'll read about
#More conservative confidence intervals for small n's

#Can change the confidence level with an additional argument
t.test(mtcars$mpg, conf.level = 0.99)

#Seen that the book has been doing a ton of simulations

#generate random data:
rnorm(mean=0, sd=1, n=10)

#What Mako did for our class data
x.population <- rnorm(n=10000, mean=42, sd=41)

sample(sample(x.population, 10))
min(sample(sample(x.population, 10)))

#Can write a function to do this, and then repeat over and over though

find.min.of.sample <- function(i) {
  my.sample <- sample(x.population, 10)
  min(my.sample)
  }
sapply(rep(1, 100), find.min.of.sample)
#I don't understand why you need sapply

hist(sapply(rep(1, 100), find.min.of.sample))

#See how it changes with larger samples:
find.min.of.sample <- function(i) {
  my.sample <- sample(x.population, 100)
  min(my.sample)
}
hist(sapply(rep(1, 1000), find.min.of.sample))

#Others like rnorm, rbinom, etc.
#runif() if you want a uniform distribution, i.e. equal likelihood 
#for all values across the distribution:

x.population <- runif(n=10000, mean=-10, max=10)

find.min.of.sample <- function(i) {
  my.sample <- sample(x.population, 10)
  min(my.sample)
}
hist(sapply(rep(1, 100), find.min.of.sample))

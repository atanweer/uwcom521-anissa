#Defining your own functions

say.mako <- function() {
  return("mako")
}

say.mako()

#Idiomatic R: Last line of your function will be what it returns, so this is the same thing:

say.mako <- function() {
  "mako"
}

my.mean <- function(original.vector, multiplier=1) {
  new.vector <- original.vector*multiplier
  sum(new.vector)/length(original.vector)
}
my.mean(rivers, 4)
my.mean(rivers, 1)
#the 1 will be the default, which means if you run the function without specifying the 
#multiplier, it will just multiply by 1. 
#If you don't put anything as the default, you have to enter something
#in order for the function to run: 

my.mean <- function(original.vector, multiplier) {
  new.vector <- original.vector*multiplier
  sum(new.vector)/length(original.vector)
}
my.mean(rivers)

#produces an error Have to say:

my.mean(rivers, multiplier = 4)

#lapply(): takes a data frame and applies something to each column. Eg:

lapply(cars,mean)
#Returns the mean for each column in cars

#sapply is the same, but provides a vector, so maybe a little easier to read
sapply(cars, mean)

#rep will do something however many times you want it to
rep("mako", 100)

#seq() generates a sequence
seq(0, 100)
seq(1, 100, by=5)

#sample() gives you a specified number of random items from a vector
sample(rivers, 10)
sample(rivers, 10, replace = TRUE) #Allows items chosen to go back into pool
sample(rivers, 10, replace = FALSE) #Doesn't allow items chosen to go back into pool

d <- wk.3.ds

choose.six.from.dataframe <- function (d) {
    total.rows <- nrow(d)
    all.indexes <- seq(1, total.rows)
    selected.indexes <- sample(all.indexes, 6)
    
    d.subset <- d[selected.indexes]
    return(d, subset)
}
    
# This didn't work for me. Mako will post a recording. 

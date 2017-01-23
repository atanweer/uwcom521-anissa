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
# From Mako's recording on tapply() and merge():

#Dates
> #tapply()
  > #merge
  > 
  > euro.datetime <- "3/08/2010"
> euro.datetime <- "3/08/2010 13:01:01"
> us.datetime <-"08-03-2010 01:01 PM"
> internet.datetime <- "2010-08-03T3:01:01z"
> #POSIXct #converts into seconds since 1970, unix time#
  > as.Date("2010-08-03")
[1] "2010-08-03"
> class(as.Date("2010-08-03"))
[1] "Date"
> as.Date(03/08/2010)
Error in as.Date.numeric(3/8/2010) : 'origin' must be supplied
> as.Date("03/08/2010")
[1] "0003-08-20"
> help("as.Date")
> as.Date("03/08/2010", format="%d/%m%Y")
[1] NA
> as.Date("03/08/2010", format="%d/%m/%Y")
[1] "2010-08-03"
> us.datetime
[1] "08-03-2010 01:01 PM"
> as.POSIXct(us.datetime, format="%m-%d-%Y %H:%M:%S")
[1] NA
> as.POSIXct(us.datetime, format="%m-%d-%Y %H:%M:%s")
[1] NA
> as.POSIXct(us.datetime, format="%m-%d-%Y %H:%M")
[1] "2010-08-03 01:01:00 PDT"
> as.POSIXct(us.datetime, format="%m-%d-%Y %H:%M", tz=UTC)
Error in strptime(x, format, tz = tz) : object 'UTC' not found
> as.POSIXct(us.datetime, format="%m-%d-%Y %H:%M", tz="UTC")
[1] "2010-08-03 01:01:00 UTC"
> as.POSIXct(us.datetime, format="%m-%d-%Y %H:%M" %p, tz="UTC")
Error: unexpected input in "as.POSIXct(us.datetime, format="%m-%d-%Y %H:%M" %p, tz="UTC")"
> as.POSIXct(us.datetime, format="%m-%d-%Y %H:%M %p", tz="UTC")
[1] "2010-08-03 01:01:00 UTC"
> #didn't work with the AM/PM thing for me
> class(us.datetime)
[1] "character"
> us.datetime <- as.POSIXct(us.datetime, format="%m-%d-%Y %H:%M %p", tz="UTC")
> class(us.datetime)
[1] "POSIXct" "POSIXt" 
> as.numeric(us.datetime)
[1] 1280797260
> as.Date("2015-08-03") - as.Date("2013-02-03"")
+ as.Date("2015-08-03") - as.Date("2013-02-03")
Error: unexpected string constant in:
  "as.Date("2015-08-03") - as.Date("2013-02-03"")
as.Date(""
        > as.Date("2015-08-03") - as.Date("2013-02-03")
        Time difference of 911 days
        > #ONCE YOU CONVERTED TO DATE FORMAT, ALLOWS YOU TO DO ARITHMETIC ON DATES
          > #tapply function
          > help)tapply()
Error: unexpected ')' in "help)"
> help(tapply)
> #takes three arguments, lapply and sapply do the same thing to every
  > #item in a list. 
  > #group all times in original vector and turn it into groups based on the second argument, the index
  > warpbreaks
breaks wool tension
1      26    A       L
2      30    A       L
3      54    A       L
4      25    A       L
5      70    A       L
6      52    A       L
7      51    A       L
8      26    A       L
9      67    A       L
10     18    A       M
11     21    A       M
12     29    A       M
13     17    A       M
14     12    A       M
15     18    A       M
16     35    A       M
17     30    A       M
18     36    A       M
19     36    A       H
20     21    A       H
21     24    A       H
22     18    A       H
23     10    A       H
24     43    A       H
25     28    A       H
26     15    A       H
27     26    A       H
28     27    B       L
29     14    B       L
30     29    B       L
31     19    B       L
32     29    B       L
33     31    B       L
34     41    B       L
35     20    B       L
36     44    B       L
37     42    B       M
38     26    B       M
39     19    B       M
40     16    B       M
41     39    B       M
42     28    B       M
43     21    B       M
44     39    B       M
45     29    B       M
46     20    B       H
47     21    B       H
48     24    B       H
49     17    B       H
50     13    B       H
51     15    B       H
52     15    B       H
53     16    B       H
54     28    B       H
> #What is the mean number of breaks for each factor, low, medium & high?
  > warpbreaks$breaks[warpbreaks$tension =="L"]
[1] 26 30 54 25 70 52 51 26 67 27 14 29 19 29 31 41 20 44
> mean(warpbreaks$breaks[warpbreaks$tension =="L"])
[1] 36.38889
> mean(warpbreaks$breaks[warpbreaks$tension =="M"])
[1] 26.38889
> mean(warpbreaks$breaks[warpbreaks$tension =="H"])
[1] 21.66667
> #Can do that easily by hand like that for three factors, but 
  > #sometimes have many, like 100 factors.
  > #tapply basically automates the process just laid out. 
  > tapply(warpbreaks$breaks, warpbreaks$tension, mean)
L        M        H 
36.38889 26.38889 21.66667 
> #tapply(vector - thing function will run on, factor - what you want to sort the vector by, function)
  > tapply(warpbreaks$breaks, warpbreaks$wool, mean)
A        B 
31.03704 25.25926 
> tapply(warpbreaks$breaks, warpbreaks$tension, mean)
L        M        H 
36.38889 26.38889 21.66667 
> tapply(warpbreaks$breaks, warpbreaks$tension, min)
L  M  H 
14 12 10 
> tapply(warpbreaks$breaks, warpbreaks$tension, max)
L  M  H 
70 42 43 
> class(tapply(warpbreaks$breaks, warpbreaks$tension, max))
[1] "array"
> #arrays like vectors, but can have more dimensions
  > max.tension <-tapply(warpbreaks$breaks, warpbreaks$tension, max)
> max.tension
L  M  H 
70 42 43 
> names(max.tension)
[1] "L" "M" "H"
> max.tension <-tapply(warpbreaks$breaks, warpbreaks$tension, max)
> max.df <- data.frame(tension=names(max.tension), max.breaks=max.tension)
> max.df
tension max.breaks
L       L         70
M       M         42
H       H         43
> class(max.df)
[1] "data.frame"

#From Mako's video on functions, lapply, sapply, etc. Started watching around 12:45

say.something <- function(thing.to.say) {
  thing.to.say
}
say.something <- function(thing.to.say="nothing to say") {
  thing.to.say
}
#now setting the default to be "nothing to say", so if you don't enter anything,
#it will return "nothing to say"

my.mean <- function(my.vec) {
  total <- sum(my.vec) 
  n <- length(my.vec)
  
  total / n
}

my.mean <- function(my.vec, multiplier=1) {
  my.vec <- my.vec * multiplier
  total <- sum(my.vec) 
  n <- length(my.vec)
  
  total / n
}

#So, what's happening here is that we're adding an argument to the function
#if someone uses that argument by putting a comma and a number after the
#vector they call inside the function, it will multiply every value in the 
#vector by the multiplier. 
#If they don't, the default multiplier will be "1". E.g.
my.mean(rivers)
my.mean(rivers, multiplier = 2)
my.mean(rivers, 2)

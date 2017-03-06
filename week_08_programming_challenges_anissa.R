#PC0. Load up your dataset as you did in Week 3 PC2.

setwd("/Users/anissa/Github/uwcom521-anissa")
list.files()
read.csv("week3_dataset-anissa.csv")
# Load the dataset into a variable called "wk.3.ds"
d.all <- read.csv("week3_dataset-anissa.csv")

#PC1. 

#If you recall from Week PC6, x and y seemed like they linearly related. 
#We now have the tools and terminology to describe this relationship and 
#to estimate just how related they are. 
#Run a t.test between x and y in the dataset and be ready to interpret the results for the class.

t.test(d.all$x, d.all$y)

#NOTE: THE VALUE IN DOING THIS AT THIS STEP IS TO ESTABLISH THAT THEY'RE 
#NOT DRAWN FROM THE SAME POPULATION

#PC2. 

#Estimate how correlated x and y are with each other.
cor(d.all$x, d.all$y)

#NOTE: MAKO ALSO DID THE SPEARMAN CORRELATION:
#cor(d.all$x,d.all$y, method='spearman')
#IN THIS CASE THERE IS NO DIFFERENCE BECAUSE THE RELATIONSHIP IS TRULY LINEAR
#IF IT'S NOT, SPEARMAN HAS BETTER RESULTS

#SPEARMAN IS ALWAYS SAFE. SHOULD ALWAYS RUN IT


#PC3. 

#Recode your data in the way that I laid out in Week 3 PC7.

#Recode i and j as T/F, logicals

d.all$i <- as.logical(d.all$i)
d.all$j <- as.logical(d.all$j)
head(d.all)

#Recode k as a factor and change the numbers into textual "meaning" to make it easier.
#Here's the relevant piece of the codebook (i.e., mapping): 
#0=none, 1=some, 2=lots, 3=all.

d.all$k <- factor(d.all$k, levels=c(0,1,2,3), labels=c("none", "some", "lots", "all"))

#PC4. 

#Generate a set of three linear models and be ready to intrepret the 
#coefficients, standard errors, t-statistics, p-values, and R-squared

lm.y.x <- lm(y ~ x, data=d.all)
lm.y.x.i.j <- lm(y ~ x + i + j, data = d.all)
lm.y.x.i.j.k <- lm(y ~ x + i + j + k, data = d.all)

summary(lm.y.x)
summary(lm.y.x.i.j)
summary(lm.y.x.i.j.k)

#NOTE: knone DISAPPEARED. MAKO SAYS IT'S IN THE INTERCEPT. THE INTERCEPT ENDS UP "COLLECTING" IT.
#A IS REFERRED TO AS THE OMITTED VARIABLE. 
#THE INTERCEPT GETS A LOT OF LEFTOVER STUFF, WHICH IS WHY PEOPLE DON'T TEND TO INTERPRET IT.
#IT'S PERFECTLY PREDICTABLE WHAT THAT VALUE WILL BE GIVEN EVERYTHING ELSE
#R WILL ALWAYS DROP THE FIRST LEVEL OF YOUR FACTOR
#SO PEOPLE OFTEN MAKE THE FIRST LEVEL THE ONE THAT IS MOST PREVALENT IN THEIR DATA
#SOMETIMES REFERRED TO AS THE "REFERENCE CASE"
#ALL THE OTHER LEVELS ARE REFERRING TO THAT ONE. 
#INTERPRET IT AS THE EFFECT OF HAVING SOME COMPARED TO NONE, THE EFFECT OF HAVING LOTS
#COMPARED TO NONE, AND THE EFFECT OF HAVING ALL COMPARED TO NONE. 
#OR IN ANOTHER CASE, PEOPLE WHO ARE FEMALE COMPARED TO MALE ... MALE WOULDN'T BE INCLUDED 
#AS A VARIABLE

#PC5. Generate a set of residual plots for the final model and be ready to 
#interpret your model in terms of each of these:

#(a) A histogram of the residuals.
#(b) Plot the residuals by your values of x, i, j, and k (four different plots).
#(c) A QQ plot to evaluate the normality of residuals assumption.

#(a)
hist(residuals(lm.y.x.i.j.k))
#They look pretty normally distributed
#(b)

plot(d.all$x, residuals(lm.y.x.i.j.k))
plot(d.all$k, residuals(lm.y.x.i.j.k))
plot(d.all$i, residuals(lm.y.x.i.j.k))
plot(d.all$j, residuals(lm.y.x.i.j.k))
#I don't undertand why the factor variables are plotted the way they are. 

#(c)
qqnorm(residuals(lm.y.x.i.j.k))
#Looks like they're linearly plotted, except for one extreme outlier

#PC6. Generate a nice looking publication-ready table with 
#a series of fitted models and put them in a Word document.

install.packages("stargazer")
library(stargazer)
stargazer(lm.y.x, lm.y.x.i.j, lm.y.x.i.j.k, type="html")

write(stargazer(lm.y.x, lm.y.x.i.j, lm.y.x.i.j.k, type="html"), file = "model.comp.html")

#PC7. 

#Now, lets go back to the Michelle Obama dataset we used last week 
#in the week 7 problem set's programming challenges.
#Load up the dataset once again and fit the following linear models and 
#be ready to interpret them similar to the way you did above in PC4

halloween.data <- read.delim("Halloween2012-2014-2015_PLOS.tab")
halloween.data <- halloween.data[complete.cases(halloween.data),]
head(halloween.data)


#(a)
lm.obama <- lm(fruit ~ obama, data=halloween.data)
summary(lm.obama)

#(b)

halloween.data$year <- as.factor(halloween.data$year)
lm.obama.controls <- lm(fruit ~ obama + age + year, data=halloween.data)
summary(lm.obama.controls)

#(c)

hist(residuals(lm.obama.controls))
#Not at all normally distributed. There are two extremes.

#plot(halloween.data$obama, residuals(lm.obama.controls))
#plot(halloween.data$year, residuals(lm.obama.controls))
#plot(halloween.data$age, residuals(lm.obama.controls))

#I'm getting an error message for all of these saying that 'x' and 'y' lengths differ.
#Not sure why that is
#Because some are missing, should have limited to full list
#Going to do that now and put it above

#And now plot again:
plot(halloween.data$obama, residuals(lm.obama.controls))
plot(halloween.data$year, residuals(lm.obama.controls))
plot(halloween.data$age, residuals(lm.obama.controls))

#(c)
qqnorm(residuals(lm.obama.controls))
#Those are extremely bifurcated.

#PC9. Run the simple model in (a) three times on three subsets of the dataset: 
#just 2012, 2014, and 2015. Be ready to talk through the results.

halloween.data.2012 <- subset(halloween.data, year == 2012)
head(halloween.data.2012)
lm.obama <- lm(fruit ~ obama, data=halloween.data.2012)
summary(lm.obama)

halloween.data.2014 <- subset(halloween.data, year == 2014)
head(halloween.data.2014)
lm.obama <- lm(fruit ~ obama, data=halloween.data.2014)
summary(lm.obama)

halloween.data.2015 <- subset(halloween.data, year == 2015)
head(halloween.data.2015)
lm.obama <- lm(fruit ~ obama, data=halloween.data.2015)
summary(lm.obama)
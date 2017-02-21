#Trying to correlate mpg to horsepower
#cor()

?cor
cor(mtcars$mpg, mtcars$hp)

#as horsepower goes up, mpg goes down

#first and second variables have to be the same length.

#can plot them quickly to see their relationship

plot(mtcars$mpg, mtcars$hp)

#Is it linear? Looks like it flattens out.
#Other way around too
plot(mtcars$hp, mtcars$mpg)

#cor() assumes a linear relationship, which may not always fit
#and may depress correlation
#method called Spearman correlation, which is a rank correlation
#non-parametric, doesn't assume linearity

cor(mtcars$hp, mtcars$mpg, method = "spearman")

#rank correlation is stronger

#LINEAR MODELS

#lm() is a linear model function
#lm(x ~ y, data=d)

#first argument is the model formula, the tilde means it's a formula
#"x by y"
#second argument is the data

lm(mpg ~ hp, data=mtcars)

#slope is the right column

#can pass the formula into a variable to make it easier

f <- mpg ~ hp
f
class(f)

lm(f, data=mtcars)

#Mako doesn't usually save the formula to a variable

#Can also do it like this, so you don't have to specify data, but
#Mako thinks it makes it harder to read.
lm(mtcars$mpg ~ mtcars$hp)

#Run summary() to get the statistical tests on the linear model

summary(lm(mpg ~ hp, data=mtcars))

#Don't usually spend much time interpreting the intercept statistics
#Gives you summary stats on residuals as well

#Helps to pass the model into a variable

m <- lm(mpg ~ hp, data=mtcars)
class(m)
summary(m)

#then you can get a list of all the things you can get with it when you type "m$"

m$residuals
m$coefficients
m$fitted.values


#Can also run function on m as a variable:
coefficients(m)
residuals(m)
predict(m)

#Predicted values will be given in the order the real values are listed
#in the dataset.

# mtcars$mpg - predict(m) will be the same thing as residuals(m)
mtcars$mpg - predict(m)
residuals(m)

#How to get Confidence Intervals:
confint(m)
#Default is 95%
?confint

#To change Confident Interval:

confint(m, level=0.99)

#Can also do by hand:

summary(m)
-.0682 +c(-1,1) *1.96 * .01012

#Wont be exactly the same as the numbers from the t test, but close. [???]

#RESIDUALS

#Plotting residuals
residuals(m)
hist(residuals(m))
#Should be normally distributed ... this isn't quite

#Plotting the residuals against x
plot(mtcars$hp, residuals(m))
#Should be evenly distributed across the "0" line
#If not, might have some heteroschasisty

#Can draw a qq plot
?qqplot
#Only useful in certain situations, Mako doesn't really use. Takes two variables
#qqnorm() is more useful
#qqnorm() takes one variable and graphs it against the theoretical quantiles

qqnorm(residuals(m))

#If drawn from a normal distribution, we would expect that to be a straight line
#Mako sees some problems with this one.

#So far have used the built in function in R

#ggplot has some good options
#But requires building a new dataset
#Because ggplot() likes to have a dataset passed in

d.graph <- data.frame(hp=mtcars$hp, residuals=residuals(m))
d.graph
library(ggplot2)
ggplot(data=d.graph) + aes(x=hp, y=residuals) + geom_point()
#A lot of work for something that's not substantially different.
#Might use it for publication
#Generally regression diagnostic graphs are not included in publications
#But something you should do yourself to make sure functions are being met.

#Fitting more complicated models

#Same thing, just add more items to formula

#Can update the formula with a function called update.formula()
?update.formula

#Takes two arguments, old formula, then new formula

#Remember we had our formula f
f

update.formula(f, . ~ . + disp)
#Dots mean the same thing as before

#Can also just write the formula again
lm(mpg ~ hp + disp, data = mtcars)
summary(lm(mpg ~ hp + disp, data = mtcars))

#Now see that displacement is highly significant, and hp is less significant
#Most variation between hp and mpg can be explained by displacement 
#Bigger engines tend to get lower mpg

cor(mtcars$hp, mtcars$disp)
#Very correlated with each others
#Can't do more than one at a time this way, but can make a dataset with all the columns
#you want to compare and put them in a new data frame, then run cor() on that dataframe
#This will return a correlation matrix

new.d <- mtcars[,c("hp", "disp", "mpg")]
new.d
cor(new.d)

#Returns a matrix with the correlations between all those variables.

#Could also do it for the whole original dataset

cor(mtcars)

#DUMMY VARIABLES IN LINEAR MODELS

#Going to make a copy of the original data set

mako.cars <- mtcars
#Recode automatic transmission as a true/false variable
mako.cars$am <- as.logical(mako.cars$am)
#Now am variable should be true/false
head(mako.cars)

#Can use true/false for dummy variables in regression model or 1's and 0's
#1's and 0's are the traditional way of doing it, but advantages to recoding to T/F

summary(lm(mpg ~hp + disp + am, data=mtcars))

#Positive effect of automatic transmission, no effect of displacement

#Now do the same thing to the new data set with am recoded as true/false

summary(lm(mpg ~hp + disp + am, data=mako.cars))

#Now specifies that it's AM "TRUE", but the number is exactly the same.
#Mako likes to do this for all his dummy variables because then 
#the "TRUE" is listed there, so it makes it really clear what 
#the interpretation of the coefficient should be
#i.e. that's the coefficient estimate *when the variable is true*

#CATEGORICAL VARIABLES IN LINEAR MODELS

#Add gear variable to model:
summary(lm(mpg ~hp + disp + am + gear, data=mtcars))

#Not a well estimated relationship between gears
#No reason there would be a linear effect
#Seems like cars with different kinds of gears are different kinds of cars.
#Haven't covered how to interpret categorical variables in context of regression
#Talking about it readings this week, but going to talk about it in code

#Can make a variable as.factor() right in the formula
#Will make 

summary(lm(mpg ~hp + disp + am + as.factor(gear), data=mtcars))

#Can also do as two stages
#First change gear into a factor

mako.cars$gear <- as.factor(mako.cars$gear)
mako.cars$gear
#Know it's a factor because it gives you levels

#Now R will know not to treat it as a linear effect, but will put in a set 
#of dummy variables.
#Will by default be one less dummy variable than the number of factors
#Will talk in class about why that is. 

#SUMMARY
#lm(dv ~ iv + iv + iv ... + iv, data=d)
#Will always have one variable on the left of the tilde, that is the dependent variable
#Independent variables go on the right of the tide
#"Estimates" are the estimated coefficients

m.full <- lm(mpg ~ hp + disp + am, data=mako.cars)
#Don't save the summary object, but the linear model object
#i.e. "m.full <- summary(lm(mpg ~ hp + disp + am, data=mako.cars))" is wrong

m.disp <- lm(mpg ~ hp + disp, data = mtcars)

m.full
m.disp

#Library called stargazer, will give you info about how to cite it

install.packages("stargazer")
library(stargazer)
stargazer(m)
#prints in a language called tep which is not what we want, so specify they typ
stargazer(m, type=text)
stargazer(m, m.disp, m.full, type="text")
#Prints a really nice looking table
#Allows us to compare our different models

#To insert into a word document, make it type "html" instead of text
#Can then paste it right into a word document

stargazer(m, m.disp, m.full, type="html")
#Can cut and paste into a file called something called something.html, then 
#pasted that right into your Word document
#[I don't understand that process]

#With variables lined up, see what happens
#When we add displacement, it moderates the effect of hp
#When we add am, it moderates it back to a stronger relationship with hp

#[What is the "constant"]

#GETTING ANOVA DATA

?anova
#anova() will take a linear model object
#Will return the kind of table you see when people use ANOVA
#Same numbers are represented, but have info on df, f value

anova(m.full)
#Important thing is that p values for the f test and t tests are the same


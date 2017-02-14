getwd()
setwd("/Users/anissa/Github/uwcom521-anissa")

#PC1. 

#Download this dataset in Stata DTA format which contains an anonymized and reduced version 
#of the data visualized in the Buechley and Hill paper on Lilypad. Once you have it

#First, found a read.dta() function in a library called foreign
library(foreign)
lilypad <- read.dta("/Users/anissa/Github/uwcom521-anissa/lilypad_anonymized.dta")

#Then take a look at the data to see what's in it:

head(lilypad)

#(a) Reproduce both Table 1 and Table 2 (just US users) using the dataset (as closely as possible).

#Table 1:

table.1 <- table(lilypad$gender, lilypad$order_type)

colnames(table.1) <- c("Arduino", "Both", "LilyPad")
table.1

#Table 2:

#first, make a subset of U.S. customers
us.customers <- subset(lilypad, lilypad$country=="United States")

table.2 <- table(us.customers$gender, us.customers$order_type)
colnames(table.2) <- c("Arduino", "Both", "LilyPad")
table.2

#NOTE: CAN CHANGE THE ORDER BY CHANGING THE LEVELS IN THE DATAFRAME WITH relevel()
#But that seems really complicated. Can also just reassign levels. 
#Mako's example with warpbreaks dataset
#factor(wb$tension, levels = c("M", "L", "H"))

#(b) Run a [chi-squared]-test on both tables. 
#Compare to the paper (for Table 1, there doesn't seem to be a [chi squared] test for Table 2). 
#Did you reproduce it?

chisq.all <- chisq.test(table.1)
chisq.all

chisq.us <- chisq.test(table.2)
chisq.us

#Yes, I reproduced the results of the chi-squared test for Table 1, even though it
#seems to be mislabeled in the paper.


#(c) Install the package "gmodels" and try to display the table using the function CrossTable(). 
#This will give you output very similar to SPSS.

install.packages("gmodels")
library(gmodels)
CrossTable(table.1)
CrossTable(table.2)


#(c) It's important to be able to import tables directly into your word processor 
#without cutting and pasting individual cells. Can you export the output of your table? 
#There are a bunch of functions you can use to do this. 
#I used the "xtable" package but I think that write.table() and 
#Excel would do the job just as well.

write.table(table.1, "/Users/anissa/Github/uwcom521-anissa/LilyPadTable1")
write.table(table.2, "/Users/anissa/Github/uwcom521-anissa/LilyPadTable2")

#Hmmm, that sort of worked. I can't open them in Excel, but I can in a text editor or word

#NOTE: THERE ARE A BUNCH OF R PACKAGES FOR WRITING REGRESSION TABLE OUTPUTS
#E.G. STARGAZER

#PC2. 

#At the Community Data Science Workshops we had two parallel afternoon sessions on Day 1. 
#In my session, there were 42 participants. In Tommy Guy's session, there were only 19. 
#The next week (Day 2), we asked folks to raise their hands if they had been in 
#Tommy's session (14 did ) and how many had been in mine (31 did). 
#There was clearly attrition in both groups! 
#Was there more attrition in one group than another? 
#Try answering this both with a test of proportions (prop.test()) and with 
#a [chi-squared]. Compare your answers. 
#Is there convincing evidence that there is a dependence between instructor and attrition?

#First, I'll make a table so I can visualize what's going on

cscw.attendance <- rbind(c(42, 31),
                         c(19, 14))
rownames(cscw.attendance) <- c("Mako", "Tommy")
colnames(cscw.attendance) <- c("Day1", "Day2")
cscw.attendance
#Wasn't able to index into cscw.attendance, I think because it's a matrix, so
#going to make it into a dataframe

cscw.attendance <- as.data.frame(cscw.attendance)
class(cscw.attendance)

#Now make a new vector called AttritionRate
#AttritionRate <- c((cscw.attendance$Day1-cscw.attendance)$Day2/cscw.attendance$Day1)

#bind the new vector to the cscw.attendance dataframe
#cscw.attendance <- cbind(cscw.attendance, AttritionRate)

#chisq.test(cscw.attendance)

#I got a warning message, though, sayin that the chi-squared approximation may be incorrect.
#I'm not sure why. 

#I shouldn't have added the attrition rate, I think that screwed everything up.
#So commenting out what I did. 

chisq.test(cscw.attendance)

prop.test(as.matrix(cscw.attendance))

#There appears to be no difference between these. 
#I can't figure out how to get the proptest to work. 
#NOTE: THAT'S BECAUSE PROPTEST HAS TO BE DONE ON A MATRIX

#PC3. 

#Download this dataset that was just published on 
#"The Effect of Images of Michelle Obama’s Face on Trick-or-Treaters’ Dietary 
#Choices: A Randomized Control Trial." 
#The paper doesn't seem to have even been published yet so I think the abstract is all we have. 
#We'll come back to it again next week.

#(a) Download and import the data into R. I needed to install the "readstata13" package to do so.

halloween.data <- read.delim("Halloween2012-2014-2015_PLOS.tab")
head(halloween.data)

#I just downloaded the tab delimited version instead of the original Stata version

#(b) Take a look at the codebook if necessary. 
#Recode the data on being presented with Michelle Obama's face and 
#the data on whether or not kids picked up fruit. we'll leave it at that for now.

#I didn't really understand what we were supposed to recode.

shown.michelle <- subset(halloween.data, halloween.data$obama==1)
not.shown.michelle <- subset(halloween.data, halloween.data$obama==0)

#(c) Do a simple test on whether or not the two groups are dependent. 
#Be ready to report those tests. The results in the paper will use linear regression. 
#Do you have a sense, from your reading, why your results using the coding material 
#we've learned might be different?

#I don't quite understand what test we were supposed to do. t-test?
t.test(shown.michelle$fruit, not.shown.michelle$fruit)
#That does actually work because it's treating them like proportions, but not really 
#what we're after

#NOTE: TANYA'S SOLUTION:
# fruitface <- table(d$obama, d$fruit)
# colnames(fruitface) <- c("No", "Yes")
# rownames(fruitface) <- c("No", "Yes")
# fruitface

# going to recreate that:

face.fruit.table <- table(face=halloween.data$obama, fruit=halloween.data$fruit)
colnames(face.fruit.table) <- c("No", "Yes")
rownames(face.fruit.table) <- c("No", "Yes")
face.fruit.table

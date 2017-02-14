#Lagakos, S., & Mosteller, F. (1981). A case study of statistics in the regulatory process: 
#the FD&C Red No. 40 experiments. Journal of the National Cancer Institute, 66(1), 197–212. [PDF]

#First, as always, make sure I'm in the appropriate directory

getwd()
setwd("/Users/anissa/Github/uwcom521-anissa")
getwd()

#PC0. 

#Download the dataset by clicking through on the "Red Dye Number 40" link on this webpage. 
#You'll find that the it's not in an ideal setup. 
#It's an Excel file (XLS) with a series of columns labeled X1.. X4. The format is not exactly tabular.

#PC1. Load the data into R. 
#Now get to work on reshaping the dataset. 
#I think a good format would be a data frame with two columns: group, time of death (i.e., lifespan).

list.files()

#Tried read.delim("week6_dataset_red_dye.xlsx") but that didn't work.
#So I opened Excel, and saved the file as a .csv

read.csv("week6_dataset_red_dye.csv")

#That worked, so going to load it into a variable

red.dye.df.orig <- read.csv("week6_dataset_red_dye.csv")

red.dye.df.orig

#Now create a new data frame that looks the way I want it to look
#Found this documentation on the website:

#X1 = time of death for control group
#X2 = time of death for group with low dosage
#X3 = time of death for group with medium dosage
#X4 = time of death for group with high dosage

#Plan:
#The only thing I can think to do is make a new dataframe for each of the current columns,
#adding a column to each one that contains the name of the group.
#I'll make sure that each of those four new dataframes has the same column names.
#Then I can bind the rows of those dataframes together.

#First try this with the control group:

control.list <- red.dye.df.orig$X1
control.factor.list <- rep("Control",length(red.dye.df.orig$X1))
control.df <- data.frame(control.list, control.factor.list)
control.df

#Okay, that worked, but now I want to try to name the columns

rm(control.df)

control.list <- red.dye.df.orig$X1
control.factor.list <- rep("Control",length(red.dye.df.orig$X1))
control.df <- data.frame(DeathAge = control.list, Group = control.factor.list)
control.df

#That worked, so going to repeat that for each of the groups

low.list <- red.dye.df.orig$X2
low.factor.list <- rep("Low",length(red.dye.df.orig$X2))
low.df <- data.frame(DeathAge = low.list, Group = low.factor.list)
low.df

medium.list <- red.dye.df.orig$X3
medium.factor.list <- rep("Medium",length(red.dye.df.orig$X3))
medium.df <- data.frame(DeathAge = medium.list, Group = medium.factor.list)
medium.df

high.list <- red.dye.df.orig$X4
high.factor.list <- rep("High",length(red.dye.df.orig$X4))
high.df <- data.frame(DeathAge = high.list, Group = high.factor.list)
high.df

#Now I have to bind the dataframes together according to the columns. 

red.dye.df.new <- rbind(control.df, low.df, medium.df, high.df)
red.dye.df.new

#Thank god that worked.

#NOTE: Mako used reshape library, which has cast and melt. Used the melt function, which
#turns wide data into long data. 
#libary(reshape2)
#d <- melt (d, na.rm=TRUE) 
#did EXACTLY what we were trying to do (First had renamed columns)
#cast() will do the opposite thing

#PC2. 
#Create summary statistics and visualizations for each group. 
#Write code that allows you to generate a useful way to both 
#(a) get a visual sense both for the shape of the data and its relationships and 
#(b) the degree to which the assumptions for t-tests and ANOVA hold. 
#What is the global mean of your dependent variable?

tapply(red.dye.df.new$DeathAge, red.dye.df.new$Group, summary)
tapply(red.dye.df.new$DeathAge, red.dye.df.new$Group, hist)

#(a) It doesn't appear to be normally distributed. But the means do look like they 
#might be different from each other. 
#(b) It's hard to know if there is a normally distributed sampling distribution, because I don't
#think it's actually a sampling distribution. I believe the mice are randomly selected for their 
#groups, so the observations should be independent. With an experimental design, I don't think 
#the 10% sampling rule for independence is relevant, but I'm not sure.

#(c) global mean of ID:
mean(red.dye.df.new$DeathAge, na.rm = TRUE)

#about 75.55

#PC3. 

#Do a t-test between mice with any RD40 and mice with at least a small amount. 
#Run a t-test between the group with a high dosage and control group. 
#How would you go about doing it using formula notation? 
#Be ready to report, interpret, and discuss the results in substantive terms.

#I don't think the first question makes sense, 
#so I'm going to do a t-test between the control group and all the others. 
#I don't think the tilde method will work because it would break down all the groups, 
#not lump three of them together

#t.test(df$result[df$group=="a"], df$result[df$group=="b"])

t.test(red.dye.df.new$DeathAge[red.dye.df.new$Group=="Control"], 
       red.dye.df.new$DeathAge[red.dye.df.new$Group!="Control"])

#Reject the null hypothesis. Very small p value, much lower than the .05 threshold. 
#We are 95% confident that the mean age of death for rats exposed to any amount of RD40
#is somewhere between 11.5 and 33 weeks lower than rats not exposed to any amount of RD40

t.test(red.dye.df.new$DeathAge[red.dye.df.new$Group=="Control"], 
       red.dye.df.new$DeathAge[red.dye.df.new$Group=="High"])

#Reject the null hypothesis. P value is lower than the .05 threshold (but not as low as the last). 
#We are 95% confident that the mean age of death for rats exposed to high amounts of RD40
#is somewhere between 2.5 and 50 weeks lower than rats not exposed to any amount of RD40

#NOTE: How Mako did this using formula notation:
#d$control <- d$group == "control"
#t.test(death.time ~ control, data=d)

#PC4. 

#Estimate an ANOVA analysis using aov() to see if there is a difference between the groups. 
#Be ready to report, interpret, and discuss the results in substantive terms.

red.dye.anova <- aov(DeathAge ~ Group, data=red.dye.df.new)
red.dye.anova
#Like Mako pointed out in the lecture, need to do summary() of the anova output
summary(red.dye.anova)

#Was I supposed to do something about missing values here?


#NOTE ON DEBUGGING
#1. Save variables on the way
#2. Harder in a function ... will walk through after the break



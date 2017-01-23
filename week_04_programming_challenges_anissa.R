#PC2

#Load both datasets into R as separate data frames. 
#Explore the data to get a sense of the structure of the data. 
#What are the columns, rows, missing data, etc? 
#Write code to take (and then check/look at) several random subsamples of the data.

#Set the directory to the folder designated for assignments in this class

setwd("/Users/anissa/Github/uwcom521-anissa")

#Load the City of Seattle datasets that will be needed for this class
#by reading the csv files and passing them into new variables to populate the environment

cos.mobile.access <- read.csv("COS-Statistics-Mobile_Sessions.csv")
cos.webpage.access <- read.csv("COS-Statistics-Top5000-Pages.csv")

#Find the column names by viewing the items in the list/dataframe
ls(cos.mobile.access)
ls(cos.webpage.access)

#Take random samples of 10 and 25 items from each of the datasets
#First tried this: "sample(cos.mobile.access, 3, replace = FALSE)", but that just returned
#all the entries for three randomly selected columns, because the columns are the items in
#the vector "cos.mobile.access". So, I found this code online:

cos.mobile.access[sample(nrow(cos.mobile.access), 10),]
#Couldn't figure out how to make "replace=FALSE" work, though.
#Copied some code online that works:
cos.mobile.access[sample(nrow(cos.mobile.access), 10, replace = FALSE),]
cos.webpage.access[sample(nrow(cos.webpage.access), 10, replace = FALSE),]
#I don't understand what the last comma is for, though ... when I put a number in there
#it does things that seem unpredictable to me. 


# PC3

#Using the top 5000 dataset, create a new data frame where one column is each month 
#(as described in the data) and a second column is the total number of views 
#made to all pages in the dataset over that month.

#First I want to put this df in order according to date, just for my own brain
#df[order(as.Date(df$date,format="%d/%m/%Y")),,drop=FALSE]
cos.webpage.access <- cos.webpage.access[order(as.Date(cos.webpage.access$Month, format="%m/%d/%Y")),,drop=FALSE]
#does this mean that from here on out, all my data will be in date format? Can test this.
class(cos.webpage.access$Month)
#Nope, I guess I need to pass it back into the variable as a date first, then. 
cos.webpage.access$Month <- as.Date(cos.webpage.access$Month, format="%m/%d/%Y")
#Now check to make sure the Month column is classified as a Date:
class(cos.webpage.access$Month)
#Yep

#So now, I need to do tapply to get the sum for all the views in each month.
#tapply(vector - thing function will run on, factor - what you want to sort the vector by, function)
tapply(cos.webpage.access$Pageviews, cos.webpage.access$Month, sum)
#worked beautifully!

#Now I need to put them into a new dataframe, which might be hard because Mako's instructions in the
#lecture were really confusing.

#monthly.views.df <- as.data.frame(tapply(cos.webpage.access$Pageviews, cos.webpage.access$Month, sum))
#first did that, but then I had one unnamed column for the date
# and one column called "as.data.frame(tapply(cos.webpage.access$Pageviews, cos.webpage.access$Month, sum))"
#so I have to rename them.
#Tried this from Rcookbook, but it didn't work. 
  # You can also rename by position, but this is a bit dangerous if your data
  # can change in the future. If there is a change in the number or positions of
  # columns, then this can result in wrong data.
  # Rename by index in names vector: change third item, "gamma", to "three" names(d)[3] <- "three"
#So trying to copy Mako's code from the video
  #"max.breaks <- tapply(warpbreaks$breaks, warpbreaks$tension, max)
  # max.df <- data.frame(tension=names(max.breaks),
                      # max.breaks=max.breaks)"
#So what he's doing is passing the tapply() function into a new variable BEFORE making a dataframe. OK.

monthly.views <- tapply(cos.webpage.access$Pageviews, cos.webpage.access$Month, sum)
monthly.views.df <- data.frame(Month=names(monthly.views), monthly.views=monthly.views)

#Now view to make sure it looks right:
monthly.views.df
#Yep! Except that the months are repeated in the month column, but that's 
#what Mako's looks like, too, up to the point I can watch the video

#PC4
#Using the mobile dataset, create a new data frame where one column is each month described in the data
#and the second is a measure (estimate?) of the total number of views made by mobiles (all platforms) 
#over each month. This will will involve at least two steps since total views are included. 
#You'll need to first use the data there to create a measure of the total views per platform.

#Going to take a look at the head() so I can see what columns I have to work with

head(cos.mobile.access)

#There is no column for monthly views, so I have to create a new variable.
#T here is a number of Sessions and PagesPerSession ... 
#I think if you multiply the Session by PagesPerSession
#you should get the total number of pages viewed (why Mako called it "estimate"?)
#So making a new variable with that, which I'll call mobile.os.monthly.views
#Since my next step will be to combine all the operating systems by month
mobile.os.monthly.views <- cos.mobile.access$Sessions * cos.mobile.access$PagesPerSession

#Now I want to add that column to the dataframe so that I can manipulate it
#(How can I know for sure they're in the same order, though?) 
cos.mobile.access <- cbind(cos.mobile.access, mobile.os.monthly.views)
head(cos.mobile.access)

#Now I need to combine all the different entries per month and add up the total,
#using tapply() just like I did for the other dataset. 

mobile.all.monthly.views <- tapply(cos.mobile.access$mobile.os.monthly.views, cos.mobile.access$Month, sum)
mobile.all.monthly.views.df <- data.frame(Month=names(mobile.all.monthly.views), mobile.all.monthly.views=mobile.all.monthly.views)

head(mobile.all.monthly.views.df)

#Ok, that actually worked, but the Month column is still doubled
#and it's in a different data format than the first dataframe. 

#PC5

#Merge your two datasets together into a new dataset with columns for each month, 
#total views (across the top 5000 pages) and total mobile views. 
#Are there are missing data? Can you tell why?

#First, I have to clean up the data columns in each of my newly created df's.

as.Date(mobile.all.monthly.views.df$Month, format="%m/%d/%Y")
mobile.all.monthly.views.df$Month <- as.Date(mobile.all.monthly.views.df$Month, format="%m/%d/%Y")

#Actually, the Month column in monthly.views.df is already in the right format,
#So I don't have to do anything. 

#Now I'll create a new df called "percent.mobile.views" by combining 
#monthly.views.df & mobile.all.monthly.views.df

#percent.mobile.views.df <- merge(monthly.views.df, mobile.all.monthly.views.df, by.x="Month", by.y = "Month", all.x = TRUE, all.y = TRUE) 
#Tried that but got an error that said "invalid factor level, NA generated

#percent.mobile.views.df <- merge(monthly.views.df, mobile.all.monthly.views.df, by.x="Month", by.y = "Month", all.x = TRUE, all.y = FALSE) 
#So I tried the above, but it turns the mobile.all.monthly.views into NA's for some reason. 

#Nothing is working!
#Okay, so I think the problem might be that, even thought the "Month" column in monthly.views.df
#LOOKS like it's in the right format, it's actually not being considered a date.
#I checked this by doing class(monthly.views.df$Month) and realized it's a factor.
#I've been trying to merge a date with a factor, which may have been the problem.
#So, go back and make monthly.views.df$Month into a Date

monthly.views.df$Month <- as.Date(monthly.views.df$Month, format="%Y-%m-%d")

#Now I can try this again: 
percent.mobile.views.df <- merge(monthly.views.df, mobile.all.monthly.views.df, by.x="Month", by.y = "Month", all.x = TRUE, all.y = TRUE)

percent.mobile.views.df

#Worked!
#Yes, there are missing data because there are NA's

#PC6. Create a new column in your merged dataset that describes your best estimate 
#of the proportion (or percentage, if you really must!) of views that comes from mobile. 
#Be able to talk about the assumptions you've made here. 
#Make sure that date, in this final column, is a date or datetime object in R.

#Okay, now to divide percent.mobile.views.df$mobile.all.monthly.views
# by percent.mobile.views.df$monthly.views
#and cast into a new variable that I can bind to percent.mobile.views.df

percent.mobile.views <- percent.mobile.views.df$mobile.all.monthly.views / percent.mobile.views.df$monthly.views

#Now bind that variable to percent.mobile.views.df

percent.mobile.views.df <- cbind(percent.mobile.views.df, percent.mobile.views)

percent.mobile.views.df

#Worked!
#assumptions: that everything is in the right order!


#PC6. Graph this over time and be ready to describe: 
#(a) your best estimate of the proportion of views from mobiles to the Seattle City website over time and 
#(b) an indication of whether it's going up or down.

#First, I have to sort the data.

percent.mobile.views.df <- percent.mobile.views.df[order(percent.mobile.views.df$Month),]
percent.mobile.views.df


#Now, I'll plot it.

plot(percent.mobile.views.df$Month, percent.mobile.views.df$percent.mobile.views)

#There's not really a discernable trend. It looks pretty stable, with a couple
#anomolous data points that could be errors of some kind. 


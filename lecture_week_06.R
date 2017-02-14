#cut() turn numeric data into factors
airquality
head(airquality)
?airquality
table(airquality$Month)
hist(airquality$Temp)
cut(airquality$Temp, 10)
cut(airquality$Temp, quantile(airquality$Temp))
#Useful for binning data for visualizations
#Can add labels to these bins with the label function, which Mako's 
#not going to go over

table(cut(airquality$Temp, quantile(airquality$Temp)))

#temp.tab

aq <- airquality
aq$Temp.quart <- cut(aq$Temp, quantile(aq$Temp))

head(aq)
    
table(aq$Temp.quart)

temp.tab <- table(aq$Temp.quart, aq$Month)
temp.tab

#genpol

matrix(c(762, 327, 468, 484, 239, 477), nrow = 2)
#Doesn't com up in the order we want it to appear, though
#This will be the way we want it:
genpol <- rbind(c(762, 327, 468), 
                c(484, 239, 477))

class(genpol)

colnames(genpol) <- c("Dem", "Ind", "Rep")
rownames(genpol) <- c("F", "M")

genpol

head(warpbreaks)
tapply(warpbreaks$breaks, warpbreaks$wool, sum)

#wb.tab

tapply(warpbreaks$breaks, 
       list(warpbreaks$wool, warpbreaks$tension), sum)

wb.tab <- tapply(warpbreaks$breaks, 
                 list(warpbreaks$wool, warpbreaks$tension), sum)

chisq.test(temp.tab)
temp.tab

prop.table(temp.tab)
#Gives you the proportion of all the items in the table
prop.table(temp.tab)*100
#That gives you percents

aq$Temp > 80
prop.table(table(aq$Temp >80))

temp.chisq <- chisq.test(temp.tab)
class(temp.chisq)
temp.chisq$p.value
#can call things from the test, just to get that
#Or treat it like a list:
names(temp.chisq)

temp.chisq$expected

temp.chisq$residuals

summary(temp.chisq)


genpol.chisq <- chisq.test(genpol)
genpol.chisq

chisq.test(wb.tab)$statistic

?qnorm

qnorm(p=.975)
#Just gives you the critical value
?qchisq
#All chi squared tests are one-tailed
qchisq(p=0.95, df=3)
qchisq(p=0.95, df=12)
qchisq(p=0.95, df=100)
qchisq(p=0.95, df=20000)

#DEBUGGING

mult.by.10 <- function (x) {
  rv <- c()
  for (i in x) {
    new.value <- i*10
    rv <- c(new.value, rv)
  }
  return(rv)
}

mult.by.10(c(1,2,3,4))

#Got a bug ... returning answers in opposite order
#from what we want.

#So we can do print line debugging

mult.by.10 <- function (x) {
  
  print(x)
  rv <- c()
  for (i in x) {
    new.value <- i*10
    rv <- c(new.value, rv)
  }
  return(rv)
}

mult.by.10(c(1,2,2,4))

#That seems ok, so going to go in and print a 
#different line:

mult.by.10 <- function (x) {
  
  rv <- c()
  for (i in x) {
    print(i)
    new.value <- i*10
    rv <- c(new.value, rv)
  }
  return(rv)
}

mult.by.10(c(1,2,2,4))

#That, too, seems write, so now going to print the "new.value"

mult.by.10 <- function (x) {
  
  rv <- c()
  for (i in x) {
    new.value <- i*10
    print(new.value)
    rv <- c(new.value, rv)
  }
  return(rv)
}

mult.by.10(c(1,2,2,4))

#Appear to be muliplying it in the right order, too. 

mult.by.10 <- function (x) {
  
  rv <- c()
  for (i in x) {
    new.value <- i*10
    rv <- c(new.value, rv)
    print(rv)
  }
  return(rv)
}

mult.by.10(c(1,2,2,4))

#Now it's reversed, but can make it more clear what's
#happening by doing this:

mult.by.10 <- function (x) {
  
  rv <- c()
  for (i in x) {
    new.value <- i*10
    print(paste("new value:", new.value))
    rv <- c(new.value, rv)
    print(paste("rv:", rv))
  }
  return(rv)
}

mult.by.10(c(1,2,2,4))

#So what we were doing is adding the new value first
#need to reverse them.

mult.by.10 <- function (x) {
  
  rv <- c()
  for (i in x) {
    new.value <- i*10
    print(paste("new value:", new.value))
    rv <- c(rv, new.value)
    print(paste("rv:", rv))
  }
  return(rv)
}

answer <- mult.by.10(c(1,2,2,4))
answer



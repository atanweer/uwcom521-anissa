#First I tried the built-in t.test() function, putting the difference between means as the x value:
#t.test(12.3, mu=0, alternative = "greater", paired = FALSE, conf.level = .95)
#Doesn't work because I don't have the original data in the form of a vector

#Found this on stack overflow:

# m1, m2: the sample means
# s1, s2: the sample standard deviations
# n1, n2: the same sizes
# m0: the null value for the difference in means to be tested for. Default is 0. 
# equal.variance: whether or not to assume equal variance. Default is FALSE. 
t.test2 <- function(m1,m2,s1,s2,n1,n2,m0=0,equal.variance=FALSE)
{
  if( equal.variance==FALSE ) 
  {
    se <- sqrt( (s1^2/n1) + (s2^2/n2) )
    # welch-satterthwaite df
    df <- ( (s1^2/n1 + s2^2/n2)^2 )/( (s1^2/n1)^2/(n1-1) + (s2^2/n2)^2/(n2-1) )
  } else
  {
    # pooled standard deviation, scaled by the sample sizes
    se <- sqrt( (1/n1 + 1/n2) * ((n1-1)*s1^2 + (n2-1)*s2^2)/(n1+n2-2) ) 
    df <- n1+n2-2
  }      
  t <- (m1-m2-m0)/se 
  dat <- c(m1-m2, se, t, 2*pt(-abs(t),df))    
  names(dat) <- c("Difference of means", "Std Error", "t", "p-value")
  return(dat) 
}
#For my data:
#m1 <- 56.81
#m2 <- 44.51
#s1 <- 16.13
#s2 <- 13.32
#n1 <- 23
#n2 <- 23
#m0 <- 0
#equal.variance = FALSE

t.test2(56.81,44.51,16.13,13.32,23,23,m0=0,equal.variance=TRUE)

#This gives me a different t score than what I got by hand
#I think they may have calculated the t score wrong: t <- (m1-m2-m0)/se 
#I found this formula for the t-score:
#t <- abs(qt(0.05/2, 44)) # 95% confidence, 2 sided
#So I'm going to try substituting that in the code above

#First I tried the built-in t.test() function, putting the difference between means as the x value:
#t.test(12.3, mu=0, alternative = "greater", paired = FALSE, conf.level = .95)
#Doesn't work because I don't have the original data in the form of a vector

#Found this on stack overflow:

# m1, m2: the sample means
# s1, s2: the sample standard deviations
# n1, n2: the same sizes
# m0: the null value for the difference in means to be tested for. Default is 0. 
# equal.variance: whether or not to assume equal variance. Default is FALSE. 
t.test2 <- function(m1,m2,s1,s2,n1,n2,m0=0,equal.variance=FALSE)
{
  if( equal.variance==FALSE ) 
  {
    se <- sqrt( (s1^2/n1) + (s2^2/n2) )
    # welch-satterthwaite df
    df <- ( (s1^2/n1 + s2^2/n2)^2 )/( (s1^2/n1)^2/(n1-1) + (s2^2/n2)^2/(n2-1) )
  } else
  {
    # pooled standard deviation, scaled by the sample sizes
    se <- sqrt( (1/n1 + 1/n2) * ((n1-1)*s1^2 + (n2-1)*s2^2)/(n1+n2-2) ) 
    df <- n1+n2-2
  }      
  t <- abs(qt(0.05/2, (n1+n2-2))) # 95% confidence, 2 sided, had to put the formula for df in 
  dat <- c(m1-m2, se, t, 2*pt(-abs(t),df))    
  names(dat) <- c("Difference of means", "Std Error", "t", "p-value")
  return(dat) 
}
#For my data:
m1 <- 56.81
m2 <- 44.51
s1 <- 16.13
s2 <- 13.32
n1 <- 23
n2 <- 23
m0 <- 0
equal.variance = FALSE

t.test2(56.81,44.51,16.13,13.32,23,23,m0=0,equal.variance=TRUE)




#That worked, but now I want to add a confidence interval

# m1, m2: the sample means
# s1, s2: the sample standard deviations
# n1, n2: the same sizes
# m0: the null value for the difference in means to be tested for. Default is 0. 
# equal.variance: whether or not to assume equal variance. Default is FALSE. 
t.test2 <- function(m1,m2,s1,s2,n1,n2,m0=0,equal.variance=FALSE)
{
  if( equal.variance==FALSE ) 
  {
    se <- sqrt( (s1^2/n1) + (s2^2/n2) )
    # welch-satterthwaite df
    df <- ( (s1^2/n1 + s2^2/n2)^2 )/( (s1^2/n1)^2/(n1-1) + (s2^2/n2)^2/(n2-1) )
  } else
  {
    # pooled standard deviation, scaled by the sample sizes
    se <- sqrt( (1/n1 + 1/n2) * ((n1-1)*s1^2 + (n2-1)*s2^2)/(n1+n2-2) ) 
    df <- n1+n2-2
  }      
  t <- abs(qt(0.05/2, (n1+n2-2))) # 95% confidence, 2 sided, had to put the formula for df in
  dat <- c((m1-m2), se, t, 2*pt(-abs(t),df), ((m1-m2) - (t*se)), ((m1-m2) + (t*se)))    
  names(dat) <- c("Difference of means", "Std Error", "t", "p-value", "Conf Int Min", "Conf Int Max")
  return(dat)
  
  
}


#For my data:
#m1 <- 56.81
#m2 <- 44.51
#s1 <- 16.13
#s2 <- 13.32
#n1 <- 23
#n2 <- 23
#m0 <- 0
#equal.variance = FALSE

t.test2(56.81,44.51,16.13,13.32,23,23,m0=0,equal.variance=TRUE)

# After all that, I think the first version I found online was the right one. 

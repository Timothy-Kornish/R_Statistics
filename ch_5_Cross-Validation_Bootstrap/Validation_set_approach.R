library(ISLR)

#-------------------------------------------------------------------------------
#        Validation Set Approach
#
#   use: estimate the test error rate result from fitting various linear models
#
#   sample(): splits set of observations in half
#-------------------------------------------------------------------------------

attach(Auto)

set.seed(1)
train = sample(392, 196)

print("-----------------------------------------------------------------------")
print("Error rate for seed value 1, in order of linear, quadratic, cubic")
print("-----------------------------------------------------------------------")

lm.fit = lm(mpg~horsepower, data = Auto, subset = train)
mean((mpg-predict(lm.fit, Auto))[-train]^2)

lm.fit2 = lm(mpg~poly(horsepower, 2), data = Auto, subset = train)
mean((mpg-predict(lm.fit2, Auto))[-train]^2)

lm.fit3 = lm(mpg~poly(horsepower, 3), data = Auto, subset = train)
mean((mpg-predict(lm.fit3, Auto))[-train]^2)

#-------------------------------------------------------------------------------
#        Different Seed value creating different error rate
#-------------------------------------------------------------------------------

set.seed(2)
train = sample(392, 196)

print("-----------------------------------------------------------------------")
print("Error rate for seed value 2, in order of linear, quadratic, cubic")
print("-----------------------------------------------------------------------")

lm.fit = lm(mpg~horsepower, data = Auto, subset = train)
mean((mpg-predict(lm.fit, Auto))[-train]^2)

lm.fit2 = lm(mpg~poly(horsepower, 2), data = Auto, subset = train)
mean((mpg-predict(lm.fit2, Auto))[-train]^2)

lm.fit3 = lm(mpg~poly(horsepower, 3), data = Auto, subset = train)
mean((mpg-predict(lm.fit3, Auto))[-train]^2)

#-------------------------------------------------------------------------------
#        Leave One Out Cross-Validation
#-------------------------------------------------------------------------------

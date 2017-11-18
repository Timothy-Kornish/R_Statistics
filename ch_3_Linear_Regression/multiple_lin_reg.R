#-------------------------------------------------------------------------------
#                 Multiple Linear Regression
#
# for multiple linear regression moder using least squares, use lm()
# lm(y~x1+x2+x3) for 3 predictors x1, x2, and x3
# lm(y~.) for all predictors in data set
# lm(y~.-x1) for all predictors but x1 in data set
#-------------------------------------------------------------------------------

library(MASS)
library(ISLR)
library(car)

attach(Boston)

# model for both lstat and age
lm.fit = lm(medv~lstat+age, data = Boston)

print("------==============------")
summary(lm.fit)

print("------==============------")
# model for all predictors
lm.fit = lm(medv~., data = Boston)
summary(lm.fit)

print("------==============------")
print("R^2 value:")
summary(lm.fit)$r.sq

print("------==============------")
print("sigma (RSE - Residual Standard Error) value:")
summary(lm.fit)$sigma

print("------==============------")
print("vif (variance inflation factors) value for each predictor:")
vif(lm.fit)

print("------==============------")
print("summary of all predictors except age")
lm.fit1 = lm(medv~.-age, data = Boston)
summary(lm.fit1)

print("------==============------")
print("summary of all predictors except age, using update fuction")
lm.fit1 = update(lm.fit, ~.-age)
summary(lm.fit1)

#-------------------------------------------------------------------------------
#         Interaction Terms
# lm(y~x1+x2+x1:x2) where x1:x2 is the interaction term between x1 and 2
# this also include x1 and x2.
# lm(y~x1*x2) does the same in a shorthand syntax
#-------------------------------------------------------------------------------

print("------==============------")
print("summary of boston dataframe with lstat, age, and lstat-age interaction term")
summary(lm(medv~lstat*age, data = Boston))

#-------------------------------------------------------------------------------
#         Non-Linear Transformation of the Predictors
# low p-value means the model represents reality
#-------------------------------------------------------------------------------

print("------==============------")
lm.fit2 = lm(medv~lstat+I(lstat^2))
summary(lm.fit2)

print("------==============------")
lm.fit = lm(medv~lstat)
anova(lm.fit, lm.fit2)

png("non-linear.png")
par(mfrow=c(2,2))
plot(lm.fit2)
dev.off()

#-------------------------------------------------------------------------------
#        Polynomial and Logarithmic Fit
#-------------------------------------------------------------------------------

lm.fit5 = lm(medv~poly(lstat, 5))

print("------==============------")
print("5 degree polynomial fit summary on Boston Data, notice p-value increasing")
summary(lm.fit5)

print("------==============------")
print("Logarithmic fit summary on Boston Data")
summary(lm(medv~log(rm), data = Boston))

#-------------------------------------------------------------------------------
#        Qualitative Predictors
#
# contrasts(): returns the coding that R uses for the dummy variables.
#-------------------------------------------------------------------------------

print("------==============------")
print("names in carseats data set")
names(Carseats)

lm.fit = lm(Sales~.+Income:Advertising+Price:Age, data = Carseats)

print("------==============------")
print("summary of carseats dataframes with two interaction terms:")
summary(lm.fit)

attach(Carseats)

print("------==============------")
print("Shelveloc dummy variables:")
contrasts(ShelveLoc)

#-------------------------------------------------------------------------------
#        Simple Function
#-------------------------------------------------------------------------------

LoadLibraries = function(){
library(ISLR)
library(MASS)
print("------==============------")
print("The libraries have been loaded.")
}

LoadLibraries()

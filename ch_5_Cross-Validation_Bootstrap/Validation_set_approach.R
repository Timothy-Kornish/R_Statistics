library(ISLR)
library(boot)

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

glm.fit = glm(mpg~horsepower, data = Auto)
print("-----------------------------------------------------------------------")
print("coefficient of fitted data mpg vs horsepower (using glm, without family = binomial)")
coef(glm.fit)

glm.fit = lm(mpg~horsepower, data = Auto)
print("-----------------------------------------------------------------------")
print("coefficient of fitted data mpg vs horsepower (using lm, notice results are identical)")
coef(glm.fit)
print("-----------------------------------------------------------------------")

#-------------------------------------------------------------------------------
#         Cross-Validation Generalized Linear Model:     cv.glm()
#
# comes from boot library
#-------------------------------------------------------------------------------

glm.fit = glm(mpg~horsepower, data = Auto)
cv.err = cv.glm(Auto, glm.fit)
print("Cross-Validation error, notice values of delta are identical to 2 decimals points")
cv.err$delta
print("-----------------------------------------------------------------------")


#-------------------------------------------------------------------------------
#         Cross-Validation For Increasing Polynomial Fits
#-------------------------------------------------------------------------------

cv.error = rep(0:5)

for (i in 1:5) {
  glm.fit = glm(mpg~poly(horsepower, i), data = Auto)
  cv.error[i] = cv.glm(Auto, glm.fit)$delta[1]
}
print("Cross-validation error for polynomial fit degree 1:5")
cv.error
print("-----------------------------------------------------------------------")

#-------------------------------------------------------------------------------
#         K-Fold Cross Validation
#-------------------------------------------------------------------------------

set.seed(17)

cv.error = rep(0:10)

for (i in 1:10) {
  glm.fit = glm(mpg~poly(horsepower, i), data = Auto)
  cv.error[i] = cv.glm(Auto, glm.fit, K = 10)$delta[1]
}
print("K-fold Cross-validation error for polynomial fit degree 1:10 for k = 10")
cv.error
print("notice that k-fold cv takes less computation time, and error barely")
print("changes after quadratic polynomial")
print("-----------------------------------------------------------------------")

#-------------------------------------------------------------------------------
#                       The Bootstrap
#
#    The bootstrap approach can be used to assess the variability of the
#    coefficient estimates and predictions from a statistical learning method.
#
#    i.e. the slope and intercept variability
#
#    Performing a bootstrap analysis in R entails only two steps.
#
# 1) we must create a function that computes the statistic of interest.
#
# 2) we use the boot() function, which is part of the boot library,
#    to perform the bootstrap by repeatedly sampling observations
#    from the data set with replacement.
#
#
#    boot(): automates computing alpha over and over with alpha.fn
#
#-------------------------------------------------------------------------------


alpha.fn = function(data, index) {
    X = data$X[index]
    Y = data$Y[index]
    return((var(Y) - cov(X, Y)) / (var(X) + var(Y) - 2 * cov(X, Y)))
}

print("Estimating alpha using 100 observations")
alpha.fn(Portfolio, 1:100)
print("-----------------------------------------------------------------------")

set.seed(1)
print("Estimating alpha using 100 observations, with sample method")
alpha.fn(Portfolio, sample(100, 100, replace = TRUE))
print("-----------------------------------------------------------------------")

boot(Portfolio, alpha.fn, R = 1000)
print("-----------------------------------------------------------------------")


boot.fn = function(data, index) {
    return (coef(lm(mpg~horsepower, data = data, subset = index)))
}

boot.fn(Auto, 1:392)

set.seed(1)
boot.fn(Auto, sample(392, 392, replace = TRUE))
boot.fn(Auto, sample(392, 392, replace = TRUE))

boot(Auto, boot.fn, 1000)
summary(lm(mpg~horsepower ,data=Auto))$coef


boot.fn = function(data, index) {
  coefficients(lm(mpg~horsepower+I(horsepower^2), data = data, subset = index))
}

set.seed(1)
boot(Auto, boot.fn, 1000)
summary(lm(mpg~horsepower+I(horsepower^2) ,data=Auto))$coef

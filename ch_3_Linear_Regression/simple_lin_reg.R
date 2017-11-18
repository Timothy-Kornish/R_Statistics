#-------------------------------------------------------------------------------
#                 Simple Linear Regression
#
#     install packages via command line:
#     install ISLR package:           R, install.packages("ISLR")
#-------------------------------------------------------------------------------
library(MASS)
library(ISLR)

print("------==============------")
names(Boston)
print("------==============------")

lm.fit = lm(medv~lstat, data = Boston)

summary(lm.fit)
print("------==============------")

names(lm.fit)
print("------==============------")

print("Coefficient of Boston Data")
coef(lm.fit)
print("------==============------")

print("95% Confidence intervals, for prediction of medv of a given lstat: 5, 10, and 15")
predict(lm.fit, data.frame(lstat = c(5, 10, 15)), interval= "confidence")
print("------==============------")

print("95% Prediction intervals, for prediction of medv of a given lstat: 5, 10, and 15")
print("both intervals centered at same point, prediciton has wider intervals")
predict(lm.fit, data.frame(lstat = c(5, 10, 15)), interval= "prediction")
print("------==============------")

#-------------------------------------------------------------------------------
#           Linear Regression Plots
# lwd: line-width
# pch: plotting symbols, 20 different symbols can be accessed numerically
#-------------------------------------------------------------------------------

png("least_squares_reg_1.png")
plot(Boston$lstat, Boston$medv)
abline(lm.fit)
dev.off()

attach(Boston)

png("least_squares_reg_2.png")
plot(lstat, medv, main = "Boston Data Frame")
abline(lm.fit)
dev.off()

png("least_squares_reg_3.png")
plot(lstat, medv, main = "Boston Data Frame")
abline(lm.fit, lwd = 3, col = "red")
dev.off()

png("least_squares_reg_4.png")
plot(lstat, medv, col = "blue", pch = 10,  main = "Boston Data Frame")
abline(lm.fit, lwd = 3, col = "red")
dev.off()

png("least_squares_reg_5.png")
plot(lstat, medv, col = "blue", pch = "+",  main = "Boston Data Frame")
abline(lm.fit, lwd = 3, col = "red")
dev.off()

png("least_squares_reg_6.png")
plot(lstat, medv, col = "blue", pch = 1:20,  main = "Boston Data Frame")
abline(lm.fit, lwd = 3, col = "red")
dev.off()

#-------------------------------------------------------------------------------
#           Diagnostic Plots
# par(mfrow = c(2, 2)): creates 4 plots in a 2 by 2 grid
# will auto fill in titles and axis labels
#-------------------------------------------------------------------------------

png("Diagnostic_plot.png")
par(mfrow=c(2,2))
plot(lm.fit)
dev.off()

#-------------------------------------------------------------------------------
#           Residuals Plots
# residuals(): computes residuals of linear regression fit
# rstudents(): returns studentized residuals
#-------------------------------------------------------------------------------

png("residuals.png")
plot(predict(lm.fit), residuals(lm.fit))
dev.off()

png("student_residuals.png")
plot(predict(lm.fit), rstudent(lm.fit))
dev.off()

#-------------------------------------------------------------------------------
#           Leverage Statistics plots
# hatvalues(): computes leverage statistics for any number of predictors
# which.max(): identifies the index of largest element in a vector
#-------------------------------------------------------------------------------

png("Leverage_statistics.png")
plot(hatvalues(lm.fit))
dev.off()

print("Largest hat-value (leverage statistic) index:")
which.max(hatvalues(lm.fit))

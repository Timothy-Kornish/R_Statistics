library(ISLR)

attach(Smarket)

#-------------------------------------------------------------------------------
#             Logistic Regression
# glm(): generalized linear model
#        family = binomial makes the model a logistic regression model
#-------------------------------------------------------------------------------

glm.fit = glm(Direction~Lag1+Lag2+Lag3+Lag4+Lag5+Volume, data = Smarket, family = binomial)
print("------------------------------------------------")
print("Summary of logistic regression model on stock market data frame: ")
summary(glm.fit)

print("------------------------------------------------")
print("P-value of Lag1 is smallest, coeff being negative suggests a positive")
print("return yesterday means, it is less likely to go up today")
print("however, p = 0.145 is large and suggests no clear evidence for real association")
print("Between Lag1 and direction (up/down) of stock market")
print("------------------------------------------------")

print("Coefficients for each preceding day and volume in the stock market")
coef(glm.fit)
print("------------------------------------------------")

print("Coefficients for each preceding day and volume in the stock market using summary()")
summary(glm.fit)$coef
print("------------------------------------------------")
summary(glm.fit)$coef[, 4]
print("------------------------------------------------")

print("First ten probabilites of market going up")
glm.probs = predict(glm.fit, type = "response")
glm.probs[1:10]
contrasts(Direction)
print("------------------------------------------------")

#-------------------------------------------------------------------------------
#             predicting the direction of the market
#-------------------------------------------------------------------------------

glm.pred = rep("Down", 1250)
glm.pred[glm.probs>0.5] = "Up"

print("table of predictions vs real values of stock market")
print("Diagonal elements show correct predictions, off-diagonal are incorrect")
table(glm.pred, Direction)
print("------------------------------------------------")

print("correct predictions (mean): (145 + 507) / 1250 = 0.5216 i.e. 52.16% accuracy")
mean(glm.pred==Direction)
print("47.84% error rate, that's really bad!!")
print("------------------------------------------------")

#-------------------------------------------------------------------------------
#             Training the model to better fit the data
#
# make a glm.fit now on the trained vector (subset of data)
# rather than all the data in Smarket data set
#-------------------------------------------------------------------------------

train = (Year<2005) # vector of 1250 elements
Smarket.2005=Smarket[!train, ]
print("dimensions of training set")
dim(Smarket.2005)
print("------------------------------------------------")

Direction.2005 = Direction[!train]

glm.fit = glm(Direction~Lag1+Lag2+Lag3+Lag4+Lag5+Volume, data = Smarket,
              family = binomial, subset = train)

glm.probs = predict(glm.fit, Smarket.2005, type = "response")
glm.pred = rep("Down", 252)
glm.pred[glm.probs>0.5] = "Up"

print("table of predictions vs real values")
table(glm.pred, Direction.2005)
print("------------------------------------------------")

print("error rate: ")
mean(glm.pred!=Direction.2005)
print("52% error rate is worse than before and worse than random guessing!")
print("------------------------------------------------")

#-------------------------------------------------------------------------------
#             Training the model to better fit the data
#
# only Lag1 and Lag2 had reasonable p-vaues, remove the rest to try and improve model
#-------------------------------------------------------------------------------

glm.fit = glm(Direction~Lag1+Lag2, data = Smarket, family = binomial, subset = train)

glm.probs = predict(glm.fit, Smarket.2005, type = "response")
glm.pred = rep("Down", 252)
glm.pred[glm.probs>0.5] = "Up"

print("table of predictions vs real values")
table(glm.pred, Direction.2005)
print("------------------------------------------------")

print("error rate: ")
mean(glm.pred!=Direction.2005)
print("44% error rate is an improvement but still not great")
print("------------------------------------------------")

predict(glm.fit, newdata = data.frame(Lag1 = c(1.2, 1.5), Lag2 = c(1.1, -0.8)),
        type = "response")

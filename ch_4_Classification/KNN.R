library(class)
library(ISLR)
library(MASS)


#-------------------------------------------------------------------------------
#            K Nearest Neighbors
#
#   Requires 4 inputs:
#
#   1. A matrix containing the predictors associated with the training data,
#   labeled train.X below.
#
#   2. A matrix containing the predictors associated with the data for which we wish
#   to make predictions, labeled test.X below.
#
#   3. A vector containing the class labels for the training observations,
#   labeled train.Direction below.
#
#   4. A value for K, the number of nearest neighbors to be used by the classifier.
#
#
#   cbind(): column bind, binds columns Lag1 and Lag2 together
#            into two matrices for train and test
#-------------------------------------------------------------------------------


attach(Smarket)
train = (Year<2005) # vector of 1250 elements
Smarket.2005 = Smarket[!train, ]
Direction.2005 = Direction[!train]

train.X = cbind(Lag1, Lag2)[train, ]
test.X = cbind(Lag1, Lag2)[!train, ]

train.Direction = Direction[train]

set.seed(1)
knn.pred = knn(train.X, test.X, train.Direction, k = 1)

print("------------------------------------------------")
print("table of KNN predictions using k = 1 vs real values: ")
table(knn.pred, Direction.2005)
print("------------------------------------------------")
print("error rate: ")
mean(knn.pred != Direction.2005)

knn.pred = knn(train.X, test.X, train.Direction, k = 3)

print("------------------------------------------------")
print("table of KNN predictions using k = 3 vs real values: ")
table(knn.pred, Direction.2005)
print("------------------------------------------------")
print("error rate: ")
mean(knn.pred != Direction.2005)
print("slight improvement increasing k from 1 to 3, going further turns out to provide no further improvements")
print("------------------------------------------------")

#-------------------------------------------------------------------------------
#       Caravan Insurance Data using KNN
#-------------------------------------------------------------------------------

print("Dimension of Caravan data set: ")
dim(Caravan)
print("------------------------------------------------")
attach(Caravan)
print("Number of people who purchased caravan insurance:")
summary(Purchase)
print("------------------------------------------------")
print("Percentage of people who purchased caravan insurance:")
print(348/5822 *100)
print("------------------------------------------------")

#-------------------------------------------------------------------------------
#       Standardizing the scale of variables
#
# important for KNN to make mean 0 ans std. dev. 1 for both so KNN treats changes equally
#-------------------------------------------------------------------------------

standardized.X = scale(Caravan[, -86]) # don't include column 86, but use the represented

print("variance of caravan column 1 & 2 values before standardization:")
var(Caravan[, 1])
var(Caravan[, 2])
print("------------------------------------------------")
print("variance of caravan column 1 & 2 values after standardization:")
var(standardized.X[, 1])
var(standardized.X[, 2])
print("------------------------------------------------")

#-------------------------------------------------------------------------------
#           Fitting KNN training model with standardized values
#-------------------------------------------------------------------------------

test = 1:1000
train.X = standardized.X[-test, ]
test.X = standardized.X[test, ]

train.Y = Purchase[-test]
test.Y = Purchase[test]

set.seed(1)

knn.pred = knn(train.X, test.X, train.Y, k = 1)
print("error rate on standardized knn model for predictions")
mean(test.Y != knn.pred)
print("------------------------------------------------")
print("Always predicting people don't have insurance ")
mean(test.Y != "No")
print("------------------------------------------------")

print("table of KNN predictions, k = 1 vs real test values: ")
table(knn.pred, test.Y)
print("Success rate for k = 1:")
print(9 / (9 + 68))
print("------------------------------------------------")

knn.pred = knn(train.X, test.X, train.Y, k = 3)
print("table of KNN predictions, k = 3 vs real test values: ")
table(knn.pred, test.Y)
print("Success rate for k = 3:")
print(5 / (5 + 21))
print("------------------------------------------------")

knn.pred = knn(train.X, test.X, train.Y, k = 5)
print("table of KNN predictions, k = 5 vs real test values: ")
table(knn.pred, test.Y)
print("Success rate for k = 5:")
print(4 / (4 + 11))
print("------------------------------------------------")

#-------------------------------------------------------------------------------
#           GLM fitting with 25% cut-off instead of 50%
#           Using a Logistic Model
#-------------------------------------------------------------------------------

glm.fit = glm(Purchase~., data = Caravan, family = binomial, subset = -train)

glm.probs = predict(glm.fit, Caravan[test, ], type = "response")

glm.pred = rep("No", 1000)
glm.pred[glm.probs > 0.5] = "Yes"
print("GLM table for 50%, 0% accuracy on purchases")
table(glm.pred, test.Y)

glm.pred = rep("No", 1000)
glm.pred[glm.probs > 0.25] = "Yes"
print("GLM table for 25%, 40.6% accuracy on purchases")
table(glm.pred, test.Y)

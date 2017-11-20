library(ISLR)
library(MASS)

#-------------------------------------------------------------------------------
#            Quadratic Discriminant Analysis
#-------------------------------------------------------------------------------

attach(Smarket)

train = (Year<2005) # vector of 1250 elements
Smarket.2005 = Smarket[!train, ]
Direction.2005 = Direction[!train]

qda.fit = qda(Direction~Lag1+Lag2, data = Smarket, subset = train)
print("------------------------------------------------")
print("QDA fit")
qda.fit

qda.class = predict(qda.fit, Smarket.2005)$class
print("------------------------------------------------")
print("table of QDA predictions vs real values: ")
table(qda.class, Direction.2005)

print("------------------------------------------------")
print("Error rate down to 40% showing further improvement in model from LDA and logistic Regression")
mean(qda.class != Direction.2005)

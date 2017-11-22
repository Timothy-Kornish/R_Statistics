library(MASS)
library(tree)
library(randomForest)

#-------------------------------------------------------------------------------
#             Bagging and Random Forests
#-------------------------------------------------------------------------------

set.seed(1)

train = sample(1:nrow(Boston), nrow(Boston)/2)
tree.boston = tree(medv~., data = Boston, subset = train)
boston.test = Boston[-train, "medv"]

bag.boston = randomForest(medv~., data = Boston, subset = train, mtry = 13, importance = TRUE)

print("-----------------------------------------------------------------------")
print("bag.boston info")
bag.boston
print("-----------------------------------------------------------------------")

yhat.bag = predict(bag.boston, newdata = Boston[-train, ])

png("Random_Forest.png")
plot(yhat.bag, boston.test)
abline(0, 1)
dev.off()
print("-----------------------------------------------------------------------")
print("MSE for bagging:")
mean((yhat.bag - boston.test)^2)
print("-----------------------------------------------------------------------")


set.seed(1)
rf.boston = randomForest(medv~., data = Boston, subset = train, mtry = 6, importance = TRUE)
yhat.rf = predict(rf.boston, newdata = Boston[-train, ])

print("MSE for random forest:")
mean((yhat.rf - boston.test)^2)
print("-----------------------------------------------------------------------")

importance(rf.boston)
print("-----------------------------------------------------------------------")

png("importance_measure_plot.png")
varImpPlot(rf.boston)
dev.off()

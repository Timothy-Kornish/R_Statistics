library(MASS)
library(tree)
library(gbm)

#-------------------------------------------------------------------------------
#                     Boosting
#-------------------------------------------------------------------------------

set.seed(1)

train = sample(1:nrow(Boston), nrow(Boston)/2)
tree.boston = tree(medv~., data = Boston, subset = train)
boston.test = Boston[-train, "medv"]

boost.boston = gbm(medv~., data = Boston[train, ], distribution = "gaussian",
                   n.trees = 5000, interaction.depth = 4)

print("-----------------------------------------------------------------------")
print("Summary of a boosted forest with 5000 trees")
summary(boost.boston)

par(mfrow = c(1,2))
png("Partial_dependence_rm.png")
plot(boost.boston, i = "rm")
dev.off()

png("Partial_dependence_lstat.png")
plot(boost.boston, i = "lstat")
dev.off

#-------------------------------------------------------------------------------
#            Boosted model used to predict medv on test set
#-------------------------------------------------------------------------------

yhat.boost = predict(boost.boston, newdata = Boston[-train, ], n.tree = 5000)

print("-----------------------------------------------------------------------")
print("MSE on boosted model")
mean((yhat.boost - boston.test)^2)
print("MSE down from 23% to 11.8% due to boosting")
print("-----------------------------------------------------------------------")


boost.boston = gbm(medv~., data = Boston[train, ], distribution = "gaussian", n.trees = 5000,
                   interaction.depth = 4, shrinkage = 0.2, verbose = FALSE)
yhat.boost = predict(boost.boston, newdata = Boston[-train, ], n.trees = 5000)

print("MSE on boosted model with shrinkage lambda = 0.2, little better than default lambda = 0.001")
mean((yhat.boost - boston.test)^2)
print("MSE down from 11.8% to 11.4% due to boosting")
print("-----------------------------------------------------------------------")

library(MASS)
library(tree)


#-------------------------------------------------------------------------------
#             Fitting Regression Trees
#-------------------------------------------------------------------------------

set.seed(1)

train = sample(1:nrow(Boston), nrow(Boston)/2)
tree.boston = tree(medv~., data = Boston, subset = train)

print("-----------------------------------------------------------------------")
print("Summary of boston tree")
summary(tree.boston)
print("-----------------------------------------------------------------------")

png("tree_diagram_boston.png")
plot(tree.boston)
text(tree.boston, pretty = 0)
dev.off()

#-------------------------------------------------------------------------------
#             Cross-Validation on most complex tree
#-------------------------------------------------------------------------------

cv.boston = cv.tree(tree.boston)

png("Cross_Validation_Regression_tree.png")
plot(cv.boston$size, cv.boston$dev, type = 'b')
dev.off()

#-------------------------------------------------------------------------------
#             Pruning Tree to 5 Nodes
#-------------------------------------------------------------------------------

prune.boston = prune.tree(tree.boston, best = 5)
png("Pruned_Regression_Tree_5_Nodes.png")
plot(prune.boston)
text(prune.boston, pretty = 0)
dev.off()

#-------------------------------------------------------------------------------
#             Cross-Validation results
#-------------------------------------------------------------------------------

yhat = predict(tree.boston, newdata = Boston[-train,])
boston.test = Boston[-train, "medv"]

png("Pruned_Regression_Tree_5_Nodes.png")
plot(yhat, boston.test)
abline(0, 1)
dev.off()

print("-----------------------------------------------------------------------")
print("Error rate")
print(mean(yhat -boston.test)^2)
print("-----------------------------------------------------------------------")

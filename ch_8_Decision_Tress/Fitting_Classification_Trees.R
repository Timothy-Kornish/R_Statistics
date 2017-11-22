library(tree)
library(ISLR)


#-------------------------------------------------------------------------------
#             Fitting Classification Trees
#-------------------------------------------------------------------------------

attach(Carseats)
High = ifelse(Sales <= 8, "No", "Yes")

Carseats = data.frame(Carseats, High)

tree.carseats = tree(High~.-Sales, data = Carseats)
print("-----------------------------------------------------------------------")
print("Summary of carseats tree")
summary(tree.carseats)
print("-----------------------------------------------------------------------")

png("tree_diagram_carseats.png")
plot(tree.carseats)
text(tree.carseats, pretty = 0)
dev.off()

print("-----------------------------------------------------------------------")
print("Summary of carseats tree")
tree.carseats
print("-----------------------------------------------------------------------")


set.seed(2)
train = sample(1:nrow(Carseats), 200)
Carseats.test = Carseats[-train, ]
High.test = High[-train]

tree.carseats = tree(High~.-Sales, data = Carseats, subset = train)
tree.pred = predict(tree.carseats, Carseats.test, type = "class")

print("table carseats tree prediction")
table(tree.pred, High.test)
print("-----------------------------------------------------------------------")
print("error test rate from table")
print(mean(tree.pred != High.test))
print("-----------------------------------------------------------------------")

#-------------------------------------------------------------------------------
#             Pruning the Tree for improved results
#
# FUN = prune.misclass:
#           used to indicate that we want the classification error rate
#           to guide the cross-validation and pruning process, rather
#           than the default for the cv.tree() function, which is deviance
#-------------------------------------------------------------------------------

set.seed(3)
cv.carseats = cv.tree(tree.carseats, FUN=prune.misclass)

print("Names of cv.carseats columns")
names(cv.carseats)
print("-----------------------------------------------------------------------")
print("values for cv.carseats columns")
cv.carseats
print("-----------------------------------------------------------------------")

par(mfrow = c(1,2))

png("Cross_Validation_Errors_size.png")
plot(cv.carseats$size, cv.carseats$dev, type = "b")
dev.off()

png("Cross_Validation_Errors_k.png")
plot(cv.carseats$k, cv.carseats$dev, type = "b")
dev.off()

#-------------------------------------------------------------------------------
#             Pruned Tree 9 Terminal Nodes
#-------------------------------------------------------------------------------

prune.carseats = prune.misclass(tree.carseats, best = 9)
png("Pruned_Classification_tree_9_nodes.png")
plot(prune.carseats)
text(prune.carseats, pretty = 0)
dev.off()

# testing if pruning helped the error rate

tree.pred = predict(prune.carseats, Carseats.test, type = "class")
print("-----------------------------------------------------------------------")
print("Table of pruned tree with 9 terminal nodes")
table(tree.pred, High.test)
print("-----------------------------------------------------------------------")
print("error test rate from table")
print(mean(tree.pred != High.test))
print("test error down from 28.5% to 23%, while improving interpretability")

#-------------------------------------------------------------------------------
#             Pruned Tree 15 Terminal Nodes
#-------------------------------------------------------------------------------

prune.carseats = prune.misclass(tree.carseats, best = 15)
png("Pruned_Classification_tree_15_nodes.png")
plot(prune.carseats)
text(prune.carseats, pretty = 0)
dev.off()

# testing if pruning helped the error rate

tree.pred = predict(prune.carseats, Carseats.test, type = "class")
print("-----------------------------------------------------------------------")
print("Table of pruned tree with 15 terminal nodes")
table(tree.pred, High.test)
print("-----------------------------------------------------------------------")
print("error test rate from table")
print(mean(tree.pred != High.test))
print("test error up from 23% to 26% going from 9 nodes to 15 nodes: lower classification accuracy")

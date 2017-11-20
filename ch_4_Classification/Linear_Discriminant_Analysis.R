library(ISLR)
library(MASS)


#-------------------------------------------------------------------------------
#             Linear Discriminant Analysis
#-------------------------------------------------------------------------------

attach(Smarket)

train = (Year<2005) # vector of 1250 elements
Smarket.2005 = Smarket[!train, ]
Direction.2005 = Direction[!train]

lda.fit = lda(Direction~Lag1+Lag2, data = Smarket, subset = train)

print("Linear Discriminant Analysis on Stock market data set")
lda.fit
print("------------------------------------------------")

png("LDA_fit.png")
plot(lda.fit)
dev.off()

lda.pred = predict(lda.fit, Smarket.2005)

print("Names of columns in LDA prediction")
names(lda.pred)
print("------------------------------------------------")

lda.class = lda.pred$class

print("table of LDA predictions vs real values: ")
table(lda.class, Direction.2005)
print("error rate")
mean(lda.class != Direction.2005)

# Recreating values in lda.pred$class

sum(lda.pred$posterior[ ,1] >= 0.5)
sum(lda.pred$posterior[ ,1] < .5)

print("------------------------------------------------")
print("values of predictons")
lda.pred$posterior[1:20, 1]

print("------------------------------------------------")
print("Values represented as Direction of Stock market (up/down)")
lda.class[1:20]

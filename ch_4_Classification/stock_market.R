library(ISLR)


print("Names of columns in Stock market dataframe:  ")
names(Smarket)
print("------------------------------------------------")

print("dimension of stock market dataframe:  ")
dim(Smarket)
print("------------------------------------------------")

print("Summary of Stock market dataframe")
summary(Smarket)
print("------------------------------------------------")

print("correlatoin matrix of stock market: (void direction as they are qualtitative values)")
cor(Smarket[,-9])

png("Stock_Market_volumes.png")
attach(Smarket)
plot(Volume)
dev.off()

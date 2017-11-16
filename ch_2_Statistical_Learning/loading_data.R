#-------------------------------------------------------------------------------
#                        Loading Data in R
#
#         read.table() brings in Data from a file
#         write.table exports data into a new file
#-------------------------------------------------------------------------------

Auto = read.table("Auto.data", header = TRUE, na.strings = "?")
dim(Auto)

Auto = read.csv("Auto.csv", header = TRUE, na.strings="?")

dim(Auto)
print("Auto data frame head")
print(head(Auto))

print("-------===============--------")
print("Data frame all columns on first 4 rows")
print(Auto[1:4, ])

print("-------===============--------")
print("Omitting rows with missing data: Auto = na.omit(Auto)")
Auto = na.omit(Auto)
print(dim(Auto))

print("-------===============--------")
print("Data frame, all columns names: ")
print(names(Auto))

#-------------------------------------------------------------------------------
#       Grabbing object variables from data frame
#
# attach(Auto) makes auto variables directly accessible
#-------------------------------------------------------------------------------

png("Cylinder_vs_mpg_way1.png")
plot(Auto$cylinders, Auto$mpg)
dev.off()

png("Cylinder_vs_mpg_way2.png")
attach(Auto)
plot(cylinders, mpg)
dev.off()

#-------------------------------------------------------------------------------
#         converting quantitative data to qualitative Data
#         i.e. numerical to categorical
#         makes plots from scatter into box-and-whisker plots
#-------------------------------------------------------------------------------

cylinders = as.factor(cylinders)

png("Cylinders_1.png")
plot(cylinders, mpg, main = "Cylinders vs MPG")
dev.off()

png("Cylinders_2.png")
plot(cylinders, mpg, col = "red", main = "Cylinders vs MPG")
dev.off()

png("Cylinders_3.png")
plot(cylinders, mpg, col = "red", varwidth = TRUE, main = "Cylinders vs MPG")
dev.off()

png("Cylinders_4.png")
plot(cylinders, mpg, col = "red", varwidth = TRUE, horizontal = T, main = "MPG vs Cylinders")
dev.off()

png("Cylinders_5.png")
plot(cylinders, mpg, col = "red", varwidth = TRUE, xlab = "cylinders", ylab = "MPG", main = "Cylinders vs MPG")
dev.off()

#-------------------------------------------------------------------------------
#                     histograms
#                     breaks are analogous to number of bins in python
#-------------------------------------------------------------------------------

png("mpg_hist_1.png")
hist(mpg)
dev.off()

png("mpg_hist_2.png")
hist(mpg, col = 2)
dev.off()

png("mpg_hist_3.png")
hist(mpg, col = 2, breaks = 15)
dev.off()

#-------------------------------------------------------------------------------
#                   pairs()
#                i.e. scatterplot matrix for every pair of variables
#-------------------------------------------------------------------------------

jpeg("scatter_plot_matrix.jpeg")
pairs(Auto)
dev.off()

jpeg("scatter_plot_matrix_subset.jpeg")
pairs(~ mpg + displacement + horsepower + weight + acceleration, Auto)
dev.off()

jpeg("scatter_plot_matrix.jpeg")
pairs(Auto)
dev.off()

#-------------------------------------------------------------------------------
#                identify()
#-------------------------------------------------------------------------------

png("horsepower_vs_mpg_plot.png")
plot(horsepower, mpg)
dev.off()

png("horsepower_vs_mpg_identify.png")
plot(horsepower, mpg)
identify(horsepower, mpg, name)
dev.off()

#-------------------------------------------------------------------------------
#                summary()
#-------------------------------------------------------------------------------
print("-------===============--------")
print("Summary of Auto.csv file")
print(summary(Auto))
print("-------===============--------")
print("Summary of mpg in Auto.csv file")
print(summary(mpg))

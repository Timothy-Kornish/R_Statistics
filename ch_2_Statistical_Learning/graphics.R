#-------------------------------------------------------------------------------
#                     Plotting graphics in R
#              plots get saved and must be opened manually
#-------------------------------------------------------------------------------

x = rnorm(100)
y = rnorm(100)
png("Figure1.png")
plot(x, y)
dev.off()
jpeg("fig.jpeg")
plot(x, y, xlab = "x-axis label", ylab = "y-axis label", main = "Plot of X vs. Y" )
dev.off()


#-------------------------------------------------------------------------------
#                            Sequences
#-------------------------------------------------------------------------------

a = seq(1, 10)
b = seq(0, 1, length = 20)
c = 1:100
print("--------------------")
print(a)
print("--------------------")
print(b)
print("--------------------")
print(c)

#-------------------------------------------------------------------------------
#                         Contour Plotting
#-------------------------------------------------------------------------------

x = seq(-pi, pi, length = 50)
y = x

f = outer(x, y, function(x, y) cos(y)/(1 + x^2))
png("contour1.png")
contour(x, y, f)
contour(x, y, f, nlevels = 45, add = T)
dev.off()

fa = (f -t(f))/2
png("contour2.png")
contour(x, y, fa, nlevels = 15)
dev.off()

#-------------------------------------------------------------------------------
#                        3-D image Plotting
#-------------------------------------------------------------------------------

png("image.png")
image(x, y, fa)
dev.off()

png("persp1.png")
persp(x, y, fa)
dev.off()

png("persp2.png")
persp(x, y, fa, theta = 30)
dev.off()

png("persp3.png")
persp(x, y, fa, theta = 30, phi = 20)
dev.off()

png("persp4.png")
persp(x, y, fa, theta = 30, phi = 40)
dev.off()

png("persp5.png")
persp(x, y, fa, theta = 30, phi = 70)
dev.off()

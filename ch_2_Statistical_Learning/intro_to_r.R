# Learning Concatenation with the function c(), this creates a vector of values
# can use <- and = interchangeably for assigning a value

x <- c(1, 2, 3, 5)
y <- c(1, 4, 3)

a = length(x)
b = length(y)

print (a)
print (b)
print("listing all objects created thus far")
ls()
print("Removing x and y, keeping a and b")
rm (x, y)
ls()
print("Removing all objects at once")
rm(list = ls())
ls()

print("---------------------")
print("printing info about matrix() function, press q to quit ")
?matrix()

print("---------------------")
print("print matrix mat")
mat = matrix(data = c(1,2,3,4), nrow = 2, ncol = 2)
# mat = matrix(c(1,2,3,4), 2, 2) will work as well
print(mat)

print("---------------------")
print("print matrix mat2, same as mat but using byrow = TRUE")
print("this fills the matrix by in order of rows instead of by columns as the default")
mat2 = matrix(c(1,2,3,4), 2, 2, byrow=TRUE)
print(mat2)

print("---------------------")
print("print square root for each value in matrix mat: sqrt(mat)")
print(sqrt(mat))

print("---------------------")
print("print squared value of each element in matrix mat: mat^2")
print(mat^2)

print("---------------------")
print("rnorm(n) function for a vector of random normal variables, n is an integer")
print("default mean and sd are 0 and 1 respectively")
r = rnorm(50)
r2 = r + rnorm(50, mean = 50, sd = .1)
print(r)
print("---------------------")
print(r2)
print("---------------------")
print("finding correlation between x and y: using cor(r, r2)")
print(cor(r, r2))

print("---------------------")
print("Using seed value for same random numbers every time:")
set.seed(1303)
r3 = rnorm(50)
print(r3)

print("---------------------")
print("print mean, standard deviation, and variance of vector:")
print("variance is sd squared")
y = rnorm(100)
print(c("mean: ", mean(y)))
print(c("sd: ", sd(y)))
print(c("sd using sqrt(var()): ", sqrt(var(y))))
print(c("var: ", var(y)))
# have to use c() to print an int with a string

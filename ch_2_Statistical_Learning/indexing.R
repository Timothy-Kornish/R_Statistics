#-------------------------------------------------------------------------------
#                        Indexing Matrix Data in R
#-------------------------------------------------------------------------------

A = matrix(1:16, 4, 4)
print("Matrix A")
print("-------===========--------")
print(A)

print("-------===========--------")
print(c("value at row 2, column 3 is A[2,3]: ", A[2,3]))

print("-------===========--------")
print("rows 1 and 3 with and columns 2 and 4: A[c(1,3), c(2,4)] = ")
print(A[c(1,3), c(2,4)])

print("-------===========--------")
print("rows 1 to 3 and columns 2 to 4: A[1:3, 2:4] = ")
print(A[1:3, 2:4])

print("-------===========--------")
print("rows 1 and 2 for all columns: A[1:2, ] = ")
print(A[1:2, ])

print("-------===========--------")
print("all rows with columns 1 and 2: A[1:2, ] = ")
print(A[ , 1:2])

print("-------===========--------")
print("all of row 1: A[1, ] = ")
print(A[1, ])

print("-------===========--------")
print("all rows excluding 1 and 3: A[-c(1,3), ] = ")
print(A[-c(1,3), ])

print("-------===========--------")
print("dimensions of matrix A = ")
print(dim(A))

10 + 5 # addition

1:250 # prints numbers 1 to 250 across several lines

print("Hello World!") # print "Hello World!" in console

# variables
x <- 1:5 # put the numbers 1-5 in the variable x
x        # display the values in x

y <- c(6, 7, 8, 9, 10) # put the numbers 6-10 in the variable y
y                      # display the values in y

a <- 1                 # assignment
a

b <- c <- d <- 5       # multiple assignments
b                      # display variables in console
c
d

x + y       # add corresponding elements in x and y
x * 2       # multiply each element in x by 2
x ** 3      # multiply each element in x by 3

# clean up
rm(x)           # remove an object from workspace
rm(a, b, c, d)  # remove more than one
rm(list = ls()) # clear entire workspace
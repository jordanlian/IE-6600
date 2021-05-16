# Week 1.2: R Part 1

# Single value variables
# Variable Assignments
var_one <- 1
var_two = 2
var_one<-var_two <- 3
4 -> var_one

# Removing variables
rm(var_one)
rm(var_two)

# Data Types----------------------------------------------
# Numbers

# Integer
var_int <- 1L

# How to identify variable data types
typeof(var_int)

# Numeric
var_num <- 1.5
typeof(var_num)

rm(var_num)
rm(var_int)

# Character
var_char <- "Northeastern Univeristy"
typeof(var_char)

# Conversion from one type to another
var_int <- 1L
var_num <- as.numeric(var_int)
typeof(var_num)

var_int <- as.integer(var_num)
typeof(var_int)

# Numeric to integer by default rounds off to the lower side
var_num <- 3.64
var_int <- as.integer(var_num)

# Number can be converted into characters
var_num <- 1
var_char <- as.character(var_num)
var_char <- var_char+1

# Characters can be converted into numbers
var_num <- as.numeric(var_char)
var_num <- var_num+1

# Exception to the rule
var_char <- "a"
var_char <- as.numeric(var_char)

# Date Data Type
var_date  <- as.Date("2012-06-28")
class(var_date)
var_date_time <- as.POSIXct("2012-06-28 17:42")
class(var_date_time)


# Logical Data Types
var_boolean <- TRUE
typeof(var_boolean)

# What is the data type of the following variable?
var_boolean <- "TRUE"

# Numeric operators
var_one <- 1
var_two <- 2

var_one + var_two
var_one - var_two
var_one / var_two
var_one * var_two
var_one ^ var_two

# Logical or comparison operator for numeric variables
var_one == var_two
var_one != var_two
var_one > var_two
var_one < var_two
var_one >= var_two
var_one <= var_two

# Logical operator for character variables
var_one <- "abc"
var_two <- "abc"
var_one == var_two

var_one <- "abc"
var_two <- "Abc"
var_one == var_two

# OR / AND operators
var_one <- 5
var_one > 3 & var_one < 7
var_one > 3 | var_one < 4

# Math functions
var <- 5

mean(var)
sd(var)
max(var)
min(var)

sin(var)
cos(var)
tan(var)

log(var)

# Rounding functions
var <- 13.2546

round(var)
round(var, 2)
floor(var)
ceiling(var)

#-----------------------------------------------------------------------------------------------
# Vectors
# Creating vectors
vec <- c(1L, 2L, 3L, 4L, 5L, 6L, 7L)
vec <- c(1, 2, 3, 4, 5, 6, 7)
vec <- c("a", "b", "c")

# Calculating the length of vectors
length(vec)

# Identifying datatypes of vectors
vec <- c(1L, 2L, 3L, 4L, 5L, 6L, 7L)
typeof(vec)
vec <- c(1, 2, 3, 4, 5, 6, 7)
typeof(vec)
vec <- c("a", "b", "c")
typeof(vec)

# Coercing vectors
vec <- c(1,2,3,"a","b","c")
vec <- c(1,2,3,TRUE,FALSE)
vec <- c(1,2,3,"TRUE","FALSE")

# Acccesing/subsetting elements in a vector using index values
vec <- c(10, 20, 30, 40, 50, 60, 70)
vec[2]
vec[2:4]
vec[-3]
vec[c(1, 3, 5)]
vec[-c(1, 3, 5)]

# Acccesing/subsetting elements in a vector using conditions
vec[vec > 30]
vec[vec < 30]
vec[vec < (30/2)]

vec <- 1:10
vec[(vec>8) | (vec<5)]
vec[(vec>5) & (vec<8)]

# Using any and which function 

any(vec == 20)
any(vec == 5)
which(vec == 20)

# Changing elements in a vector
vec <- 1:7
vec[2] <- 56

# Adding elements to a vector
vec[8] <- 80
vec

vec[9:11] <-c (90, 100, 110)
vec

# Deleting elements vector
vec <- vec[-11]
vec <- vec[-c(8,9,10)]

# Generating vector sequence
vec <- 1:40
vec <- 40:1
vec <- 2:-5

# Generating a sequence of numbers from 1 to 21 by increments of 2
seq(from = 1, to = 21, by = 2)            

# Generating a sequence of numbers from 1 to 21 that has 15 equal incremented numbers
seq(0, 21, length.out = 15)

# Replicating the values 
rep(1:4, times = 2)  

# Replicating the values 
rep(1:4, each = 2)

# Numerical vector operations 
vec <- 1:10
vec <- vec*2
vec <- 1:10
vec <- vec+2
vec <- vec-2

vec_one <- 1:4
vec_two <- 1:4
resultant_vec <- vec_one + vec_two
resultant_vec <- vec_one * vec_two

# Comparing vectors with individual elements
vec <- 1:10
vec > 5
vec != 5
vec == 5

# Comparing entire vectors
vec_one <- 1:4
vec_two <- 1:4
vec_one == vec_two
vec_one != vec_two
vec_one > vec_two
any(vec_one > vec_two)


# Aggregation/math fucntions on vector

vec <- 1:30

mean(vec)
sd(vec)
max(vec)
min(vec)
median (vec)
quantile(vec)

sin(vec)
cos(vec)
tan(vec)

log(vec)

vec <- c(2, 8, 4)
rank(vec)

# Rounding functions on vector 
vec <- c(2.2, 8.4, 4.9)

round(vec)
floor(vec)
ceiling(vec)

#-----------------------------------------------------------------------------------------------
# Creating matrices
mat_one <- matrix(0, nrow = 2, ncol = 3)
mat_two <- matrix(1:6, nrow = 2, ncol = 3)
mat_three <- matrix(letters[1:6], nrow = 2, ncol = 3)

# Size of a matrix
dim(mat_two)


# Identifying datatypes of matrices
typeof(mat_one)
typeof(mat_three)

# Coercing matrices
mat_two[1,2] <- "20"
typeof(mat_two)



# Accessing/subsetting matrix elements using index values
mat_two[1,2]
mat_two[1:2,1:2]
mat_two[1,]
mat_two[,3]
mat_two[1,c(1,3)]
mat_two[1:2,c(1,3)]

# Accessing/subsetting matrix elements using condition
mat_two[mat_two < 3]
mat_two[(mat_two < 3) & (mat_two != 1)]

# Changing Matrix Elements
mat_two[1,2] <- 20

# Adding row and column names
colnames(mat_two) <- c("A", "B", "C")
rownames(mat_two) <- c("D", "E")

# Check row and column names
rownames(mat_two)
colnames(mat_two)

# Comparing matrix with individual elements
mat_one <- matrix(0, nrow = 2, ncol = 3)
mat_two <- matrix(1:6, nrow = 2, ncol = 3)

mat_one == 0
mat_two > 2

# Comparing entire matrices
mat_one <- matrix(0, nrow = 2, ncol = 3)
mat_two <- matrix(1:6, nrow = 2, ncol = 3)

mat_one == mat_two
mat_one < mat_two

# Matrix operations
mat_two <- matrix(1:6, nrow = 2, ncol = 3)
mat_two + 2
mat_two * 2

mat_one <- matrix(1:6, nrow = 2, ncol = 3)
mat_one + mat_two

# Aggregation functions on matrix
mat_two <- matrix(1:6, nrow = 2, ncol = 3)

sum(mat_two)
mean(mat_two)
max(mat_two)
min(mat_two)

# Aggregation functions by row and columns
rowSums(mat_two)
colSums(mat_two)
rowMeans(mat_two)
colMeans(mat_two)

# Math functions
sin(mat_two)
cos(mat_two)
tan(mat_two)
log(mat_two)

#-------------------------------------------------------------------------------------------------
# Data frame
name <- letters[1:10]
age <- 11:20
height <- 61:70
attendance <- c(TRUE,TRUE,TRUE,TRUE,TRUE,FALSE,FALSE,FALSE,FALSE,FALSE)

df <- data.frame(name, age, height, attendance, stringsAsFactors = FALSE)

# Size of data frame
dim(df)

# View sample rows
head(df)
tail(df)

# Summary of a dataframe
summary(df)

# Check for datatype
typeof(df$age)

# Accessing/subsetting data frame using index values
df[1, 2]
df[1, 2:4]
df[1:3, 2:4]
df[1, c(2,4)]

# Accessing variables (columns) using variable names
df$name
df$age
df$attendance
df$age[1:5]
df$age[c(1,3,5,7)]

# Accessing variables (columns) using index values
df[[1]]
df[[2]]

# Subsetting data frame using condition
df[df$name == "a",]
df[df$age > 14,]
df[(df$age > 11 & df$attendance == TRUE),]

# Subsetting data frame using subset function
subset(df, df$name == "a")

# Subsetting data frame using which function
row_ind <- which(df$name == "a")
df[row_ind,]

# Single variable operations for data frame (one variable at a time)
sum(df$age)
mean(df[[2]])
sin(df$height)
log(df$height)

# Aggregation functions by row and columns (only for numeric)
age <- 11:20
height <- 61:70
df_num <- data.frame(age, height, stringsAsFactors = FALSE)
rowSums(df_num)
colSums(df_num)
rowMeans(df_num)
colMeans(df_num)

# Generate some data
values <- rnorm(100, mean = 5, sd = 1.5)

# Create a simple histogram
hist(values,
     main = "Values drawn from normal distribution",
     xlab = "Value",
     las = 1)

# Draw sample from uniform distribution
values <- runif(100)

# Create another histogram
hist(values,
     main = "Values drawn from uniform distribution",
     xlab = "Value",
     las = 1)

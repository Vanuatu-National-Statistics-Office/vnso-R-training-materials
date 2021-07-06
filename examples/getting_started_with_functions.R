# Getting started with functions

#### Resources ####

# Some useful resources to explore:
# - https://hbctraining.github.io/Intro-to-R/lessons/03_introR-functions-and-arguments.html
# - https://swcarpentry.github.io/r-novice-inflammation/02-func-R/
# - https://www.tutorialspoint.com/r/r_functions.htm

# General function structures that we use:
# function_name <- function(){
#   ...
# }
# 
# function_name <- function(input){
#   ...
# }
# 
# function_name <- function(first, second, third){
#   ...
# }
# 
# function_name <- function(first, second, third){
#   output <- ...
#   return(output)
# }
#
# Functions are closed boxes. They can have multiple inputs and a single output.
# All inputs required by the tasks within a function should be passed in as parameters.

# Document a function with a docstring:
# More on docstrings here: https://r-pkgs.org/man.html
# NOTE that if you include the docstring inside the function you can use the docstring library to create help docs on the fly: https://stackoverflow.com/questions/5931292/is-there-a-sensible-way-to-do-something-like-docstrings-in-r

#' Short title
#'
#' Full description of what function does
#' @param first An object of class "?". Describe each input parameter
#' @param second An object of class "?". Describe each input parameter
#' @keywords Add some good keywords for your function here
#' @return Returns an object of class "?". Describe what the function returns
#' @export
#' @examples
#' # Add some code here illustrating how to use the function

#### Calculating mean ####

# Calculating the mean
values <- c(5,2,5,3,4,6,7,5,7,8,5,3)

length_of_values <- length(values)
sum_of_values <- sum(values)
mean_of_values <- sum_of_values / length_of_values

# Create a function to calculate mean (NOTE mean() function already exists and this is for teaching purposes)
# View help doc with docstring::docstring(calculate_mean)
calculate_mean <- function(numeric_vector){
  
  #' Calculate mean of numbers
  #'
  #' Given a vector of numeric values this function will calculate the mean
  #' @param numeric_vector A numeric vector of numbers
  #' @return Returns a single numeric value representing the mean
  #' @examples
  #' values <- c(2,3,2,3,2,3)
  #' mean_of_values <- calculate_mean(values)
  
  # Count the number of elements in input vector
  length_of_vector <- length(numeric_vector)
  
  # Calculate sum of values
  sum_of_vector <- sum(numeric_vector)
  
  # Calculate the mean
  mean_of_vector <- sum_of_vector / length_of_vector
  
  return(mean_of_vector)
}

# Use function to calculate mean
mean_of_values <- calculate_mean(values)

# Compare to existing function
calculate_mean(values) == mean(values)

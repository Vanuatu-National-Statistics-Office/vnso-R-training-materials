# Build an example dataset
# Note selected "%d-%m-%y" format here for dates
data <- data.frame("test_date" = c("15-06-21", 
                                   "11-03-21",
                                   "10-01-21",
                                   "17-02-21",
                                   "21-06-21"),
                   "date" = c("12-01-21",
                              "11-04-21",
                              "05-03-21",
                              "17-05-21",
                              "25-02-21"),
                   "height" = c(154, 132, 123, 156, 123),
                   "weight" = c(123, 234, 213, 121, 234))

# Recognise the date format
# More on date formats here:
#  https://www.r-bloggers.com/2013/08/date-formats-in-r/
data$test_date <- as.Date(data$test_date, format = "%d-%m-%y")
data$date <- as.Date(data$date, format = "%d-%m-%y")

# Take two dates away from one another
# Also see the lubridate package that makes working with dates a little easier:
#  https://lubridate.tidyverse.org/
data$time_difference <- difftime(data$test_date, data$date,
                                 units = "days")

# Mathematical operations on dataframe columns - calculate the BMI
data$bmi <- data$weight / data$height

# Equivalent of calculating BMI using the dplyr library
library(dplyr)
data <- data %>%
  mutate(bmi = (weight / height) * height)

# Calculate range of heights
value_range <- range(data$height, na.rm = TRUE)

# Extend min and max values by 20% to set thresholds for any new data on heights
range_diff <- value_range[2] - value_range[1]
min_threshold <- value_range[1] - (0.2 * range_diff)
max_threshold <- value_range[2] + (0.2 * range_diff)

# Apply expanded thresholds to height data
data$within_threshold <- data$height > min_threshold &
                          data$height < max_threshold
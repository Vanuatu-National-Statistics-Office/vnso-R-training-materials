# Build an example dataset
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
data$test_date <- as.Date(data$test_date, format = "%d-%m-%y")
data$date <- as.Date(data$date, format = "%d-%m-%y")

# Take two dates away from one another
data$time_difference <- difftime(data$test_date, data$date,
                                 units = "days")

# Mathematical operations on dataframe columns
data$bmi <- (data$weight / data$height) * data$height
data <- data %>%
  mutate(bmi = (weight / height) * height)

# Values within 20% of range
value_range <- range(data$height, na.rm = TRUE)
range_diff <- value_range[2] - value_range[1]
min_threshold <- value_range[1] - (0.2 * range_diff)
max_threshold <- value_range[2] + (0.2 * range_diff)

data$within_threshold <- data$height > min_threshold &
                          data$height < max_threshold
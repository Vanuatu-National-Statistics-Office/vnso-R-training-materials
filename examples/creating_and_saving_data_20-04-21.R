# Load required libraries
library(dplyr)

# Set working directory
setwd(dirname(rstudioapi::getSourceEditorContext()$path))

# Creating a dataframe
example_data <- data.frame(
  "ID" = 1:100,
  "Value" = rnorm(n = 100, mean = 150, sd = 15),
  "Group" = sample(c("A", "B", "C"), size = 100, replace = TRUE)
  )
example_data$Group <- as.factor(example_data$Group)

# Exporting to csv
example_data_file <- file.path("..", "data", "example_data_20-04-21.csv")
write.csv(example_data, file = example_data_file, row.names = FALSE)

# Generating summary statistics
summary(example_data)
mean(example_data$Value)
median(example_data$Value)
sum(example_data$Value)
range(example_data$Value)
sd(example_data$Value)
var(example_data$Value)

# Aggregating and generating summary statistics
summary_statistics <- example_data %>%
  group_by(Group) %>%
  summarise(Mean = mean(Value),
            Median = median(Value),
            Minimum = min(Value),
            Maximum = max(Value),
            Sum = sum(Value), .groups = "drop")

# Merging two different datasets
more_example_data <- data.frame(
  "ID" = 1:100,
  "Weight" = runif(n = 100, min = 100, max = 200)
)
combined_data <- merge(example_data, more_example_data, by = "ID")

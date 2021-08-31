# using group_by() summarise total, and add column with percentage these numbers represent of the total- Tourism 

# Table 8 
# Country of usual residence cross tabulation by purpose of visits
# Calculate the counts for each country, share of total number of visits

#### Preparation ####

# Load required libraries
library(tibble) # Creating a tibble
library(dplyr) # Working with data

#### Create example data ####

# Create some example data
example_data <- tibble(
  id = 1:50, # Generate vector of unique IDs - one for each row
  age = rnorm(n = 50, mean = 45, sd = 15), # Sample from normal distribution with mean of 45 and standard deviation of 15 - 50 times
  PORT = sample(c("VAIR", "VAIRP", "SAIR", "SAIRP", "ABCD", "EFGH", "IJKL"), size = 50, replace = TRUE), # Sample of vector of strings 50 times with replacement
  LENGTH.OF.STAY = rnorm(50, mean = 120, sd = 20), # Sample from normal distribution with mean of 120 and standard deviation of 20 - 50 times
  direction = sample(c("Arrival", "Departure"), size = 50, replace = TRUE) # Sample of vector of strings 50 times with replacement
)

#### Group by and summarise ####

# Count number of visitors to each port
summary_stats <- example_data %>%
  group_by(PORT) %>%
  summarise(number_visitors = n(), .groups = "drop") # Note the n() function counts number of rows in each group

#### Add totals row and percentage column

# Count number of rows in summary table
n_rows <- nrow(summary_stats)

# Add total number of visitors into last row
# Note use of square brackets: dateframe_name[row(s) by index or name, column(s) by index or name]
# Here using number of rows in original table to add content into a new row at the bottom of the table
summary_stats[n_rows + 1, "PORT"] <- "TOTAL" 
summary_stats[n_rows + 1, "number_visitors"] <- sum(summary_stats$number_visitors, na.rm = TRUE) # Na removed here as line above adds 8th row with NA value in "number_visitors" column

# Add column representing the percentage of total
summary_stats <- summary_stats %>%
  mutate(percentage_visitors = (number_visitors / number_visitors[n_rows + 1]) * 100)

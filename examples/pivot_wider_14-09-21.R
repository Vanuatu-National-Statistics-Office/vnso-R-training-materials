#### Preparation ####

# Load required libraries
library(dplyr) # Subsetting table
library(tidyr) # Pivot wider function
library(janitor) # Add totals row and column

# Set working directoty
setwd(dirname(rstudioapi::getSourceEditorContext()$path))

#### Load the data ####

# Load table 8
travel_summary <- read.csv(file.path("..", "data", "Table_8.csv"))

# Drop the first column
travel_summary <- travel_summary %>%
  select(-X)

#### Pivotting to wide format ####

# Take the values from the "n" column and create new column for 
# category in POV_Groups
travel_summary_wide <- travel_summary %>%
  pivot_wider(names_from = POV_Groups, values_from = n)

#### Add in total row and column ####

# Add in a total column
travel_summary_wide <- travel_summary_wide %>%
  adorn_totals("col")

# Add in a total row
travel_summary_wide <- travel_summary_wide %>%
  adorn_totals("row")

#### Percentage of total columns ####

# Calculate the percentage of total
n_cols <- ncol(travel_summary_wide)
columns_of_interest <- 2:(n_cols - 1) # Ignores first and last columns
travel_summary_wide_proportion <- travel_summary_wide[, columns_of_interest]/travel_summary_wide$Total
travel_summary_wide_percentage <- travel_summary_wide_proportion * 100

# Note percentage columns in their name
colnames(travel_summary_wide_percentage) <- paste(colnames(travel_summary_wide_percentage), "(percentage)")

# Add percentage columns into main table
travel_summary_with_percentages <- cbind(travel_summary_wide, travel_summary_wide_percentage)

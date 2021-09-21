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

#### Combining value and percentage into single columns ####

# Initialise a dataframe to store the combined values and percentages
travel_summary_final <- data.frame("GROUP" = travel_summary_wide$GROUP)

# Note the columns of interest
columns_of_interest <- colnames(travel_summary_wide)[
  c(-1, -ncol(travel_summary_wide))
]

# Add in each column with combined value and percentage
for(travel_type_column in columns_of_interest){
  
  # Create column name with percentage
  travel_type_column_as_percentage <- paste(travel_type_column, "(percentage)")
  
  # Get the counts for current travel type
  # Note use of "drop" - this extracts the values as a vector instead of data.frame
  travel_type_counts <- travel_summary_wide[, travel_type_column, drop = TRUE]
  
  # Get the counts as percentages
  # Note use of "drop" - this extracts the values as a vector instead of data.frame
  travel_type_percentages <- travel_summary_wide_percentage[, 
                                                            travel_type_column_as_percentage,
                                                            drop = TRUE]
  
  # Round the percentages
  travel_type_percentages <- round(travel_type_percentages, digits = 0)

  # Create column with combined value and percentage
  travel_summary_final[, column_of_interest] <- paste(
    travel_type_counts, " (", travel_type_percentages, "%)", sep = ""
  )
}

# Add the Total column
travel_summary_final$Total <- travel_summary_wide$Total

# Remove the percentages from final row
number_rows <- nrow(travel_summary_final)
travel_summary_final[number_rows, ] <- travel_summary_wide[number_rows, ]

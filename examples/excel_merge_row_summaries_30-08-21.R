# 
# - Take columns of information from different xlsx spreadsheets
# - Create separate dataframe
# - Perform row calculations- adding together multiple columns, taking their average
# - making multiplications between different columns of information through matching of variables (have to find water price, and water weight to multiply)- CPI

#### Preparation ####

# Load required libraries
library(readxl) # Reading data from excel files
library(dplyr) # Working with data

# Set the working directory to current file's location
setwd(dirname(rstudioapi::getSourceEditorContext()$path))

#### Read in the data from excel ####

# read_excel() function from readxl package to load data from excel file
# https://readxl.tidyverse.org/

# Note the name of the data file file in excel form
excel_data_file <- file.path("..", "data", "example_data.xlsx")

# Read in the data from the second sheet
second_sheet <- read_excel(excel_data_file, 
                           sheet = "Dataset_2", # Specify the sheet you want to read from, defaults to first one
                           range = "C3:E12") # Specify where in sheet table is, defaults to starting in the top left corner

#### Merge into single dataframe ####

# Use the left_join() function from the dplyr package (or merge() function)
# - https://dplyr.tidyverse.org/reference/join.html
# - https://www.dummies.com/programming/r/how-to-use-the-merge-function-with-data-sets-in-r/
# Key is that you need a link column (don't need the same name, although that doesn't hurt) with matching values across data being merged

#### Calculate summary stats based on rows ####

# Simple stats: rowSums() rowMeans()
# - https://www.programmingr.com/tutorial/rowsums-in-r/
# - https://www.programmingr.com/tutorial/rowmeans-in-r/
# More flexibility in summary stats see the rowwise() function
# https://dplyr.tidyverse.org/articles/rowwise.html

#### Multiply columns ####

# Multiplying columns can be done using standard math notation and referencing columns by their name (or index in square brackets):
summary_stats$new_column <- summary_stats$number_visitors * summary_stats$ship_size

# In dplyr syntax, the above looks like this:
summary_stats <- summary_stats %>%
  mutate(new_column = number_visitors * ship_size)

#### Matching text ####

# Matching of different columns will probably involve some kind of pattern matching - identifying columns sharing a pattern
# Pattern matching can be done using the grep() family of functions and the stringr package simplifies some aspects of using grep
# - https://bookdown.org/rdpeng/rprogdatascience/regular-expressions.html
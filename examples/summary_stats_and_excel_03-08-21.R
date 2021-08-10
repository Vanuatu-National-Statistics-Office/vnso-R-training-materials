#### Preparation ####

# Load the required libraries
library(dplyr) # Manipulating data - install.packages("dplyr")
library(readxl) # Reading excel file - see resources here: https://readxl.tidyverse.org/

# Set the working directory to current file's location
setwd(dirname(rstudioapi::getSourceEditorContext()$path))

# Read historic exports data
historic_exports_file <- file.path("..", "..", "vnso-RAP-tradeStats-materials", "data", "secure", "historical_export_99_19.csv")
historic_exports <- read.csv(historic_exports_file)

# Read in historic imports data
historic_imports_file <- file.path("..", "..", "vnso-RAP-tradeStats-materials", "data", "secure", "historical_import_99_19.csv")
historic_imports <- read.csv(historic_imports_file)

# Load the CPI data
cpi_data_file <- file.path("..", "..", "vnso-RAP-consumerPriceIndexStats-materials",
                           "data", "secure", "CPI.csv")
cpi_data <- read.csv(cpi_data_file)

#### Calculating the row summary statistics on multiple columns ####

# Note our columns of interest
columns <- c("Dec.09", "Mar.10", "Jun.10", "Sep.10", "Dec.10")

# Convert columns to numeric
cpi_data[columns] <- sapply(cpi_data[columns], FUN = as.numeric)

# Calculate the row means for select columns
row_means_for_selected_means <- rowMeans(cpi_data[, columns], na.rm = TRUE)




#### Extracting sheets from excel file ####

# Note the name of the data file file in excel form
excel_data_file <- file.path("..", "data", "example_data.xlsx")

# Read in the data from the first sheet
first_sheet <- read_excel(excel_data_file, sheet = "Dataset_1")

# Read in the data from the second sheet
second_sheet <- read_excel(excel_data_file, sheet = "Dataset_2",
                           range = "C3:E12")

# Write the first sheet into a csv file
first_sheet_csv_data_file <- file.path("..", "data", "example_data_first_sheet.csv")
write.csv(first_sheet, file = first_sheet_csv_data_file, row.names = FALSE)

#### Filtering and summing ####


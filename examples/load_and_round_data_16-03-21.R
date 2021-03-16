## Problem: want to set the number of decimal places of data in column of table

## Break problem down into tasks:
# 1. Load dataset
# 2. Round the values in a particular column to set number of digits (check out ?round())
# 3. Store the rounded data in new column

# Read in some data
dataFile <- choose.files() # Choose.files() will create a window for selecting a data file to load. You could also specify a particular file with file.path()
summaryData <- read.csv(dataFile) # Load the data in csv (Comma Seperated Values - a simple format for saving data in a table with commas separating values in each column)

# Round data in one of the columns
# myDataFrameName$ColumnName is a shortcut format for select a column of a dataframe (R's format for a table)
# Here's we're sending the rounded values of the "Value.Mean" column into a new column called "Value.Mean.Rounded"
summaryData$Value.Mean.Rounded <- round(summaryData$Value.Mean, digits = 2)

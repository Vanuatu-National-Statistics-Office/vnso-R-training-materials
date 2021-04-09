# Read in some data
historic_exports_file <- choose.files() # Choose.files() will create a window for selecting a data file to load. You could also specify a particular file with file.path()
historic_exports_data <- read.csv(historic_exports_file) # CSV stands for comma separated values. The read.csv() function is specifically designed to read data stored in a CSV format - more info at ?read.csv()

# Get the number of rows and columns
# The dim() function returns the number of rows and columns of the dataframe. Can also be used for vectors and matrics see ?dim() for more information
# Note that historic_exports_data is a dataframe - a table with rows and columns. Take a look with View(historic_exports_data)
dim(historic_exports_data)

# Select first 10 rows of the date, month, and HS columns
# Here we are subsetting using square brackets: [rows, columns]
# 1:10 is shorthand for a vector of numbers c(1,2,3,4,5,6,7,8,9,10)
subset_of_historic_data <- historic_exports_data[1:10, c("Date", "Month", "HS")]

# Select high value commodities being exported
# Inside square brackets we can use conditions - here we are using it to select export commodities whose value was above 10,000,000
# The dollar sign ($) is another way of selecting a column from a dataframe
high_value_exports <- 
  historic_exports_data[historic_exports_data$Value > 10000000, ] # Left columns here blank to select all columns

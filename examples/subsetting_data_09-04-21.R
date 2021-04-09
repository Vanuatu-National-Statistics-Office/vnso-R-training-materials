# Read in some data
historic_exports_file <- choose.files() # Choose.files() will create a window for selecting a data file to load. You could also specify a particular file with file.path()
historic_exports_data <- read.csv(historic_exports_file)

# Get the number of rows and columns
dim(historic_exports_data)

# Select first 10 rows of the date, month, and HS columns
subset_of_historic_data <- historic_exports_data[1:10,c("Date", "Month", "HS")]

# Select high value commodities being exported
high_value_exports <- 
  historic_exports_data[historic_exports_data$Value > 10000000, ]

# Set the working directory to current file's location
setwd(dirname(rstudioapi::getSourceEditorContext()$path))

# Read in some data
historic_exports_file <- file.path("..", "..", "vnso-RAP-tradeStats-materials", "data", "secure", "historical_export_99_19.csv")
historic_exports_data <- read.csv(historic_exports_file)

# Load the required libraries
library(dplyr) # Manipulating data - install.packages("dplyr")
library(ggplot2) # Plotting data - install.packages("ggplot2")

# Calculate summary statistics of Value by year
historic_exports_by_year <-
  historic_exports_data %>%
  filter(is.na(Value) == FALSE) %>%
  group_by(Year) %>%
  summarise(mean = mean(Value),
            min = min(Value),
            max = max(Value),
            sum = sum(Value),
            median = median(Value), 
            .groups = "drop")

# Create a plot of median value by year
historic_exports_by_year %>%
  ggplot(aes(x = Year, y = median)) +
    geom_line(color = "red") +
    geom_point() +
    geom_text(aes(label = round(median/10000, digits = 0)), vjust = -1) +
    labs(title = "Statistic value of exports",
        x ="Year", y = "Value")

# Working with dates
dates <- as.Date(historic_exports_data$Date, 
                 format = "%d/%m/%Y")
years <- format(dates, "%Y")

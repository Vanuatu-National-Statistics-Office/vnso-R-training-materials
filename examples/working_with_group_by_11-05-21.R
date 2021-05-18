# Load the required libraries
library(dplyr) # Manipulating data - install.packages("dplyr")
library(ggplot2) # Plotting data - install.packages("ggplot2")

# Set the working directory to current file's location
setwd(dirname(rstudioapi::getSourceEditorContext()$path))

# Read in some data
historic_exports_file <- file.path("..", "..", "vnso-RAP-tradeStats-materials", "data", "secure", "historical_export_99_19.csv")
historic_exports <- read.csv(historic_exports_file)

# Working with dates
dates <- as.Date(historic_exports$Date, 
                 format = "%d/%m/%Y")
years <- format(dates, "%Y")

# Calculate summary statistics of Value by year
historic_exports_by_year <-
  historic_exports %>%
  filter(is.na(Value) == FALSE) %>%
  group_by(Year) %>%
  summarise(mean = mean(Value),
            min = min(Value),
            max = max(Value),
            sum = sum(Value),
            median = median(Value), 
            .groups = "drop")

# Calculate summary statistics of Value by year and destination country
historic_exports_by_year_and_country <-
  historic_exports %>%
  filter(is.na(Value) == FALSE) %>%
  group_by(Year, CTY_Dest) %>%
  summarise(mean = mean(Value),
            min = min(Value),
            max = max(Value),
            sum = sum(Value),
            median = median(Value),
            .groups = "drop") %>%
  filter(Value < 100000)

# Summarise package type by weight
package_types <-
  historic_exports %>%
    group_by(Pkg._Type) %>%
    summarise(median = median(Weight, na.rm = TRUE),
              min = min(Weight, na.rm = TRUE),
              lower = quantile(Weight, probs = 0.025, na.rm = TRUE),
              upper = quantile(Weight, probs = 0.975, na.rm = TRUE),
              max = max(Weight, na.rm = TRUE),
              .groups = "drop")

# Create a plot of median value by year
historic_exports_by_year %>%
  ggplot() +
    aes(x = Year, y = median) +
    geom_col(alpha = 0.5) +
    geom_line(color = "red", linetype = "dashed", size = 1.5) +
    geom_point(color = "blue") +
  #geom_text(aes(label = round(median/10000, digits = 0)), vjust = -1, size = 5, colour = "blue") +
    labs(title = "Statistic value of exports",
         x ="Year", y = "Value")

# Plot the weight distribution
historic_exports %>%
  ggplot(aes(x = Weight)) +
    geom_histogram(bins = 100, 
                   fill = "red", 
                   alpha = 0.5, 
                   col = "black") +
    xlim(0, 1000000) +
    ylim(0, 3000) +
    labs(title = "Package weight",
         subtitle = "Limited to weight below 1 million (kg)",
         y = "Count")

# Create histogram of Statistical Value distribution in 2015
historic_exports %>%
  filter(Year == 2015) %>%
  ggplot() +
  geom_histogram(aes(x = Value), bins = 100, fill = "red", alpha = 0.5, col = "black") +
  labs(title = "Statistic value distribution", subtitle = "Exports in 2015",
       x ="Value", y = "Count")

# Create a scatter plot of weight versus quantity
historic_exports %>%
  ggplot() +
  geom_point(aes(x = Weight, y = Supp_Qty, col = Pkg._Type), alpha = 0.25) +
  xlim(0, 1000) +
  ylim(0, 1000) +
  labs(title = "Comparing quantity and weight", subtitle = "Coloured by packaging type",
       y = "Supply Quantity", col = "Packaging type")


# Create a boxplot of value by year
historic_exports %>%
  ggplot(aes(x = factor(Year), y = Value)) +
  geom_jitter(color = "red", size = 0.4, alpha = 0.1) +
  geom_boxplot(outlier.shape = NA, alpha = 0.5) +
  ylim(0, 5000) +
  labs(title = "Statistical value distribution through time",
       subtitle = "Rescaled axis excludes many points!",
       x = "Year")

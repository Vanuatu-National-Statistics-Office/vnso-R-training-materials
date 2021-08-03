#### Preparation ####

# Load the required libraries
library(dplyr) # Manipulating data - install.packages("dplyr")

# Set the working directory to current file's location
setwd(dirname(rstudioapi::getSourceEditorContext()$path))

# Read in some data
historic_exports_file <- file.path("..", "..", "vnso-RAP-tradeStats-materials", "data", "secure", "historical_export_99_19.csv")
historic_exports <- read.csv(historic_exports_file)

#### Useful resources ####

# Subsetting using single and multiple values in base R: https://stats.idre.ucla.edu/r/faq/frequently-asked-questions-about-rhow-can-i-subset-a-data-setthe-r-program-as-a-text-file-for-all-the-code-on-this-page-subsetting-is-a-very-important-component/
# The theory behind subsetting in base R: https://crimebythenumbers.com/subsetting-intro.html
# Subsetting (filtering) using dplyr: https://blog.exploratory.io/filter-data-with-dplyr-76cf5f1a258e

#### Filtering on multiple values ####

## Filtering using dplyr

# Select data for bank notes only
historic_exports_banknotes <- historic_exports %>%
  filter(HS == "49070010")

# Select commodities being exported to Australia and New Zealand
historic_exports_AU_NZ <- historic_exports %>%
  filter(CTY_Dest %in% c("AU", "NZ"))

# Send sfiltered/subsetted data into further operations
AU_NZ_exports_summary <- historic_exports_AU_NZ %>%
  filter(is.na(Value) == FALSE & Year >= 2015) %>%    # Remove NA values and select data from 2015
  group_by(CTY_Dest, Year) %>%                        # Aggregate data by destination country and year
  summarise(mean_value = mean(Value),                 # Summarise aggregated data using - mean
            total_value = sum(Value),                 #                                 - total
            min_value = min(Value),                   #                                 - min
            max_value = max(Value),                   #                                 - max
            .groups = "drop")                         # Don't keep the grouping structure set by group_by - no longer needed


## Filtering using subset() function

# Select data for bank notes only
historic_exports_banknotes <- subset(historic_exports, HS == "49070010")

# Select commodities being exported to Australia and New Zealand
histroci_exports_AU_NZ <- subset(historic_exports, CTY_Dest %in% c("AU", "NZ"))

## Filtering using square brackets

# Select data for bank notes only
historic_exports_banknotes <- historic_exports[historic_exports$HS == "49070010", ]

# Select commodities being exported to Australia and New Zealand
histroci_exports_AU_NZ <- historic_exports[historic_exports$CTY_Dest %in% c("AU", "NZ"), ]

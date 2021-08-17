#### Preparation ####

# Load required libraries
library(tibble) # Creating a tibble
library(dplyr) # Working with data

#### Create some example data ####

# Create some example data
example_data <- tibble(
  id = 1:50, 
  VisitorResidents = sample(c(TRUE, FALSE), size = 50, replace = TRUE), 
  LENGTH.OF.STAY = rnorm(50, mean = 120, sd = 20)
)

#### Identify visitors and correct length of stay ####

# Select only visitors
visitors_data <- example_data %>%
  filter(VisitorResidents == TRUE)

# Identify when length of stay over 120 days and correct
length_of_stay_threshold <- 120
visitors_data <- visitors_data %>%
  mutate(visit_too_long = LENGTH.OF.STAY > length_of_stay_threshold,
         
         CORRECTED.LENGTH.OF.STAY = case_when(
           LENGTH.OF.STAY > length_of_stay_threshold ~ length_of_stay_threshold,
           TRUE ~ LENGTH.OF.STAY
         ))

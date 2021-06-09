# Load required libraries
library(dplyr)

# Load the area council profiles data
area_councils <- read.csv("AreaCouncilProfiles.csv")

# Define populaiton growth function
population_growth <- function(current_pop_size, growth_rate, n_years){
  
  new_pop_size <- current_pop_size * exp(growth_rate * n_years)
  
  return(new_pop_size)
}

# Define population growth rate
growth_rate <- 0.023

# Restructure data
area_councils <- area_councils %>%
  mutate(Size_2016 = Value) %>%
  select(-c(Year, Value))

# Calculate population size for 2017 to 2019
area_councils <- area_councils %>%
  mutate(Size_2017 = population_growth(Size_2016, growth_rate, n_years = 1),
         Size_2018 = population_growth(Size_2016, growth_rate, n_years = 2),
         Size_2019 = population_growth(Size_2016, growth_rate, n_years = 3))

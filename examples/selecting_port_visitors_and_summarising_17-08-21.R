#### Preparation ####

# Load required libraries
library(tibble) # Creating a tibble
library(dplyr) # Working with data

#### Create example data ####

# Create some example data
example_data <- tibble(
  id = 1:50, 
  age = rnorm(n = 50, mean = 45, sd = 15), 
  PORT = sample(c("VAIR", "VAIRP", "SAIR", "SAIRP", "ABCD", "EFGH", "IJKL"), size = 50, replace = TRUE),
  LENGTH.OF.STAY = rnorm(50, mean = 120, sd = 20),
  direction = sample(c("Arrival", "Departure"), size = 50, replace = TRUE)
)

#### Identify visitors to ports and summarise ####

# Add a column to identify where visits to Port vila or Santo
example_data <- example_data %>%
  mutate(vila_or_santo = case_when(
    grepl(pattern="VAI", PORT) ~ "VILA",
    grepl(pattern="SAI", PORT) ~ "SANTO"
  ))

# Group by Port Vila and Santo and calculate average age
average_age_at_vila_and_santo <- example_data %>%
  filter(vila_or_santo %in% c("VILA", "SANTO") &
           direction == "Arrival" &
           LENGTH.OF.STAY <= 120) %>%
  group_by(vila_or_santo) %>%
  summarise(average_age = mean(age),
            max_age = max(age),
            min_age = min(age),
            average_length_of_stay = mean(LENGTH.OF.STAY),
            number_vistors = n(), .groups = "drop")

# Calculate overall age for Vanuatu
overall_average_age <- mean(example_data$age)
overall_length_of_stay <- mean(example_data$LENGTH.OF.STAY)


# Code to calculate balance of trade of New Emerging Markets

# Task Description:
# Have to create a subset of Trade Balances for all countries that fall into OTHER category. Then within this subset sort in ascending order (highest to lowest). Take the Top 5 (countries export a lot too) and Lost 5 (Countries import a lot from) and visualise this on a bar chart. Again not sure how to do this.

# Broken down into tasks:
# 1. Identify imports and exports
# 2. Calculate total imports and exports by country
# 3. Calculate trade balance by country
# 4. Order the table by the trade balance (decreasing)
# 5. Create a bar chart of the top 5 (exporters) and bottom 5 (importers)

# Requirements:
# Requires the `processedTradeStats` variable (processed data for latest month), which is created by:
#   vnso-RAP-tradeStats-materials\R\MonthlyReportAndTables\1_processLatestMonthsTradeStats.R

# Load required libraries
library(dplyr)
library(ggplot2)

# Add column to tell us whether each row is import or export
processedTradeStats <- processedTradeStats %>%
  mutate(CommodityType = case_when(CP4 %in% c(4000, 4071, 7100) ~ "IMPORT",
                                   CP4 %in% c(1000) ~ "EXPORT",
                                   CP4 %in% c(3071) ~ "REEXPORT"))

# Calculate total statistical value by country and commodity type
totalCommodityValueByCountryAndType <- processedTradeStats %>%
  group_by(CO, CommodityType) %>%
  summarise(total = sum(Stat..Value), 
            exportCategory = EXPORT.PARTNER.COUNTRIES[1],
            importCategory = IMPORT.PARTNER.COUNTRIES[1],
            country = ifelse(is.na(IMPORT.COUNTRY), EXPORT.COUNTRY[1], IMPORT.COUNTRY[1]),
            .groups = "drop")

# Calculate the trade balance for each country
tradeBalanceByCountry <- totalCommodityValueByCountryAndType %>%
  mutate(totalWithSign = ifelse(CommodityType == "IMPORT", total * -1, total)) %>%
  group_by(CO, country, importCategory) %>%
  summarise(balance = sum(totalWithSign), .groups = "drop")

# Order table by the trade balance
tradeBalanceByCountry <- tradeBalanceByCountry %>%
  arrange(desc(balance))

# Drop Vanuatu
tradeBalanceByCountry <- tradeBalanceByCountry %>%
  filter(country != "VANUATU")

# Select only countries falling into the OTHER category
tradeBalanceByCountryOther <- tradeBalanceByCountry %>%
  filter(importCategory == "OTHERS")

# Create a bar chart to view the top 5 and bottom 5 countries
nRows <- nrow(tradeBalanceByCountryOther)
ggplot(data = tradeBalanceByCountryOther[c(1:5, (nRows-4):nRows), ], 
       aes(x = reorder(country, -balance), y = balance)) +
  geom_bar(stat = "identity") +
  ylab("Trade Balance") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1),
        axis.title.x = element_blank())

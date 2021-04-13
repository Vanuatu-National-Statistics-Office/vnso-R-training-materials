# Set the working directory to current file's location
setwd(dirname(rstudioapi::getSourceEditorContext()$path))

# Read in some data
historic_exports_file <- file.path("..", "..", "vnso-RAP-tradeStats-materials", "data", "secure", "historical_export_99_19.csv")
historic_exports_data <- read.csv(historic_exports_file)

# Look at HS code column
class(historic_exports_data$HS)
historic_exports_data$HS <- as.factor(historic_exports_data$HS)
class(historic_exports_data$HS)

# Look at the Pkg.Type column
class(historic_exports_data$Pkg._Type)
package_as_numbers <- as.numeric(historic_exports_data$Pkg._Type)
package_as_factor <- as.factor(historic_exports_data$Pkg._Type)
package_as_factor_number <- as.numeric(package_as_factor)

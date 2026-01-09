# =============================================================================
# Quick Run Script for Shiny App
# =============================================================================
# Run this script in R console or terminal to start the app
# =============================================================================

# Set working directory to script location
# If running from terminal, use absolute path:
setwd("/Users/foodpapa/Desktop/rshinnyproject")

# Or if you want to set it relative to where you run the script:
# setwd(dirname(parent.frame(2)$ofile))

# Install required packages if missing
required_packages <- c("shiny", "ggplot2", "dplyr", "DT")
missing_packages <- required_packages[!sapply(required_packages, requireNamespace, quietly = TRUE)]

if(length(missing_packages) > 0) {
  cat("Installing missing packages:", paste(missing_packages, collapse = ", "), "\n")
  install.packages(missing_packages, repos = "https://cloud.r-project.org")
}

# Load required libraries
library(shiny)

# Run the app
cat("\n")
cat("==========================================\n")
cat("Starting Health Data Analysis Dashboard\n")
cat("==========================================\n")
cat("\n")
cat("The app will open in your web browser automatically\n")
cat("Press Ctrl+C or ESC to stop the app\n")
cat("\n")

# Run the app
runApp("app.R", host = "0.0.0.0", port = 3838)

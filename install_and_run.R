# Install packages and run the app
# This script installs missing packages and starts the Shiny app

# Set working directory
setwd("/Users/foodpapa/Desktop/rshinnyproject")

# List of required packages
required_packages <- c("shiny", "ggplot2", "dplyr", "DT")

cat("==========================================\n")
cat("Health Data Dashboard - Package Installer\n")
cat("==========================================\n\n")

# Function to install packages if not installed
install_if_missing <- function(packages) {
  for(pkg in packages) {
    if(!requireNamespace(pkg, quietly = TRUE)) {
      cat("Installing", pkg, "...\n")
      tryCatch({
        utils::install.packages(pkg, repos = "https://cloud.r-project.org", dependencies = TRUE, quiet = FALSE)
        cat("✅", pkg, "installed successfully!\n\n")
      }, error = function(e) {
        cat("❌ Error installing", pkg, ":", e$message, "\n\n")
      })
    } else {
      cat("✅", pkg, "is already installed\n\n")
    }
  }
}

# Install missing packages
cat("Checking and installing required packages...\n\n")
install_if_missing(required_packages)

# Verify all packages are installed
cat("\nVerifying installation...\n")
missing <- required_packages[!sapply(required_packages, requireNamespace, quietly = TRUE)]

if(length(missing) > 0) {
  cat("❌ Warning: The following packages could not be installed:\n")
  cat(paste(missing, collapse = ", "), "\n")
  cat("Please install them manually using:\n")
  cat("install.packages(c('", paste(missing, collapse = "', '"), "'))\n\n")
} else {
  cat("✅ All required packages are installed!\n\n")
}

# Load required libraries
cat("Loading libraries...\n")
library(shiny)
library(ggplot2)
library(dplyr)
library(DT)

cat("✅ All libraries loaded successfully!\n\n")

# Run the app
cat("==========================================\n")
cat("Starting Health Data Analysis Dashboard\n")
cat("==========================================\n\n")
cat("The app will open in your web browser automatically\n")
cat("Press Ctrl+C or ESC to stop the app\n\n")
cat("If browser doesn't open, go to: http://localhost:3838\n\n")

# Run the app
runApp("app.R", host = "0.0.0.0", port = 3838, launch.browser = TRUE)

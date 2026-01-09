#!/bin/bash

# Script to run the Shiny app from Cursor terminal
# This script checks for required packages and runs the app

echo "=========================================="
echo "Health Data Analysis Dashboard - Runner"
echo "=========================================="
echo ""

# Check if R is installed
if ! command -v R &> /dev/null; then
    echo "❌ Error: R is not installed or not in PATH"
    echo "Please install R from: https://cran.r-project.org/"
    exit 1
fi

echo "✅ R is installed"
echo ""

# Change to the script directory
cd "$(dirname "$0")"

# Check if app.R exists
if [ ! -f "app.R" ]; then
    echo "❌ Error: app.R not found in current directory"
    exit 1
fi

echo "✅ app.R found"
echo ""

# Check if CSV file exists
if [ ! -f "diabetes_dataset.csv" ]; then
    echo "❌ Error: diabetes_dataset.csv not found"
    exit 1
fi

echo "✅ diabetes_dataset.csv found"
echo ""

# Install/check packages
echo "Checking required packages..."
Rscript -e "
required_packages <- c('shiny', 'ggplot2', 'dplyr', 'DT')
missing <- required_packages[!sapply(required_packages, requireNamespace, quietly = TRUE)]

if(length(missing) > 0) {
  cat('⚠️  Missing packages:', paste(missing, collapse=', '), '\n')
  cat('Installing missing packages...\n')
  install.packages(missing, repos='https://cloud.r-project.org', quiet = TRUE)
} else {
  cat('✅ All packages are installed!\n')
}
"

echo ""
echo "=========================================="
echo "Starting Shiny App..."
echo "=========================================="
echo ""
echo "The app will open in your default web browser"
echo "Press Ctrl+C to stop the app"
echo ""

# Run the Shiny app
Rscript -e "library(shiny); runApp('app.R', host='0.0.0.0', port=3838)"

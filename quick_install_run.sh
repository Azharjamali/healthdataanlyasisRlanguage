#!/bin/bash

# Quick install and run script for Shiny app
# This script installs missing packages and runs the app

cd "/Users/foodpapa/Desktop/rshinnyproject"

echo "=========================================="
echo "Installing Required Packages..."
echo "=========================================="
echo ""

# Install packages using R command
R --slave -e "
cat('Installing required packages...\n')
packages <- c('ggplot2', 'dplyr', 'DT')
for(pkg in packages) {
  if(!requireNamespace(pkg, quietly = TRUE)) {
    cat('Installing', pkg, '...\n')
    install.packages(pkg, repos = 'https://cloud.r-project.org', dependencies = TRUE)
  } else {
    cat(pkg, 'already installed\n')
  }
}
cat('\n✅ Package installation complete!\n')
"

echo ""
echo "=========================================="
echo "Starting Shiny App..."
echo "=========================================="
echo ""
echo "The app will open in your browser shortly..."
echo "If it doesn't, go to: http://localhost:3838"
echo "Press Ctrl+C to stop the app"
echo ""

# Run the app
Rscript -e "library(shiny); library(ggplot2); library(dplyr); library(DT); runApp('app.R', host='0.0.0.0', port=3838, launch.browser=TRUE)"

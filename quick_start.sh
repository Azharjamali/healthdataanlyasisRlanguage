#!/bin/bash

# Quick Start Script - Install packages and run app
# This script provides instructions for manual installation if needed

cd "/Users/foodpapa/Desktop/rshinnyproject"

echo "=========================================="
echo "Health Data Dashboard - Quick Start"
echo "=========================================="
echo ""

# Check if packages are installed
echo "Checking for required packages..."
Rscript -e "
packages <- c('ggplot2', 'dplyr', 'DT')
installed <- sapply(packages, requireNamespace, quietly = TRUE)
missing <- packages[!installed]

if(length(missing) > 0) {
  cat('Missing packages:', paste(missing, collapse=', '), '\n')
  cat('\nPlease install them manually using:\n')
  cat('R -e \"install.packages(c(', paste(paste('\"', missing, '\"', sep=''), collapse=','), '), repos=\\'https://cloud.r-project.org\\')\"\n')
  cat('\nOr in R console:\n')
  cat('install.packages(c(', paste(paste('\"', missing, '\"', sep=''), collapse=','), '))\n')
  quit(status=1)
} else {
  cat('✅ All packages are installed!\n')
}
" 2>&1 | grep -v "cannot find\|Warning\|package.*in options"

if [ $? -ne 0 ]; then
    echo ""
    echo "=========================================="
    echo "Manual Installation Required"
    echo "=========================================="
    echo ""
    echo "Please install packages manually:"
    echo ""
    echo "1. Open Terminal and type: R"
    echo "2. Copy and paste:"
    echo "   install.packages(c('ggplot2', 'dplyr', 'DT'), repos='https://cloud.r-project.org')"
    echo "3. Wait for installation"
    echo "4. Type: quit()"
    echo ""
    echo "Then run this script again or run:"
    echo "Rscript -e \"library(shiny); runApp('app.R')\""
    echo ""
    exit 1
fi

echo ""
echo "=========================================="
echo "Starting Shiny App..."
echo "=========================================="
echo ""
echo "The app will open in your browser..."
echo "Press Ctrl+C to stop"
echo ""

# Run the app
Rscript -e "library(shiny); library(ggplot2); library(dplyr); library(DT); runApp('app.R', host='0.0.0.0', port=3838, launch.browser=TRUE)"

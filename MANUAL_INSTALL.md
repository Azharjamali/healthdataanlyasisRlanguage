# Manual Package Installation Guide

Due to R environment configuration issues, please install packages manually using one of these methods:

## Method 1: Using R Console (Recommended)

1. **Open Terminal in Cursor** (press `` Ctrl+` ``)

2. **Start R interactively:**
   ```bash
   R
   ```

3. **In the R console, copy and paste these commands:**
   ```r
   # Set CRAN mirror
   options(repos = c(CRAN = "https://cloud.r-project.org"))
   
   # Install packages
   install.packages("ggplot2")
   install.packages("dplyr")
   install.packages("DT")
   
   # Verify installation
   library(ggplot2)
   library(dplyr)
   library(DT)
   
   # If all libraries load without error, installation is successful!
   # Type quit() to exit R
   ```

## Method 2: Using RStudio (Easiest)

1. Open **RStudio**
2. In the console, type:
   ```r
   install.packages(c("ggplot2", "dplyr", "DT"))
   ```
3. Press Enter
4. Wait for installation to complete

## Method 3: One-line command

Open Terminal and run:
```bash
R -e "install.packages(c('ggplot2', 'dplyr', 'DT'), repos='https://cloud.r-project.org')"
```

## After Installation

Once packages are installed, you can run the app using:
```bash
cd /Users/foodpapa/Desktop/rshinnyproject
Rscript -e "library(shiny); runApp('app.R')"
```

Or use the provided scripts:
```bash
./quick_install_run.sh
```

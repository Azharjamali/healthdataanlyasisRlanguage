# Install Packages and Run App - Step by Step Guide

Your R installation has a configuration issue that prevents automatic package installation. Follow these steps:

## Step 1: Install Required Packages Manually

### Option A: Using R Console (Recommended)

1. **Open Terminal in Cursor** (press `` Ctrl+` ``)

2. **Type `R` and press Enter** to start R interactively:
   ```bash
   R
   ```

3. **Copy and paste ALL of these commands** into the R console:
   ```r
   # Set CRAN repository
   options(repos = c(CRAN = "https://cloud.r-project.org"))
   
   # Install ggplot2
   install.packages("ggplot2", dependencies = TRUE)
   
   # Install dplyr
   install.packages("dplyr", dependencies = TRUE)
   
   # Install DT
   install.packages("DT", dependencies = TRUE)
   
   # Verify installation
   library(ggplot2)
   library(dplyr)
   library(DT)
   
   # If no errors, installation was successful!
   # Type quit() to exit R
   quit()
   ```

### Option B: One-Line Installation

Open Terminal and run:
```bash
R -e "options(repos=c(CRAN='https://cloud.r-project.org')); install.packages(c('ggplot2','dplyr','DT'), dependencies=TRUE)"
```

### Option C: Using RStudio (Easiest)

1. Open **RStudio**
2. In the console, type:
   ```r
   install.packages(c("ggplot2", "dplyr", "DT"))
   ```
3. Press Enter and wait

---

## Step 2: Run the App

Once packages are installed, you can run the app using any of these methods:

### Method 1: Using Rscript (Easiest)
```bash
cd /Users/foodpapa/Desktop/rshinnyproject
Rscript -e "library(shiny); runApp('app.R', host='0.0.0.0', port=3838, launch.browser=TRUE)"
```

### Method 2: Using R Console
1. Start R: `R`
2. In R console:
   ```r
   setwd("/Users/foodpapa/Desktop/rshinnyproject")
   library(shiny)
   library(ggplot2)
   library(dplyr)
   library(DT)
   runApp("app.R", host="0.0.0.0", port=3838, launch.browser=TRUE)
   ```

### Method 3: Using the Shell Script
```bash
cd /Users/foodpapa/Desktop/rshinnyproject
chmod +x quick_install_run.sh
./quick_install_run.sh
```

---

## Step 3: Access the App

- The app will automatically open in your default web browser
- If it doesn't, manually go to: **http://localhost:3838**
- Press **Ctrl+C** in the terminal to stop the app

---

## Troubleshooting

### "Package not found" error
- Make sure you installed all packages (ggplot2, dplyr, DT)
- Try installing again: `install.packages("PACKAGE_NAME")`

### "Cannot open file" error
- Make sure you're in the correct directory
- Check that `app.R` and `diabetes_dataset.csv` exist in the folder

### "Port already in use" error
- Change the port number in the runApp command:
  ```r
  runApp("app.R", port=3839)  # Use different port
  ```

### App doesn't open in browser
- Manually navigate to: http://localhost:3838
- Or check the terminal output for the correct URL

---

## Quick Reference

**Install packages:**
```bash
R -e "install.packages(c('ggplot2','dplyr','DT'), repos='https://cloud.r-project.org')"
```

**Run app:**
```bash
cd /Users/foodpapa/Desktop/rshinnyproject
Rscript -e "library(shiny); runApp('app.R')"
```

---

Good luck! 🚀

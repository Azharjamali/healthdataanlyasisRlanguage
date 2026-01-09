# Simple Install and Run Instructions

## ⚡ Quick Command (Copy & Paste This!)

Open Terminal in Cursor (`` Ctrl+` ``) and run this single command:

```bash
cd /Users/foodpapa/Desktop/rshinnyproject && R --vanilla -e "options(repos=c(CRAN='https://cloud.r-project.org')); install.packages(c('ggplot2','dplyr','DT'), dependencies=TRUE); library(shiny); library(ggplot2); library(dplyr); library(DT); setwd('/Users/foodpapa/Desktop/rshinnyproject'); runApp('app.R', host='0.0.0.0', port=3838, launch.browser=TRUE)"
```

This will:
1. ✅ Install all missing packages (ggplot2, dplyr, DT)
2. ✅ Load all required libraries
3. ✅ Start the Shiny app
4. ✅ Open it in your browser automatically

---

## 📋 Step-by-Step (If the above doesn't work)

### Step 1: Install Packages

Run this command:
```bash
R --vanilla -e "options(repos=c(CRAN='https://cloud.r-project.org')); install.packages(c('ggplot2','dplyr','DT'), dependencies=TRUE)"
```

Wait for installation to complete (it may take 2-5 minutes).

### Step 2: Run the App

After installation, run:
```bash
cd /Users/foodpapa/Desktop/rshinnyproject
Rscript -e "library(shiny); library(ggplot2); library(dplyr); library(DT); runApp('app.R', host='0.0.0.0', port=3838, launch.browser=TRUE)"
```

---

## 🎯 Even Simpler - Use R Interactively

1. Open Terminal: `` Ctrl+` ``
2. Type: `R` and press Enter
3. Copy and paste this:
   ```r
   options(repos=c(CRAN="https://cloud.r-project.org"))
   install.packages(c("ggplot2","dplyr","DT"), dependencies=TRUE)
   ```
4. Wait for installation (may take a few minutes)
5. Once done, type:
   ```r
   setwd("/Users/foodpapa/Desktop/rshinnyproject")
   library(shiny)
   library(ggplot2)
   library(dplyr)
   library(DT)
   runApp("app.R", host="0.0.0.0", port=3838, launch.browser=TRUE)
   ```
6. The app will open in your browser!

---

## 🛑 To Stop the App

Press `Ctrl+C` in the terminal

---

## 🔍 Troubleshooting

**If packages fail to install:**
- Check your internet connection
- Try installing one at a time:
  ```r
  install.packages("ggplot2")
  install.packages("dplyr")
  install.packages("DT")
  ```

**If app won't start:**
- Make sure you're in the correct directory
- Check that `app.R` and `diabetes_dataset.csv` exist
- Look at terminal error messages

---

That's it! 🚀

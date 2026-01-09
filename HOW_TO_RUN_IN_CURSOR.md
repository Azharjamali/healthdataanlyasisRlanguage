# How to Run the Shiny App in Cursor

This guide explains different ways to run your Shiny app directly from Cursor (without RStudio).

## ✅ Prerequisites

1. **R must be installed** on your system
   - Check if R is installed: Open terminal and type `R --version`
   - If not installed, download from: https://cran.r-project.org/

2. **Required R packages** must be installed:
   - `shiny`
   - `ggplot2`
   - `dplyr`
   - `DT`

## 🚀 Method 1: Using the Shell Script (Easiest)

1. **Open Terminal in Cursor:**
   - Press `` Ctrl+` `` (backtick) or go to `Terminal > New Terminal`

2. **Make the script executable** (one-time setup):
   ```bash
   chmod +x run_app.sh
   ```

3. **Run the script:**
   ```bash
   ./run_app.sh
   ```

   This will:
   - Check if R is installed
   - Verify all required files exist
   - Install missing packages automatically
   - Launch the Shiny app

4. **The app will open** in your default web browser at `http://localhost:3838`

5. **To stop the app:** Press `Ctrl+C` in the terminal

---

## 🚀 Method 2: Using Rscript Command (Quick)

1. **Open Terminal in Cursor** (`` Ctrl+` ``)

2. **Navigate to the project folder** (if not already there):
   ```bash
   cd /Users/foodpapa/Desktop/rshinnyproject
   ```

3. **First, install packages** (if not already installed):
   ```bash
   Rscript -e "install.packages(c('shiny', 'ggplot2', 'dplyr', 'DT'), repos='https://cloud.r-project.org')"
   ```

4. **Run the app:**
   ```bash
   Rscript -e "library(shiny); runApp('app.R', host='0.0.0.0', port=3838)"
   ```

5. **Open your browser** and go to: `http://localhost:3838`

6. **To stop:** Press `Ctrl+C`

---

## 🚀 Method 3: Using R Interactive Console

1. **Open Terminal in Cursor** (`` Ctrl+` ``)

2. **Start R:**
   ```bash
   R
   ```

3. **In R console, run:**
   ```r
   # Set working directory
   setwd("/Users/foodpapa/Desktop/rshinnyproject")
   
   # Install packages if needed (one-time)
   install.packages(c("shiny", "ggplot2", "dplyr", "DT"))
   
   # Load Shiny
   library(shiny)
   
   # Run the app
   runApp("app.R")
   ```

4. **The app will open** automatically in your browser

5. **To stop:** Press `Ctrl+C` or type `quit()` and press Enter

---

## 🚀 Method 4: Using the R Script File

1. **Open Terminal in Cursor** (`` Ctrl+` ``)

2. **Run the R script:**
   ```bash
   Rscript run_app.R
   ```

   (Note: You may need to edit `run_app.R` to remove RStudio-specific code if you get an error)

---

## 📝 Quick Start (One-Liner)

If all packages are already installed, simply run:

```bash
cd /Users/foodpapa/Desktop/rshinnyproject && Rscript -e "library(shiny); runApp('app.R')"
```

---

## 🔧 Troubleshooting

### Problem: "command not found: R" or "Rscript"
**Solution:** 
- R is not installed or not in your PATH
- Install R from https://cran.r-project.org/
- On macOS, you might need to add R to PATH in `~/.zshrc` or `~/.bash_profile`

### Problem: "Package 'shiny' not found"
**Solution:**
```bash
Rscript -e "install.packages('shiny', repos='https://cloud.r-project.org')"
```
(Repeat for other missing packages)

### Problem: "Cannot open file 'diabetes_dataset.csv'"
**Solution:**
- Make sure you're in the correct directory
- Check if the CSV file exists: `ls diabetes_dataset.csv`
- Use absolute path if needed

### Problem: Port already in use
**Solution:**
- Change the port number in the command:
  ```r
  runApp("app.R", port = 3839)  # Use a different port
  ```

### Problem: App won't open in browser
**Solution:**
- Manually open: `http://localhost:3838` (or your chosen port)
- Check if the app is running by looking at terminal output

---

## 💡 Tips

1. **Keep the terminal open** - The app runs as long as the terminal session is active
2. **Check terminal output** - Any errors will appear in the terminal
3. **Use different ports** - If 3838 is busy, try 3839, 4040, etc.
4. **Background process** - To run in background (on Linux/Mac):
   ```bash
   nohup Rscript -e "library(shiny); runApp('app.R')" > app.log 2>&1 &
   ```

---

## 🎯 Recommended Method for Beginners

**Use Method 1 (Shell Script)** - It's the easiest and handles everything automatically!

```bash
chmod +x run_app.sh
./run_app.sh
```

---

Happy coding! 🎉

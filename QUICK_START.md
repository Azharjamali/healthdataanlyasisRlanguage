# Quick Start Guide - Health Data Analysis Dashboard

## 🚀 Fast Setup (3 Steps)

### Step 1: Install Required Packages
Open RStudio and run this in the console:
```r
install.packages(c("shiny", "ggplot2", "dplyr", "DT"))
```

### Step 2: Open and Run the App
1. Open `app.R` in RStudio
2. Click the **"Run App"** button (top-right of editor)
   - OR press `Ctrl+Shift+Enter` (Windows/Linux) or `Cmd+Shift+Enter` (Mac)

### Step 3: Use the Dashboard
- The app will open in your web browser automatically
- Use the filters on the left sidebar to explore data
- Click **"Apply Filters"** to update visualizations
- Browse through the tabs to see different charts and tables

## ✅ That's It!

Your app should now be running and displaying:
- Bar chart showing outcome distribution
- Pie chart showing diabetic vs non-diabetic proportion
- Histogram showing age distribution
- And much more!

## 📝 Files You Need

Make sure these files are in the same folder:
- ✅ `app.R` - Main application file
- ✅ `diabetes_dataset.csv` - Dataset file

## ❓ Troubleshooting

**Problem**: Packages not found
**Solution**: Run `install.packages(c("shiny", "ggplot2", "dplyr", "DT"))` again

**Problem**: CSV file not found
**Solution**: Make sure `diabetes_dataset.csv` is in the same folder as `app.R`

**Problem**: App won't start
**Solution**: Check the RStudio console for error messages (red text)

## 📚 Next Steps

- Read `README.md` for detailed documentation
- See deployment instructions for Shiny Cloud
- Customize the app by editing `app.R`

---

Happy analyzing! 📊

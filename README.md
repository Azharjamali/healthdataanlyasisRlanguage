# Health Data Analysis Dashboard

A comprehensive R Shiny web application for analyzing diabetes health data with interactive visualizations and data exploration tools.

## 📋 Overview

This Shiny application provides an interactive dashboard to explore and analyze diabetes-related health data. Users can filter data by gender, outcome, and age range, and view multiple visualizations including bar charts, pie charts, histograms, and scatter plots.

## 🎯 Features

- **Interactive Filtering**: Filter data by Gender, Outcome, and Age Range
- **Multiple Visualizations**:
  - Bar Chart: Outcome distribution
  - Pie Chart: Diabetic vs Non-Diabetic proportion
  - Histogram: Age distribution
  - Glucose level distribution
  - BMI boxplot by outcome
  - Scatter plot: Age vs Glucose
- **Interactive Data Table**: Searchable and sortable table with filtered results
- **Responsive Design**: Clean, user-friendly interface

## 📦 Required Packages

Before running the application, make sure you have the following R packages installed:

```r
install.packages(c("shiny", "ggplot2", "dplyr", "DT"))
```

### Package Descriptions:
- **shiny**: Web application framework for R
- **ggplot2**: Grammar of graphics for creating plots
- **dplyr**: Data manipulation and filtering
- **DT**: Interactive data tables

## 🚀 How to Run the App in RStudio

### Method 1: Using the Run App Button
1. Open RStudio
2. Open the `app.R` file in the editor
3. Click the **"Run App"** button in the top-right corner of the editor pane
4. Alternatively, press `Ctrl+Shift+Enter` (Windows/Linux) or `Cmd+Shift+Enter` (Mac)

### Method 2: Using the Console
1. Open RStudio
2. Set your working directory to the project folder:
   ```r
   setwd("path/to/rshinnyproject")
   ```
3. Run the app:
   ```r
   library(shiny)
   runApp("app.R")
   ```

### Method 3: Using source()
1. Open RStudio
2. Source the app.R file:
   ```r
   source("app.R")
   ```

## 📁 File Structure

```
rshinnyproject/
├── app.R                      # Main Shiny application file
├── diabetes_dataset.csv       # Diabetes dataset (CSV file)
├── README.md                  # This file
└── packages.txt              # List of required packages
```

## 📊 Dataset Information

The application uses a diabetes dataset (`diabetes_dataset.csv`) containing the following variables:
- **Pregnancies**: Number of pregnancies
- **Glucose**: Plasma glucose concentration
- **BloodPressure**: Diastolic blood pressure
- **SkinThickness**: Triceps skin fold thickness
- **Insulin**: 2-Hour serum insulin
- **BMI**: Body mass index
- **DiabetesPedigreeFunction**: Diabetes pedigree function
- **Age**: Age in years
- **Outcome**: 0 (Non-Diabetic) or 1 (Diabetic)
- **Gender**: Male or Female

## 🎮 Using the Application

1. **Apply Filters**: Use the sidebar filters to select:
   - Gender (All, Male, Female)
   - Outcome (All, Non-Diabetic, Diabetic)
   - Age Range (slider)

2. **Click "Apply Filters"**: Click the button to update all visualizations and the data table

3. **Explore Tabs**:
   - **Overview**: Main visualizations (bar, pie, histogram)
   - **Detailed Analysis**: Additional visualizations (glucose, BMI, scatter plot)
   - **Data Table**: Interactive table with filtered results

4. **Interactive Table**: Use the search box and column sorting in the data table tab

## 🌐 Deploying on Shiny Cloud (shinyapps.io)

### Prerequisites:
1. Create a free account at [shinyapps.io](https://www.shinyapps.io/)
2. Install the `rsconnect` package:
   ```r
   install.packages("rsconnect")
   ```

### Deployment Steps:

1. **Authorize your account** (one-time setup):
   ```r
   library(rsconnect)
   rsconnect::setAccountInfo(
     name = "your-account-name",
     token = "your-token",
     secret = "your-secret"
   )
   ```
   *Note: Get your token and secret from your shinyapps.io account dashboard*

2. **Deploy the application**:
   ```r
   library(rsconnect)
   deployApp(
     appDir = "path/to/rshinnyproject",
     appName = "health-data-dashboard",
     account = "your-account-name"
   )
   ```

3. **Alternative: Deploy via RStudio**:
   - In RStudio, go to **Tools > Global Options > Publishing**
   - Add your shinyapps.io account
   - Click **Publish** button in the top-right corner while viewing `app.R`

### Important Notes for Deployment:
- Ensure all required packages are listed in your code
- Make sure `diabetes_dataset.csv` is in the same directory as `app.R`
- The file structure will be preserved during deployment
- Check the deployment logs if you encounter any errors

## 🐛 Troubleshooting

### Error: "Could not find function..."
- **Solution**: Make sure all required packages are installed and loaded

### Error: "Cannot open file 'diabetes_dataset.csv'"
- **Solution**: Ensure `diabetes_dataset.csv` is in the same folder as `app.R`
- Check your working directory: `getwd()`

### Error: App won't start
- **Solution**: Check RStudio console for error messages
- Ensure all packages are installed: `install.packages(c("shiny", "ggplot2", "dplyr", "DT"))`

### Visualizations not updating
- **Solution**: Make sure you click the "Apply Filters" button after changing filter values

## 📝 Code Structure

The application follows a standard Shiny structure:
- **UI (User Interface)**: Defines the layout and appearance
- **Server**: Contains the logic for processing inputs and generating outputs
- **Reactive Expressions**: Handle data filtering and processing
- **Render Functions**: Generate outputs (plots, tables)

## 🔧 Customization

You can customize the application by:
- Modifying color schemes in the `col` parameters
- Adjusting plot titles and labels
- Adding new filter options
- Creating additional visualizations
- Changing the dataset (ensure CSV format matches expected structure)

## 📄 License

This is a sample project for educational purposes.

## 🤝 Support

For issues or questions:
1. Check the troubleshooting section above
2. Review Shiny documentation: https://shiny.rstudio.com/
3. Check package documentation for ggplot2, dplyr, and DT

---

**Happy Analyzing! 📊**

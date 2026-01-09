# =============================================================================
# Health Data Analysis Dashboard - Shiny Application
# =============================================================================
# This Shiny app provides an interactive dashboard for analyzing diabetes data
# It includes filtering options, multiple visualizations, and data tables
# =============================================================================

# Load required libraries
# If packages are not installed, use: install.packages(c("shiny", "ggplot2", "dplyr", "DT"))

library(shiny)      # For Shiny web application framework
library(ggplot2)    # For creating beautiful plots
library(dplyr)      # For data manipulation and filtering
library(DT)         # For interactive data tables

# =============================================================================
# USER INTERFACE (UI) - Defines the layout and appearance of the app
# =============================================================================

ui <- fluidPage(
  
  # Title Panel
  titlePanel(
    h1("Health Data Analysis Dashboard", 
       style = "color: #2c3e50; text-align: center; padding: 20px;")
  ),
  
  # Sidebar Layout: Sidebar for inputs, Main panel for outputs
  sidebarLayout(
    
    # ===== SIDEBAR PANEL - User Inputs =====
    sidebarPanel(
      width = 3,  # Sidebar takes 3 out of 12 columns (25% of width)
      
      h3("Filters", style = "color: #34495e; margin-top: 0;"),
      
      # Dropdown for Gender filter
      selectInput(
        inputId = "gender_filter",
        label = "Select Gender:",
        choices = c("All" = "All", "Male" = "Male", "Female" = "Female"),
        selected = "All"
      ),
      
      # Dropdown for Outcome filter
      selectInput(
        inputId = "outcome_filter",
        label = "Select Outcome:",
        choices = c("All" = "All", "Non-Diabetic (0)" = "0", "Diabetic (1)" = "1"),
        selected = "All"
      ),
      
      # Slider for Age range
      sliderInput(
        inputId = "age_range",
        label = "Age Range:",
        min = 20,
        max = 70,
        value = c(20, 70),
        step = 1
      ),
      
      # Action button to refresh/apply filters
      actionButton(
        inputId = "apply_filters",
        label = "Apply Filters",
        class = "btn-primary",
        style = "width: 100%; margin-top: 20px;"
      ),
      
      # Horizontal line separator
      hr(),
      
      # Information box
      h4("Dataset Info", style = "color: #34495e;"),
      verbatimTextOutput("data_info"),
      
      # Instructions
      br(),
      h4("Instructions", style = "color: #34495e;"),
      p("1. Use filters to explore the data", style = "font-size: 12px;"),
      p("2. Click 'Apply Filters' to update visualizations", style = "font-size: 12px;"),
      p("3. Scroll down to see all charts and data table", style = "font-size: 12px;")
      
    ),  # End of sidebarPanel
    
    # ===== MAIN PANEL - Outputs (Plots and Tables) =====
    mainPanel(
      width = 9,  # Main panel takes 9 out of 12 columns (75% of width)
      
      # Tabset Panel to organize outputs into tabs
      tabsetPanel(
        type = "tabs",
        
        # Tab 1: Overview
        tabPanel("Overview",
          fluidRow(
            column(6,
              h3("Bar Chart: Outcome Distribution", style = "text-align: center;"),
              plotOutput("bar_chart", height = "400px")
            ),
            column(6,
              h3("Pie Chart: Diabetic vs Non-Diabetic", style = "text-align: center;"),
              plotOutput("pie_chart", height = "400px")
            )
          ),
          br(),
          fluidRow(
            column(12,
              h3("Histogram: Age Distribution", style = "text-align: center;"),
              plotOutput("histogram_chart", height = "400px")
            )
          )
        ),
        
        # Tab 2: Detailed Analysis
        tabPanel("Detailed Analysis",
          fluidRow(
            column(6,
              h3("Glucose Level Distribution", style = "text-align: center;"),
              plotOutput("glucose_histogram", height = "400px")
            ),
            column(6,
              h3("BMI Distribution by Outcome", style = "text-align: center;"),
              plotOutput("bmi_boxplot", height = "400px")
            )
          ),
          br(),
          fluidRow(
            column(12,
              h3("Scatter Plot: Age vs Glucose", style = "text-align: center;"),
              plotOutput("scatter_plot", height = "400px")
            )
          )
        ),
        
        # Tab 3: Data Table
        tabPanel("Data Table",
          h3("Filtered Dataset"),
          p("Use the filters in the sidebar and click 'Apply Filters' to update the table."),
          br(),
          DT::dataTableOutput("data_table")
        )
        
      )  # End of tabsetPanel
      
    )  # End of mainPanel
    
  )  # End of sidebarLayout
  
)  # End of fluidPage

# =============================================================================
# SERVER - Contains the logic for processing inputs and generating outputs
# =============================================================================

server <- function(input, output, session) {
  
  # ===== LOAD DATA =====
  # Read the diabetes dataset from CSV file
  # Note: Make sure diabetes_dataset.csv is in the same folder as app.R
  diabetes_data <- reactive({
    tryCatch({
      data <- read.csv("diabetes_dataset.csv", stringsAsFactors = FALSE)
      
      # Handle missing values (replace 0s in certain columns with NA if they don't make sense)
      # Note: 0 in Glucose, BloodPressure, BMI might indicate missing values
      data$Glucose[data$Glucose == 0] <- NA
      data$BloodPressure[data$BloodPressure == 0] <- NA
      data$BMI[data$BMI == 0] <- NA
      
      # Convert Outcome to factor for better plotting
      data$Outcome <- factor(data$Outcome, levels = c(0, 1), labels = c("Non-Diabetic", "Diabetic"))
      
      # Convert Gender to factor
      data$Gender <- factor(data$Gender)
      
      return(data)
    }, error = function(e) {
      showNotification("Error loading dataset. Please ensure diabetes_dataset.csv exists in the project folder.",
                      type = "error", duration = 10)
      return(NULL)
    })
  })
  
  # ===== FILTERED DATA - Reactive expression that updates when filters change =====
  filtered_data <- eventReactive(input$apply_filters, {
    data <- diabetes_data()
    
    if (is.null(data)) return(NULL)
    
    # Apply Gender filter
    if (input$gender_filter != "All") {
      data <- data %>% filter(Gender == input$gender_filter)
    }
    
    # Apply Outcome filter
    if (input$outcome_filter != "All") {
      outcome_value <- ifelse(input$outcome_filter == "0", "Non-Diabetic", "Diabetic")
      data <- data %>% filter(Outcome == outcome_value)
    }
    
    # Apply Age range filter
    data <- data %>% filter(Age >= input$age_range[1] & Age <= input$age_range[2])
    
    return(data)
  }, ignoreNULL = FALSE)
  
  # Initialize filtered_data on app start (before filters are applied)
  filtered_data_initial <- reactive({
    diabetes_data()
  })
  
  # Choose which dataset to use based on whether filters have been applied
  active_data <- reactive({
    if (input$apply_filters > 0) {
      filtered_data()
    } else {
      filtered_data_initial()
    }
  })
  
  # ===== OUTPUT: Dataset Info =====
  output$data_info <- renderText({
    data <- active_data()
    if (is.null(data)) return("Dataset not loaded")
    
    paste(
      "Total Records:", nrow(data), "\n",
      "Diabetic:", sum(data$Outcome == "Diabetic", na.rm = TRUE), "\n",
      "Non-Diabetic:", sum(data$Outcome == "Non-Diabetic", na.rm = TRUE)
    )
  })
  
  # ===== OUTPUT 1: Bar Chart - Outcome Distribution =====
  output$bar_chart <- renderPlot({
    data <- active_data()
    if (is.null(data)) return(NULL)
    
    # Count outcomes
    outcome_counts <- table(data$Outcome)
    
    # Create bar chart using base R
    barplot(
      outcome_counts,
      main = "Distribution of Outcomes",
      xlab = "Outcome",
      ylab = "Number of Patients",
      col = c("#3498db", "#e74c3c"),  # Blue for Non-Diabetic, Red for Diabetic
      border = "white",
      ylim = c(0, max(outcome_counts) * 1.2),
      cex.names = 1.2,
      cex.axis = 1.1,
      cex.lab = 1.2
    )
    
    # Add value labels on bars
    text(
      x = barplot(outcome_counts, plot = FALSE),
      y = outcome_counts + max(outcome_counts) * 0.05,
      labels = outcome_counts,
      cex = 1.2,
      font = 2
    )
  })
  
  # ===== OUTPUT 2: Pie Chart - Diabetic vs Non-Diabetic =====
  output$pie_chart <- renderPlot({
    data <- active_data()
    if (is.null(data)) return(NULL)
    
    # Count outcomes
    outcome_counts <- table(data$Outcome)
    
    # Calculate percentages
    percentages <- round(100 * outcome_counts / sum(outcome_counts), 1)
    labels <- paste0(names(outcome_counts), "\n", percentages, "%")
    
    # Create pie chart using base R
    pie(
      outcome_counts,
      labels = labels,
      main = "Proportion of Diabetic vs Non-Diabetic Patients",
      col = c("#3498db", "#e74c3c"),
      border = "white",
      cex = 1.2,
      cex.main = 1.3
    )
  })
  
  # ===== OUTPUT 3: Histogram - Age Distribution =====
  output$histogram_chart <- renderPlot({
    data <- active_data()
    if (is.null(data)) return(NULL)
    
    # Remove missing values
    age_data <- data$Age[!is.na(data$Age)]
    
    # Create histogram using ggplot2
    ggplot(data, aes(x = Age)) +
      geom_histogram(
        bins = 20,
        fill = "#3498db",
        color = "white",
        alpha = 0.7
      ) +
      labs(
        title = "Age Distribution of Patients",
        x = "Age (years)",
        y = "Frequency"
      ) +
      theme_minimal() +
      theme(
        plot.title = element_text(size = 16, face = "bold", hjust = 0.5),
        axis.title = element_text(size = 12),
        axis.text = element_text(size = 11)
      )
  })
  
  # ===== OUTPUT 4: Histogram - Glucose Level Distribution =====
  output$glucose_histogram <- renderPlot({
    data <- active_data()
    if (is.null(data)) return(NULL)
    
    # Remove missing values
    data <- data[!is.na(data$Glucose), ]
    
    if (nrow(data) == 0) return(NULL)
    
    # Create histogram with ggplot2
    ggplot(data, aes(x = Glucose, fill = Outcome)) +
      geom_histogram(
        bins = 25,
        alpha = 0.7,
        position = "identity",
        color = "white"
      ) +
      scale_fill_manual(values = c("Non-Diabetic" = "#3498db", "Diabetic" = "#e74c3c")) +
      labs(
        title = "Glucose Level Distribution by Outcome",
        x = "Glucose Level (mg/dL)",
        y = "Frequency",
        fill = "Outcome"
      ) +
      theme_minimal() +
      theme(
        plot.title = element_text(size = 16, face = "bold", hjust = 0.5),
        axis.title = element_text(size = 12),
        axis.text = element_text(size = 11),
        legend.position = "right"
      )
  })
  
  # ===== OUTPUT 5: Boxplot - BMI Distribution by Outcome =====
  output$bmi_boxplot <- renderPlot({
    data <- active_data()
    if (is.null(data)) return(NULL)
    
    # Remove missing values
    data <- data[!is.na(data$BMI), ]
    
    if (nrow(data) == 0) return(NULL)
    
    # Create boxplot using ggplot2
    ggplot(data, aes(x = Outcome, y = BMI, fill = Outcome)) +
      geom_boxplot(alpha = 0.7, outlier.color = "#2c3e50") +
      scale_fill_manual(values = c("Non-Diabetic" = "#3498db", "Diabetic" = "#e74c3c")) +
      labs(
        title = "BMI Distribution by Outcome",
        x = "Outcome",
        y = "BMI (kg/m²)",
        fill = "Outcome"
      ) +
      theme_minimal() +
      theme(
        plot.title = element_text(size = 16, face = "bold", hjust = 0.5),
        axis.title = element_text(size = 12),
        axis.text = element_text(size = 11),
        legend.position = "none"
      )
  })
  
  # ===== OUTPUT 6: Scatter Plot - Age vs Glucose =====
  output$scatter_plot <- renderPlot({
    data <- active_data()
    if (is.null(data)) return(NULL)
    
    # Remove missing values
    data <- data[!is.na(data$Age) & !is.na(data$Glucose), ]
    
    if (nrow(data) == 0) return(NULL)
    
    # Create scatter plot using ggplot2
    ggplot(data, aes(x = Age, y = Glucose, color = Outcome)) +
      geom_point(alpha = 0.6, size = 2) +
      geom_smooth(method = "lm", se = TRUE, alpha = 0.2) +
      scale_color_manual(values = c("Non-Diabetic" = "#3498db", "Diabetic" = "#e74c3c")) +
      labs(
        title = "Relationship Between Age and Glucose Level",
        x = "Age (years)",
        y = "Glucose Level (mg/dL)",
        color = "Outcome"
      ) +
      theme_minimal() +
      theme(
        plot.title = element_text(size = 16, face = "bold", hjust = 0.5),
        axis.title = element_text(size = 12),
        axis.text = element_text(size = 11),
        legend.position = "right"
      )
  })
  
  # ===== OUTPUT 7: Interactive Data Table =====
  output$data_table <- DT::renderDataTable({
    data <- active_data()
    if (is.null(data)) return(NULL)
    
    # Display the filtered dataset in an interactive table
    DT::datatable(
      data,
      options = list(
        pageLength = 15,           # Show 15 rows per page
        scrollX = TRUE,            # Enable horizontal scrolling
        searching = TRUE,          # Enable search box
        ordering = TRUE            # Enable column sorting
      ),
      filter = "top",              # Show filter row at the top
      rownames = FALSE,            # Hide row numbers
      style = "bootstrap"          # Use Bootstrap styling
    )
  })
  
}  # End of server function

# =============================================================================
# RUN THE APPLICATION
# =============================================================================
# This line starts the Shiny app when you run this script in RStudio
shinyApp(ui = ui, server = server)

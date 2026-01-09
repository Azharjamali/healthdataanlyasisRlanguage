# =============================================================================
# Manual Package Installation Script
# =============================================================================
# Copy and paste these commands into R console, or source this file:
# source("install_packages_manual.R")
# =============================================================================

# Set CRAN repository
options(repos = c(CRAN = "https://cloud.r-project.org"))

# List of required packages
required_packages <- c("ggplot2", "dplyr", "DT")

cat("==========================================\n")
cat("Installing Required Packages\n")
cat("==========================================\n\n")

# Install each package
for(pkg in required_packages) {
  cat("Installing", pkg, "...\n")
  tryCatch({
    install.packages(pkg, dependencies = TRUE, repos = "https://cloud.r-project.org")
    cat("✅", pkg, "installed successfully!\n\n")
  }, error = function(e) {
    cat("❌ Error installing", pkg, ":", e$message, "\n")
    cat("Please install manually: install.packages('", pkg, "')\n\n", sep = "")
  })
}

cat("\nVerifying installation...\n")
all_installed <- TRUE
for(pkg in required_packages) {
  if(requireNamespace(pkg, quietly = TRUE)) {
    cat("✅", pkg, "- OK\n")
  } else {
    cat("❌", pkg, "- NOT INSTALLED\n")
    all_installed <- FALSE
  }
}

if(all_installed) {
  cat("\n✅ All packages installed successfully!\n")
  cat("You can now run the app using: runApp('app.R')\n")
} else {
  cat("\n❌ Some packages could not be installed.\n")
  cat("Please install them manually using install.packages()\n")
}

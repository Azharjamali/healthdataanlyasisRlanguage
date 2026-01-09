# Load base R first
library(utils)

# Set CRAN mirror
options(repos = c(CRAN = "https://cloud.r-project.org"))

# Required packages
required_packages <- c("ggplot2", "dplyr", "DT")

cat("==========================================\n")
cat("Installing Required Packages\n")
cat("==========================================\n\n")

for(pkg in required_packages) {
  if(!requireNamespace(pkg, quietly = TRUE)) {
    cat("Installing", pkg, "...\n")
    tryCatch({
      utils::install.packages(pkg, dependencies = TRUE, repos = "https://cloud.r-project.org")
      cat("✅", pkg, "installed successfully!\n\n")
    }, error = function(e) {
      cat("❌ Error installing", pkg, ":", e$message, "\n\n")
    })
  } else {
    cat("✅", pkg, "is already installed\n\n")
  }
}

cat("\nChecking installation...\n")
missing <- required_packages[!sapply(required_packages, requireNamespace, quietly = TRUE)]

if(length(missing) == 0) {
  cat("✅ All packages installed successfully!\n")
} else {
  cat("❌ The following packages could not be installed:\n")
  cat(paste(missing, collapse = ", "), "\n")
}

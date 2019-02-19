## Run all files to prepare "Getting Started in R" (Tidyverse Edition) Guide

# Setup
library(here)
here()

# Render the guide and produce the zip file for distribution.
rmarkdown::render("Getting-Started-in-R.Rmd")

# Create zip files to share with participants
# First empty the share folder and recreate the directory structure.
unlink(here("Share/*"), recursive = TRUE)
dir.create(here("Share", "Getting-Started-in-R"))

# Populate the Share directories
file.copy(here("Getting-Started-in-R.pdf"), here("Share", "Getting-Started-in-R"))
file.copy(here("ChickWeight.csv"), here("Share", "Getting-Started-in-R"))
file.copy(here("ExamplesAndExercises.R"), here("Share", "Getting-Started-in-R"))

# Creating (initialising) an RStudio project
rstudioapi::initializeProject(path = here("Share", "Getting-Started-in-R"))

# Using here() function with zip results in full paths in the zip files :(
# Not beautiful: Using setwd to overcome the full paths issue above.
setwd(here("Share"))
zip(here("Share", "Getting-Started-in-R.zip"), "./", extras = "-FS")
setwd(here())

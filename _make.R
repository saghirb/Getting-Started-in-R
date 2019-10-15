## Run all files to prepare "Getting Started in R" (Tidyverse Edition) Guide

# Setup
library(pdftools)
library(magick)
library(here)
here()

# Render the guide and produce the zip file for distribution.
rmarkdown::render("Getting-Started-in-R.Rmd")

# Create zip files to share with participants
# First empty the share folder and recreate the directory structure.
unlink(here("Share/"), recursive = TRUE, force = TRUE)
dir.create(here("Share"))
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

# Create an image for the README.md file
tempPNGs <- paste0("images/temp-", 1:2, ".png")
pdf_convert(here("Getting-Started-in-R.pdf"), "png", pages = 1:2,
            filenames = tempPNGs)

img1 <- image_read(tempPNGs[1])
img2 <- image_read(tempPNGs[2])

image_append(c(image_border(img1, geometry = "3x3"),
               image_border(img2, geometry = "3x3"))) %>%
  image_write(.,path=here("images", "GSiR-tv-guide.png"), format="png")

file.remove(tempPNGs)

# Image for GitHub settings
ghTemp <- "images/ghTemp.png"
test <- pdf_convert(here("Getting-Started-in-R.pdf"), "png", pages = 1, dpi = 155,
                    filenames = ghTemp)

  image_read(ghTemp) %>%
  image_crop(geometry_area(1280, 640, 0, 0), repage = FALSE) %>%
  image_write(., path=here("images", "GSiR-GitHub.png"), format="png")

  file.remove(ghTemp)

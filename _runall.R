# Render the guide and produce the zip file for distribution.
rmarkdown::render("Getting-Started-in-R.Rmd")

file.copy("Getting-Started-in-R.pdf", "public/Getting-Started-in-R/.", overwrite = TRUE)
file.copy("ChickWeight.csv", "public/Getting-Started-in-R/.", overwrite = TRUE)
setwd("public")
zip("Getting-Started-in-R.zip", "Getting-Started-in-R/", extras = "-FS")
setwd("..")

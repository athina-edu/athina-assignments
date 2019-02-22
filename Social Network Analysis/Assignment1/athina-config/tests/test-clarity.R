# Custom script for testing R clarity for scripts using lintr

args = commandArgs(trailingOnly=TRUE)
student_dir = args[1]
test_dir = args[2]

# Input configuration
student_code <- paste(student_dir,"/","assignment1.R",sep="")
instructor_code <- paste(test_dir,"/","assignment1.R",sep="")

# Evaluation code
library(lintr)
library(raster)
options(warn=-1)
lintr::lint_package(linters=subset(lintr::default_linters,!lintr::default_linters %in% lintr::default_linters["object_usage_linter"] ))

linter_output <- lint(student_code, with_defaults(object_usage_linter=NULL))

results = length(as.character(linter_output))

# Print results and final score
cat("This test utilizes the package lintr to identify compliance errors with your code. The output printed here for convenience has a lot of additional characters that cannot be properly rendered. I recommend using lintr on your installation instead.\n")
print(linter_output)
cat("\n")
grade <- clamp(((10-results) / 10) * 100, 0, 100)
cat(grade)
cat("\n")

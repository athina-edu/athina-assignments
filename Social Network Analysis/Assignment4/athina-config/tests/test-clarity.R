# Custom script for testing R clarity for scripts using lintr

args = commandArgs(trailingOnly=TRUE)
student_dir = args[1]
test_dir = args[2]

# Input configuration
student_code <- paste(student_dir,"/","assignment4.R",sep="")
instructor_code <- paste(test_dir,"/","assignment4.R",sep="")

# Evaluation code
library(lintr)
options(warn=-1)

# object_usage_linter is disabled: it needs to source the file to see which
# objects are used, which fails on files that expect data to exist at run time.
# (with_defaults() was renamed to linters_with_defaults() in lintr 3.0.)
linter_output <- lint(student_code, linters_with_defaults(object_usage_linter = NULL))

results = length(as.character(linter_output))

# Print results and final score
cat("This test utilizes the package lintr to identify compliance errors with your code. The output printed here for convenience has a lot of additional characters that cannot be properly rendered. I recommend using lintr on your installation instead.\n")
print(linter_output)
cat("\n")
# Clamp to [0, 100] without pulling in the raster package purely for clamp().
grade <- max(0, min(100, ((10-results) / 10) * 100))
cat(grade)
cat("\n")

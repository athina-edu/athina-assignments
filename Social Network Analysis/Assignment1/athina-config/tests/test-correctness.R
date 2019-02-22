# Custom script for testing R for ATHINA
# Expects a series of functions to be compared, question1, question2, etc.
# Iterate to 50 and as long as a function exists it checks it.

args = commandArgs(trailingOnly=TRUE)
student_dir = args[1]
test_dir = args[2]

# Input configuration
student_code <- paste(student_dir,"/","assignment1.R",sep="")
instructor_code <- paste(test_dir,"/","assignment1.R",sep="")

# Evaluation code
library(RecordLinkage)
options(warn=-1)

student_env <- new.env()
instructor_env <- new.env()
source(student_code, student_env)
source(instructor_code, instructor_env)

results = data.frame(question = c(1:50), result = c(NA), levenshtein_distance = c(NA))

for (i in (1:50)) {
  if (exists(paste("question", i, sep = ""), envir = student_env)) {
    student_codestring <- paste("student_env$question", i, "()", sep = "")
    instructor_codestring <-
      paste("instructor_env$question", i, "()", sep = "")
    
    objtest <- levenshteinSim(strtrim(paste(eval(parse(text = student_codestring)), collapse = ''), 2000),
                              strtrim(paste(eval(parse(text = instructor_codestring)), collapse = ''), 2000))
    if (length(objtest) == 0) {objtest = 0}
    if ( objtest == 1
        ) {
      results$test[i] <- i
      results$result[i] <- "PASS"
      results$levenshtein_distance[i] <- objtest
    } else {
      results$test[i] <- i
      results$result[i] <- "FAIL"
      results$levenshtein_distance[i] <- objtest
    }
  } else {
    break
  }
}

results = na.omit(results)

# Print results and final score
cat("This test evaluates your output with the desired output of a function. Since the correct answer cannot be displayed, you are given instead Levenstein distance between the string version of the output as an indicator to how close or far your answer is from the desired output. For numeric outcomes, this is not accurate and should still be used as an indicator only.\n")
print(results, row.names = F)
cat((nrow(results[results$result == "PASS",]) / nrow(results)) * 100)
cat("\n")

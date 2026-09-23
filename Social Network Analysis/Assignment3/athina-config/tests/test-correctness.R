# Custom script for testing R for ATHINA
# Expects a series of functions to be compared, question1, question2, etc.
# Iterate to 50 and as long as a function exists it checks it.

args = commandArgs(trailingOnly=TRUE)
student_dir = args[1]
test_dir = args[2]

# Input configuration
student_code <- paste(student_dir,"/","assignment3.R",sep="")
instructor_code <- paste(test_dir,"/","assignment3.R",sep="")

# Evaluation code
library(RecordLinkage)
options(warn=-1)

# Send any plotting the student's code performs at load time to a scratch
# device. Without this, a stray plot() writes Rplots.pdf into the current
# directory, which under Athina is the read-only tests/ mount, and R aborts the
# whole test run with "cannot open file 'Rplots.pdf'".
grDevices::pdf(NULL)

student_env <- new.env()
instructor_env <- new.env()
source(student_code, student_env)
source(instructor_code, instructor_env)

results = data.frame(question = c(1:50), result = c(NA), levenshtein_distance = c(NA))

# Evaluate one question, returning a similarity in [0, 1].
#
# Anything that goes wrong scores 0 rather than aborting the whole test:
#  - a student function that errors (tryCatch)
#  - a placeholder that returns NULL, which gives both strings zero length and
#    makes levenshteinSim return NaN. Comparing that NaN to 1 previously killed
#    the script with "missing value where TRUE/FALSE needed".
safe_similarity <- function(expr_student, expr_instructor) {
  student_value <- tryCatch(eval(parse(text = expr_student)),
                            error = function(e) NULL)
  instructor_value <- tryCatch(eval(parse(text = expr_instructor)),
                               error = function(e) NULL)

  student_string <- strtrim(paste(student_value, collapse = ''), 2000)
  instructor_string <- strtrim(paste(instructor_value, collapse = ''), 2000)

  similarity <- tryCatch(
    levenshteinSim(student_string, instructor_string),
    error = function(e) NA_real_)

  if (length(similarity) == 0 || !is.finite(similarity)) {
    return(0)
  }
  return(as.numeric(similarity))
}

for (i in (1:50)) {
  if (exists(paste("question", i, sep = ""), envir = student_env)) {
    student_codestring <- paste("student_env$question", i, "()", sep = "")
    instructor_codestring <-
      paste("instructor_env$question", i, "()", sep = "")
    
    objtest <- safe_similarity(student_codestring, instructor_codestring)

    results$question[i] <- i
    results$levenshtein_distance[i] <- round(objtest, 4)
    # Tolerance rather than exact equality: both sides are floating point.
    results$result[i] <- if (objtest >= 0.9999) "PASS" else "FAIL"
  } else {
    break
  }
}

results = results[!is.na(results$result), , drop = FALSE]

if (nrow(results) == 0) {
  cat("No questions were evaluated: none of the expected functions returned a value.\n")
  cat(0)
  cat("\n")
  quit(save = "no")
}

# Print results and final score
cat("This test evaluates your output with the desired output of a function. Since the correct answer cannot be displayed, you are given instead Levenstein distance between the string version of the output as an indicator to how close or far your answer is from the desired output. For numeric outcomes, this is not accurate and should still be used as an indicator only.\n")
print(results, row.names = F)
cat((nrow(results[results$result == "PASS",]) / nrow(results)) * 100)
cat("\n")

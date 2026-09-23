# Custom script for testing R for ATHINA
# Expects a series of functions to be compared, question1, question2, etc.
# Iterate to 50 and as long as a function exists it checks it.
#
# Called by Athina with two arguments:
#   args[1]  the student's code directory
#   args[2]  this tests directory (holds assignment4.R, the reference)
#
# The last line printed must be the numeric score out of 100.

args = commandArgs(trailingOnly=TRUE)
student_dir = args[1]
test_dir = args[2]

# Input configuration
student_code <- paste(student_dir,"/","assignment4.R",sep="")
instructor_code <- paste(test_dir,"/","assignment4.R",sep="")

# Evaluation code
library(RecordLinkage)
library(igraph)
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

results = data.frame(question = c(1:2), result = c(NA), euclideandist = c(NA))

# Run an expression and return a fallback if it errors, so that an unimplemented
# or broken function scores 0 instead of aborting the whole test run.
try_value <- function(expr, fallback = NULL) {
  tryCatch(expr, error = function(e) fallback)
}

# Q1: classify a set of graphs into model families.
i <- 1
graph_models <- list(igraph::sample_pa(100), igraph::sample_smallworld(1, 100, 5, 0.05), igraph::sample_smallworld(1, 100, 5, 0.8),
                     igraph::sample_smallworld(1, 100, 5, 0.9), igraph::sample_pa(200), igraph::sample_smallworld(1, 100, 5, 0.01))

expected_q1 <- c("sample_pa", "sample_smallworld_low", "sample_smallworld_high",
                 "sample_smallworld_high", "sample_pa", "sample_smallworld_low")

res <- try_value({
  out <- c()
  for (graph in graph_models) {
    out <- c(out, as.character(student_env$question1(graph)))
  }
  out
}, fallback = NULL)

results$question[i] <- i
results$euclideandist[i] <- 0
if (!is.null(res) && length(res) == length(expected_q1) && all(res == expected_q1)) {
  results$result[i] <- "PASS"
} else {
  results$result[i] <- "FAIL"
}

# Q2 testing
# ERGM comparison
i <- 2

q2_distance <- try_value({
  ins_res <- instructor_env$question2()
  stu_res <- student_env$question2()
  if (is.null(ins_res) || is.null(stu_res)) stop("question2 did not return a value")
  ins_res[is.na(ins_res)] <- 0
  stu_res[is.na(stu_res)] <- 0
  if (length(ins_res) != length(stu_res)) stop("question2 returned different lengths")
  as.numeric(dist(rbind(ins_res, stu_res)))
}, fallback = NA_real_)

results$question[i] <- i
results$euclideandist[i] <- if (is.na(q2_distance)) 0 else round(q2_distance, 4)
if (!is.na(q2_distance) && q2_distance < 0.01) {
  results$result[i] <- "PASS"
} else {
  results$result[i] <- "FAIL"
}

results = results[!is.na(results$result), , drop = FALSE]

if (nrow(results) == 0) {
  cat("No questions were evaluated: none of the expected functions returned a value.\n")
  cat(0)
  cat("\n")
  quit(save = "no")
}

# Print results and final score
cat("This test evaluates your output with the desired output of a function. Since the correct answer cannot be displayed, you are given instead Euclidean distance between the output and the desired output as an indicator to how close or far your answer is from the desired output. For numeric outcomes, this is not accurate and should still be used as an indicator only.\n")
print(results, row.names = F)
cat((nrow(results[results$result == "PASS", , drop = FALSE]) / nrow(results)) * 100)
cat("\n")

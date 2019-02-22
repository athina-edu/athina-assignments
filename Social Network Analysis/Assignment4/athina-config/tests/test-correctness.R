# Custom script for testing R for ATHINA
# Expects a series of functions to be compared, question1, question2, etc.
# Iterate to 50 and as long as a function exists it checks it.

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

student_env <- new.env()
instructor_env <- new.env()
source(student_code, student_env)
source(instructor_code, instructor_env)

results = data.frame(question = c(1:50), result = c(NA), euclideandist = c(NA))

# Q1 testing
i <- 1
graph_models <- list(igraph::sample_pa(100), igraph::sample_smallworld(1, 100, 5, 0.05), igraph::sample_smallworld(1, 100, 5, 0.8),
                     igraph::sample_smallworld(1, 100, 5, 0.9), igraph::sample_pa(200), igraph::sample_smallworld(1, 100, 5, 0.01))

res <- c()
for (graph in graph_models) {
  res <- rbind(res, student_env$question1(graph))
}

if ( res == c("sample_pa", "sample_smallworld_low", "sample_smallworld_high", "sample_smallworld_high",
              "sample_pa", "sample_smallworld_low")) {
  results$test[i] <- i
  results$result[i] <- "PASS"
  results$euclideandist[i] <- 0
} else {
  results$test[i] <- i
  results$result[i] <- "FAIL"
  results$euclideandist[i] <- 0
}

# Q2 testing
# ERGM comparison
i <- 2

ins_res <- instructor_env$question2()
stu_res <- student_env$question2()
ins_res[is.na(ins_res)] <- 0
stu_res[is.na(stu_res)] <- 0


if (dist(rbind(ins_res, stu_res)) < 0.01) {
  results$test[i] <- i
  results$result[i] <- "PASS"
  results$euclideandist[i] <- dist(rbind(ins_res, stu_res))
} else {
  results$test[i] <- i
  results$result[i] <- "FAIL"
  results$euclideandist[i] <- dist(rbind(ins_res, stu_res))
}

results = na.omit(results)

# Print results and final score
cat("This test evaluates your output with the desired output of a function. Since the correct answer cannot be displayed, you are given instead Levenstein distance between the string version of the output as an indicator to how close or far your answer is from the desired output. For numeric outcomes, this is not accurate and should still be used as an indicator only.\n")
print(results, row.names = F)
cat((nrow(results[results$result == "PASS",]) / nrow(results)) * 100)
cat("\n")

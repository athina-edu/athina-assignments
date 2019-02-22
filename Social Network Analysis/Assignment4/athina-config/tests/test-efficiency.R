# Custom script for testing R for ATHINA
# Testing efficiency of functions. Function names are question1....
# Testing up to 50 questions.

args = commandArgs(trailingOnly=TRUE)
student_dir = args[1]
test_dir = args[2]

# Input configuration
student_code <- paste(student_dir,"/","assignment4.R",sep="")
instructor_code <- paste(test_dir,"/","assignment4.R",sep="")

source("test-correctness.R")
results_correctness <- results


replicate <- 5

# Evaluation code
library(rbenchmark)
options(warn=-1)

student_env <- new.env()
instructor_env <- new.env()
source(student_code, student_env)
source(instructor_code, instructor_env)

results = data.frame(question = c(1:50), result = c(NA), time_diff = c(NA))

for (i in (1:50)) {
  cat(paste("Testing question",i,"\n"))
  if (exists(paste("question", i, sep = ""), envir = student_env)) {
    student_codestring <- paste("student_env$question", i, "()", sep = "")
    instructor_codestring <-
      paste("instructor_env$question", i, "()", sep = "")
    
    student_time <- benchmark(eval(parse(text = student_codestring)),
    replications = rep(1,replicate),
    columns = c("elapsed"))
    
    instructor_time <- benchmark(eval(parse(text = instructor_codestring)),
              replications = rep(1,replicate),
              columns = c("elapsed"))
    
    p.value <- t.test(student_time, instructor_time)$p.value[[1]]
    t.stat <- t.test(student_time, instructor_time)$statistic[[1]]
    df <- t.test(student_time, instructor_time)$parameter[[1]]
    
    if (p.value < 0.05 && sqrt((t.stat^2)/(t.stat^2 + df)) > 0.1 && t.stat > 0) { # Effect size and pvalue and positive diff
      results$test[i] <- i
      results$result[i] <- "FAIL"
      results$time_diff[i] <- sum(student_time)-sum(instructor_time)
    } else {
      results$test[i] <- i
      results$result[i] <- "PASS"
      results$time_diff[i] <- sum(student_time)-sum(instructor_time)
    }
  } else {
    break
  }
}

results = na.omit(results)

for (i in (1:nrow(results))) {
  if (results$result[i] == "PASS" && results_correctness$result[i] == "PASS") {
    results$result[i] <- "PASS"
  } else{
    results$result[i] <- "FAIL"
  }
}

# Print results and final score
cat("This test evaluates the efficiency of your functions compared to the instructors code.\n")
print(results, row.names = F)
cat((nrow(results[results$result == "PASS",]) / nrow(results)) * 100)
cat("\n")

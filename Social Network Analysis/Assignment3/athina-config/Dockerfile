# Athina test sandbox for the Social Network Analysis assignments.
# Built once per grading run; the entrypoint receives:
#   TEST              the test command, e.g. "Rscript test-correctness.R"
#   STUDENT_DIR       the student's submitted code
#   TEST_DIR          this assignment's tests/ directory
#
# The tests read the instructor reference (assignmentN.R) and the data files
# from TEST_DIR, so everything they need lives in tests/.

FROM rocker/r-ver:4.3.2

RUN apt-get update && apt-get install -y --no-install-recommends \
        bc git libcurl4-openssl-dev libssl-dev libxml2-dev time \
    && rm -rf /var/lib/apt/lists/*

# Test dependencies. RecordLinkage, rbenchmark and raster are not packaged for
# Debian, so they come from CRAN (or a pinned archive if they were removed).
RUN R -e "install.packages(c('lintr','rbenchmark','RecordLinkage','igraph','ergm','statnet'), \
    repos=c(CRAN='https://cloud.r-project.org', \
            Archive='https://cran.r-project.org/src/contrib/Archive'), \
    Ncpus=2)"

ENTRYPOINT cd $TEST_DIR && $TEST $STUDENT_DIR $TEST_DIR

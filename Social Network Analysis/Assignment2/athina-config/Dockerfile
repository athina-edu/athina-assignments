# Athina test sandbox for the Social Network Analysis assignments.
# Built once per grading run; the entrypoint receives:
#   TEST         the test command, e.g. "Rscript test-correctness.R"
#   STUDENT_DIR  the student's submitted code
#   TEST_DIR     this assignment's tests/ directory
#
# The tests read their data and the instructor reference (assignmentN.R) from
# TEST_DIR, so everything they need lives in tests/.

FROM rocker/r-ver:4.4.2

# libglpk40: igraph's binary links against GLPK; without it dyn.load fails with
# "libglpk.so.40: cannot open shared object file".
# libicu74: the stringi binary (a transitive dependency of ergm/statnet) links
# against ICU; without it loading ergm fails with
# "libicui18n.so.74: cannot open shared object file".
# The rest are common runtime deps of the network-analysis packages.
RUN apt-get update && apt-get install -y --no-install-recommends \
        bc git time libglpk40 libicu74 libxml2 libcurl4 libssl3 \
    && rm -rf /var/lib/apt/lists/*

# Test dependencies, installed from Posit Package Manager. PPM serves prebuilt
# binaries for Ubuntu, so these install in minutes instead of the 30+ minutes
# the CRAN source builds of igraph/ergm/statnet take (and those often fail on
# constrained memory). The distro in the URL (noble) must match the base image's
# Ubuntu release, otherwise the binaries link against missing system libraries
# (a jammy build of stringi, for example, needs libicu70 which noble does not
# ship).
RUN R -e "options(repos = c(PPM = 'https://packagemanager.posit.co/cran/__linux__/noble/latest'), \
    Ncpus = max(1, parallel::detectCores())); \
    install.packages(c('lintr', 'rbenchmark', 'RecordLinkage', 'igraph', 'ergm', 'statnet'))"

ENTRYPOINT cd $TEST_DIR && $TEST $STUDENT_DIR $TEST_DIR

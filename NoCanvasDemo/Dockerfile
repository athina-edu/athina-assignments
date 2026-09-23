# Athina test sandbox for the NoCanvasDemo assignment.
# Built by the grading engine before tests run; the entrypoint receives:
#   TEST         the test command, e.g. "bash test-correctness.sh"
#   STUDENT_DIR  the student's submitted code
#   TEST_DIR     this assignment's tests/ directory

FROM python:3.12-slim

RUN apt-get update && apt-get install -y --no-install-recommends time \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT cd $TEST_DIR && $TEST $STUDENT_DIR $TEST_DIR

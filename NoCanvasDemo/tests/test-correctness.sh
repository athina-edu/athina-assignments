#!/usr/bin/env bash
# Correctness test for the NoCanvasDemo assignment.
#
# Athina calls this with two arguments (and the working directory set to the
# tests directory):
#   $1  the student's code directory
#   $2  this tests directory
#
# The last line printed must be a numeric score out of 100.

STUDENT_DIR="$1"
TEST_DIR="$2"

echo "Checking submission in: $STUDENT_DIR"
echo

# This demo expects a hello.py that prints a greeting.
TARGET="$STUDENT_DIR/hello.py"

if [ ! -f "$TARGET" ]; then
    echo "No hello.py found in the submission."
    echo 0
    exit 0
fi

echo "--- hello.py ---"
cat "$TARGET"
echo "---------------"
echo

output=$(cd "$STUDENT_DIR" && python3 hello.py 2>&1)
status=$?

echo "Program output:"
echo "$output"
echo

if [ $status -ne 0 ]; then
    echo "hello.py exited with status $status."
    echo 0
    exit 0
fi

# Score on whether the program actually printed something.
if [ -n "$output" ]; then
    echo "hello.py produced output."
    echo 100
else
    echo "hello.py produced no output."
    echo 0
fi

#!/usr/bin/env bash
# Clarity test for the NoCanvasDemo assignment.
#
# Scored out of 100. The last line printed must be the numeric score.
#
#   $1  the student's code directory
#   $2  this tests directory

STUDENT_DIR="$1"
TEST_DIR="$2"

TARGET="$STUDENT_DIR/hello.py"

if [ ! -f "$TARGET" ]; then
    echo "No hello.py found in the submission."
    echo 0
    exit 0
fi

issues=0

# Long lines are harder to read.
long_lines=$(awk 'length > 100' "$TARGET" | wc -l)
if [ "$long_lines" -gt 0 ]; then
    echo "$long_lines line(s) exceed 100 characters."
    issues=$((issues + long_lines))
fi

# Tabs mixed with spaces cause inconsistent rendering.
if grep -qP '\t' "$TARGET" 2>/dev/null; then
    echo "File contains tab characters; prefer spaces."
    issues=$((issues + 1))
fi

# A module docstring or leading comment makes the intent clear.
if ! head -5 "$TARGET" | grep -qE '^\s*(#|"""|\x27\x27\x27)'; then
    echo "No leading comment or docstring explaining the file."
    issues=$((issues + 1))
fi

echo
echo "Clarity issues found: $issues"

score=$(( (10 - issues) * 10 ))
if [ "$score" -lt 0 ]; then score=0; fi
echo "$score"

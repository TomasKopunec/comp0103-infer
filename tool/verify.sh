#!/bin/bash

# Script to be used inside Docker container

filename=$1

if [ -z "$filename" ]; then
    echo "No file path provided."
    exit 1
fi

javac "$filename"
if [ $? -ne 0 ]; then
    echo "Compilation failed."
    exit 1
fi

classname=$(basename "$filename" .java)
echo "Running verification for $classname..."

# 1. Run SpotBugs
printf "\n"
echo "SpotBugs"
spotbugs -textui -effort:max -progress -emacs=spotbugs_report.txt $classname.class
if [ -s spotbugs_report.txt ]; then
    echo "FAILED X"
    cat spotbugs_report.txt
    exit 1
else
    echo "OK ✓"
fi

# 2. Run Meta Infer
printf "\n"
echo "Meta Infer"
infer run -p --quiet -- javac $filename
if [ -s infer-out/report.txt ]; then
    echo "FAILED X"
    cat infer-out/report.txt
    exit 1
else
    echo "OK ✓"
fi

echo "Verification completed successfully. No issues found."
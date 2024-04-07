#!/bin/bash

# 1. Add SpotBugs plugin to project
echo "Preparing analysis"
/usr/local/bin/add_spotbugs.sh ./app/build.gradle
if [ $? -ne 0 ]; then
    echo "Failed to add SpotBugs to the project X"
    exit 1
fi
echo "✓ Plugins initialized"

# 2. Run SpotBugs
echo "SpotBugs Analysis"
spotbugs_out=$(gradle clean build spotbugsMain)
if ! grep -q "SpotBugs ended with exit code 1" <<< "$spotbugs_out"; then
    echo "✓ SpotBugs Passed"
else
    trimmed=$(sed -n '/> Task :app:spotbugsMain/,/SpotBugs ended with exit code 1/{//!p}')
    echo "X Failure:"
    echo "$trimmed"
    exit 1
fi

# 3. Run Infer
echo "Infer Analysis"
infer run -- gradle clean build > /dev/null 2>&1
infer_out=$(cat infer-out/report.txt)
if [ -z "$infer_out" ]; then
    echo "✓ Infer Passed"
else
    echo "X Failure:"
    echo "$spotbugs_out"
    exit 1
fi
echo "Verification completed successfully. No issues found."

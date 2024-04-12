#!/bin/bash

# Optional Java file argument
JAVA_FILE_NAME=$1
if [ -z "$JAVA_FILE_NAME" ]; then
    echo "Performing analysis on the whole project"
else
    echo "Performing analysis on class $JAVA_FILE_NAME"
fi

# 1. Add SpotBugs plugin to project
/usr/local/bin/add_spotbugs.sh ./app/build.gradle
if [ $? -ne 0 ]; then
    echo "Failed to add SpotBugs to the project X"
    exit 1
fi
echo "✓ Plugins initialized"

# 2. Run SpotBugs
echo "SpotBugs Analysis"
spotbugs_out=$(gradle clean build spotbugsMain)
# Check if the analysis passed
if ! grep -q "SpotBugs ended with exit code 1" <<< "$spotbugs_out"; then
    echo "✓ SpotBugs Passed"
else
    echo "X Failures:"
    trimmed=$(echo "$spotbugs_out" | sed -n '/> Task :app:spotbugsMain/,/SpotBugs ended with exit code 1/{//!p}')
    if [ -z "$JAVA_FILE_NAME" ]; then
        echo "$trimmed"
    else
        echo "$trimmed" | grep "$JAVA_FILE_NAME"
    fi
    exit 1
fi

# 3. Run Infer
echo "Infer Analysis"
infer run -- gradle clean build > /dev/null 2>&1
infer_out=$(cat infer-out/report.txt)
if [ -z "$infer_out" ]; then
    echo "✓ Infer Passed"
else
    echo "X Failures:"
    if [ -z "$JAVA_FILE_NAME" ]; then
        echo "$infer_out"
    else
        package_name=$(echo "$JAVA_FILE_NAME" | tr '/' '.')
        echo "$infer_out" | awk -v class="$package_name" '/#/{p=0} $1 ~ class{p=1} p'
    fi
    exit 1
fi
echo "Verification completed successfully. No issues found."


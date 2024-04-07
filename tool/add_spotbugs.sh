#!/bin/bash

# Check if the number of arguments is correct
if [ $# -ne 1 ]; then
    echo "Usage: $0 <path_to_build_gradle>"
    exit 1
fi

build_gradle_path="$1"

new_plugin='    id "com.github.spotbugs" version "6.0.9"'

# Check if the new plugin configuration already exists in build.gradle
if ! grep -q "$new_plugin" "$build_gradle_path"; then
    # Append the new plugin configuration after the "plugins {" line in build.gradle
    sed -i '/plugins {/a\
'"$new_plugin"'
' "$build_gradle_path"
fi

# Check if the spotbugs configuration already exists in build.gradle
if ! grep -q "spotbugs {" "$build_gradle_path"; then
    # Append the spotbugs configuration after the new plugin
    echo "
spotbugs {
    ignoreFailures = true
}" >> "$build_gradle_path"
fi


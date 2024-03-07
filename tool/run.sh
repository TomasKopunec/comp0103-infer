#!/bin/bash

# External script to check if Docker container is running and start it if not

if [ -z "$1" ]; then
    echo "Usage: $0 <file>"
    exit 1
fi

if [ ! -e "$1" ]; then
    echo "File $1 does not exist."
    exit 1
fi

filepath=$(realpath "$1")
filename=$(basename "$filepath")

echo "Running verification for $filename..."

# Name of the Docker container for identification
container_name="java_verification_tool"

# Check if the container is already running
if [ $(docker ps -q -f name=^/${container_name}$) ]; then
    echo "Verification tool is already running."
    # docker stop "${container_name}"
else
    echo "Starting verification tool..."
    # docker build -t java_verification_tool .
    docker run --rm -v "${filepath}:/app/${filename}" --name "${container_name}" java_verification_tool ${filename}
fi

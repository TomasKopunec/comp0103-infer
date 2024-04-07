#!/bin/bash

# External script to check if Docker container is running and start it if not
if [ -z "$1" ]; then
    echo "Usage: $0 <Gradle_project_path>"
    exit 1
fi

if [ ! -d "$1" ]; then
    echo "Directory $1 does not exist."
    exit 1
fi

project_path=$(realpath "$1")
container_name="new"

# Check if the container is already running
if [ $(docker ps -q -f name=^/${container_name}$) ]; then
    docker stop "${container_name}"
    echo "Container ${container_name} stopped."
fi

# Remove the existing container if it exists
echo "Building Docker container for $(basename $project_path)"
docker rm "${container_name}" >/dev/null 2>&1 || true
docker build -t $container_name . > /dev/null 2>&1
echo "✓ Container Built"
docker run --rm --name ${container_name} -v "$project_path:/app" $container_name
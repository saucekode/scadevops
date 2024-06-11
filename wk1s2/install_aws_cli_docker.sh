#!/bin/bash

set -e

echo "Installing AWS CLI in Docker..."

temp_dir=$(mktemp -d)
cd "$temp_dir"

cat <<EOF > Dockerfile
FROM ubuntu:latest

RUN apt-get update && \\
    apt-get install -y curl unzip && \\
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \\
    unzip awscliv2.zip && \\
    ./aws/install && \\
    rm -rf awscliv2.zip aws && \\
    apt-get clean

EOF

# Build the Docker image
docker build -t aws-cli .

# Run the Docker container
docker run --rm aws-cli

# Clean up temporary directory
cd -
rm -rf "$temp_dir"

echo "AWS CLI installed successfully in Docker."

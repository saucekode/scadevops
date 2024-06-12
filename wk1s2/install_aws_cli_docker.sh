#!/bin/bash

set -e

# Define the marker file path
marker_file="$HOME/.docker_ownership_changed"

# Check if the ownership change has been done before
if [ ! -f "$marker_file" ]; then
    echo "Would you like to give root privileges to the Docker directory? (y/n):"
    read response

    if [[ "$response" == "y" || "$response" == "Y" ]]; then
        sudo chown -R $(id -u):$(id -g) $HOME/.docker
        echo "Ownership of the Docker directory has been changed."
        # Create the marker file to indicate that ownership has been changed
        touch "$marker_file"
    else
        echo "Ownership change was skipped."
    fi
else
    echo "Docker directory ownership has already been changed. Skipping prompt."
fi

echo "Installing AWS CLI in Docker..."

# Create a temporary directory
temp_dir=$(mktemp -d)
cd "$temp_dir"

# Create Dockerfile
cat <<EOF > Dockerfile
FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y curl unzip && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf awscliv2.zip aws && \
    apt-get clean
EOF

# Build the Docker image
docker build -t aws-cli .

echo "Would you like to give your container a custom name? (y/n):"
read nameresponse

if [[ "$nameresponse" == "y" || "$nameresponse" == "Y" ]]; then
    # Prompt for container name
    echo "Please enter a name for the Docker container:"
    read container_name

    # Run the Docker container
    docker run --name "$container_name" aws-cli
else
    docker run --rm aws-cli
fi

# Clean up temporary directory
cd -
rm -rf "$temp_dir"

echo "AWS CLI installed successfully in Docker."


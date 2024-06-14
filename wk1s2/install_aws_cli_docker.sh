#!/bin/bash

set -e

echo "Pulling AWS CLI Docker image..."

docker run --rm -it amazon/aws-cli --version

echo "AWS CLI pulled successfully....😊"

echo "Configuring aws....opurrr 😊"

echo "Spinning up container.....opurrr 😊"

read -p "Would you like a custom name for your container? (y/n): " containerconsent

if [[ "$containerconsent" == "y" || "$containerconsent" == "Y" ]]; then
    read -p "Please enter a name for the Docker container: " container_name
    docker run --name "$container_name" -it amazon/aws-cli configure

else
    docker run -it amazon/aws-cli configure
fi



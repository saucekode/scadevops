#!/bin/bash
set -e

# Start aws CLI installation
if [ "$1" == "--aws install" ]; then
    ./install_aws_cli.sh
    exit 0

elif [ "$1 $2" == "--docker aws" ]; then
    ./install_aws_cli_docker.sh
    exit 0

# Configure aws
elif [ "$1" == "--aws configure" ]; then
    ./aws_configure.sh
    exit 0

# Create S3 bucker
elif [ "$1" == "--aws s3bucket" ]; then
    ./create_s3_bucket.sh
    exit 0

# Create an iam user
elif [ "$1" == "--iam setup" ]; then
    ./iam_user_setup.sh
    exit 0

else
    echo "Command not supported!"
fi




#!/bin/bash

# Start aws CLI installation
if [ "$1" == "--install" ]; then
    ./install_aws_cli.sh
    exit 0

# Configure aws
elif [ "$1" == "--configure" ]; then
    ./aws_configure.sh
    exit 0

# Create an iam user
elif [ "$1" == "--setup" ]; then
    ./iam_user_setup.sh
    exit 0

# Create S3 bucker
elif [ "$1" == "--bucket" ]; then
    ./create_s3_bucket.sh
    exit 0

# Link bucket to an iam user
elif [ "$1" == "--link" ]; then
    ./awsS3_iam_link.sh
    exit 0
    
else
    echo "Mode not detected!"
fi




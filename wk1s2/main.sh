#!/bin/bash
set -e

# Start aws CLI installation
if [ "$1 $2" == "--no-docker aws" ]; then
    ./install_aws_cli.sh
    exit 0

elif [ "$1 $2" == "--docker aws" ]; then
    ./install_aws_cli_docker.sh
    exit 0

elif [ "$1 $2" == "--user-setup aws" ]; then
    ./iam_user_setup.sh
    exit 0

else
    echo "Command not supported!"
fi





#!/bin/bash

set -e

# Install AWS CLI on macOS
install_aws_cli_macos() {
    echo "Installing AWS CLI on macOS..."
    curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
    sudo installer -pkg AWSCLIV2.pkg -target /
    rm AWSCLIV2.pkg
    echo "AWS CLI installed successfully on macOS."
}

# Install AWS CLI on Linux
install_aws_cli_linux() {
    echo "Installing AWS CLI on Linux..."
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
    rm -rf awscliv2.zip aws
    echo "AWS CLI installed successfully on Linux."
}

# Install AWS CLI on Windows (using WSL)
install_aws_cli_windows() {
    echo "Installing AWS CLI on Windows (WSL)..."
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
    rm -rf awscliv2.zip aws
    echo "AWS CLI installed successfully on Windows (WSL)."
}

OS="$(uname -s)"
case "${OS}" in
    Darwin)
        install_aws_cli_macos
        ;;
    Linux)
        if grep -q Microsoft /proc/version; then
            install_aws_cli_windows
        else
            install_aws_cli_linux
        fi
        ;;
    CYGWIN*|MINGW*|MSYS*)
        echo "Detected Windows, please use PowerShell or CMD for installation."
        ;;
    *)
        echo "Unsupported OS: ${OS}"
        exit 1
        ;;
esac

aws --version

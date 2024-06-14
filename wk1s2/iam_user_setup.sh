#!/bin/bash

set -e

read -p "Please enter a name docker container: " container_name

echo "Create new IAM user..."
read -p "Please enter user name: " uname
docker exec -it $container_name aws iam create-user --user-name $uname

echo "Create new IAM user login profile. Generating user password..."
docker exec -it $container_name aws iam create-login-profile --user-name $uname --password StrongPassword123! --password-reset-required

echo "Create new IAM user access key..."
docker exec -it $container_name aws iam create-access-key --user-name $uname

echo "Setting up IAM user policies..."
docker exec -it $container_name aws iam attach-user-policy --user-name $uname --policy-arn arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess

#!/bin/bash

set -e

echo "View all your running containers..."
docker ps
read -p "Please enter docker container: " container_name

if [[ -z "$container_name" ]]; then
    echo "No container selected. Exiting..."
    exit 0
fi

echo "Create new IAM user..."
read -p "Please enter user name: " uname
docker exec -it $container_name aws iam create-user --user-name $uname

echo "Create new IAM user login profile...."
read -p "Please enter user password: " pword
docker exec -it $container_name aws iam create-login-profile --user-name $uname --password $pword --password-reset-required

echo "Create new IAM user access key..."
docker exec -it $container_name aws iam create-access-key --user-name $uname

echo "Setting up IAM user policies..."
docker exec -it $container_name aws iam attach-user-policy --user-name $uname --policy-arn arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess
docker exec -it $container_name aws iam attach-user-policy --user-name $uname --policy-arn arn:aws:iam::aws:policy/IAMUserChangePassword
#!/usr/bin/env bash

# awscli needs to installed and configured, see https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 628654266155.dkr.ecr.us-east-1.amazonaws.com

docker build -t php-app-rep .

docker tag php-app-rep:latest 628654266155.dkr.ecr.us-east-1.amazonaws.com/php-app-rep:latest

docker push 628654266155.dkr.ecr.us-east-1.amazonaws.com/php-app-rep:latest
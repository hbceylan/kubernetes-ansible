#!/bin/bash

# Set Environmests
BUCKET_NAME=prod-k8s-devops-tech-net

# Create bucket for k8s state store
aws s3api create-bucket \
--bucket $BUCKET_NAME 

# Enable bucket versioning for k8s backup
aws s3api put-bucket-versioning \
--bucket $BUCKET_NAME \
--versioning-configuration Status=Enabled
#!/bin/bash

# Set Environments
BUCKET_NAME=prod-k8s-devops-tech-net

# Enable bucket versioning for k8s backup
aws s3api put-bucket-versioning \
--bucket $BUCKET_NAME \
--versioning-configuration Status=Suspended

# Remove older versioned files
set -e
echo "Removing all versions from $bucket"

versions=`aws s3api list-object-versions --bucket $BUCKET_NAME |jq '.Versions'`
markers=`aws s3api list-object-versions --bucket $BUCKET_NAME |jq '.DeleteMarkers'`

echo "removing files"
for version in $(echo "${versions}" | jq -r '.[] | @base64'); do 
    version=$(echo ${version} | base64 --decode)

    key=`echo $version | jq -r .Key`
    versionId=`echo $version | jq -r .VersionId `
    cmd="aws s3api delete-object --bucket $BUCKET_NAME --key $key --version-id $versionId"
    echo $cmd
    $cmd
done

echo "removing delete markers"
for marker in $(echo "${markers}" | jq -r '.[] | @base64'); do 
    marker=$(echo ${marker} | base64 --decode)

    key=`echo $marker | jq -r .Key`
    versionId=`echo $marker | jq -r .VersionId `
    cmd="aws s3api delete-object --bucket $BUCKET_NAME --key $key --version-id $versionId"
    echo $cmd
    $cmd
done

# Create bucket for k8s state store
aws s3api delete-bucket \
--bucket $BUCKET_NAME 
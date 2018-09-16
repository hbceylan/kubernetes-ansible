#!/bin/bash

# Set Environments
CLUSTER_NAME=devops-tech.net
S3_STATE_STORE=s3://prod-k8s-devops-tech-net

# Delete Cluster
kops delete cluster --v=0 \
--name $CLUSTER_NAME \
--state $S3_STATE_STORE \
--yes \
2>&1 | tee $HOME/delete-cluster.txt
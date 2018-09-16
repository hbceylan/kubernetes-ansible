#!/bin/bash

# Set Environments
CLUSTER_NAME=devops-tech.net
S3_STATE_STORE=s3://prod-k8s-devops-tech-net
SSH_KEY=~/.ssh/id_rsa.pub
KOPS_CLOUD=aws
MASTER_COUNT=1
MASTER_SIZE=t2.medium
NODE_COUNT=1
NODE_SIZE=t2.medium
AWS_ZONES=us-east-1a,us-east-1b,us-east-1c
NETWORK_PROVIDER=calico

# Create Cluster
echo "## KOPS Cluster Creating on $KOPS_CLOUD ##"
kops create cluster --v=0 \
--name $CLUSTER_NAME \
--master-count $MASTER_COUNT \
--master-size $MASTER_SIZE \
--node-count $NODE_COUNT \
--node-size $NODE_SIZE \
--zones $AWS_ZONES \
--networking $NETWORK_PROVIDER \
--state $S3_STATE_STORE \
2>&1 | tee $HOME/create-cluster.txt

# Deploy Cluster
echo "## KOPS Cluster Updating.. ##"
kops update cluster \
--name $CLUSTER_NAME \
--state $S3_STATE_STORE \
--yes
echo "## KOPS Cluster Updated! ##"
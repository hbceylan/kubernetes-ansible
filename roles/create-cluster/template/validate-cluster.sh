#!/bin/bash

# Set Environments
CLUSTER_NAME=devops-tech.net
S3_STATE_STORE=s3://prod-k8s-devops-tech-net

# Validate Cluster
kubectl config use-context ${CLUSTER_NAME}
echo -n "Waiting for cluster components to become ready."
until [ $(kubectl get cs 2> /dev/null| grep -e Healthy | wc -l | xargs) -ge 4 ]
do
  echo -n "."
  sleep 1
done
echo "Cluster components are ready!"

# Validate least 1 node available
echo -n "Waiting for minimum nodes to become ready."
min_nodes=$(kops get ig nodes --name ${CLUSTER_NAME} --state $S3_STATE_STORE| grep nodes | awk '{print $4}')
until [ "$(kubectl get nodes 2> /dev/null| grep -v node | grep -e Ready | wc -l | xargs)" == "$min_nodes" ]
do
  echo -n "."
  sleep 1
done
echo "Cluster nodes are ready!"
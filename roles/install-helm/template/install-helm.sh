#!/bin/bash

# Set Environments
SERVICE_ACCOUNT_NAME=tiller
CLUSTER_ROLE=cluster-admin
CLUSTER_ROLE_NAME=tiller-cluster-role

# Initialize helm 
helm init

# Create tiller service account. Because we're using RBAC
kubectl create serviceaccount --namespace kube-system $SERVICE_ACCOUNT_NAME

# Create clusterrolbindind as a cluster-admin and bind tiller service account
kubectl create clusterrolebinding $CLUSTER_ROLE_NAME --clusterrole=$CLUSTER_ROLE --serviceaccount=kube-system:$SERVICE_ACCOUNT_NAME

# Update the existing tiller deployment
helm init --service-account $SERVICE_ACCOUNT_NAME --upgrade

# Ppdate repo
helm repo update
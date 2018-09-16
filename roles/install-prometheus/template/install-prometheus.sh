#!/bin/bash

# Set environments
NAMESPACE=monitoring
REPO=coreos
REPO_URL=https://s3-eu-west-1.amazonaws.com/coreos-charts/stable/
OPERATOR_REPO=coreos/prometheus-operator
OPERATOR_NAME=prometheus-operator
PROMETHEUS_REPO=coreos/kube-prometheus
PROMETHEUS_NAME=kube-prometheus

# Validate tiller pod
echo -n "Waiting for tiller pod become ready."
tiller_pod=$(kubectl get pods -n kube-system |grep tiller | awk '{print $1}')
until [ "$(kubectl get pods -n kube-system |grep tiller | awk '{print $1,$2,$3}')" == "$tiller_pod 1/1 Running" ]
do
  echo -n "."
  sleep 1
done
echo "Tiller pod are ready!"

# Add repo
helm repo add $REPO $REPO_URL
# Install prometheus-operator
helm install $OPERATOR_REPO --name $OPERATOR_NAME --namespace $NAMESPACE
# Install prometheus
helm install $PROMETHEUS_REPO --name $PROMETHEUS_NAME --namespace $NAMESPACE


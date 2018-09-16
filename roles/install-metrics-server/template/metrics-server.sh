#!/bin/bash

# Add template path
TEMPLATE_PATH=roles/install-metrics-server/template

# Install metrics-server for K8s cluster monitoring
kubectl apply -f $TEMPLATE_PATH/metrics-server.yaml
#!/bin/bash

# Set Environments
TEMPLATE_PATH=roles/install-prometheus/template

# Add pods alert rule
kubectl apply -f $TEMPLATE_PATH/pods-alert.yaml
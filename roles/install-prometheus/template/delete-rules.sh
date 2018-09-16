#!/bin/bash

# Delete pre-configured rules
kubectl delete prometheusrule -n monitoring kube-prometheus
kubectl delete prometheusrule -n monitoring kube-prometheus-alertmanager
kubectl delete prometheusrule -n monitoring kube-prometheus-exporter-kube-controller-manager
kubectl delete prometheusrule -n monitoring kube-prometheus-exporter-kube-etcd
kubectl delete prometheusrule -n monitoring kube-prometheus-exporter-kube-scheduler
kubectl delete prometheusrule -n monitoring kube-prometheus-exporter-kube-state
kubectl delete prometheusrule -n monitoring kube-prometheus-exporter-kubelets
kubectl delete prometheusrule -n monitoring kube-prometheus-exporter-kubernetes
kubectl delete prometheusrule -n monitoring kube-prometheus-exporter-node
kubectl delete prometheusrule -n monitoring kube-prometheus-rules
# Installing Kubernetes on AWS using Ansible (Kops with Bash Script)

## What is Kubernetes?
Kubernetes is an open-source system for automating deployment, scaling, and management of containerized applications. Kubernetes provides a container-centric management environment. It orchestrates computing, networking, and storage infrastructure on behalf of user workloads.

## What is Kops?
kops: **K**ubernetes **Op**eration**s**

`kops` helps you create, destroy, upgrade and maintain production-grade, highly available, Kubernetes clusters from the command line. AWS (Amazon Web Services) is currently officially supported, with GCE in beta support , and VMware vSphere in alpha, and other platforms planned.

## What is Ansible
Ansible is an open source automation platform. Ansible is "agentless", using SSH to push changes from a single source to multiple remote resources. Commands can be invoked either ad hoc on the command line or via "playbooks" written in YAML (YAML Ain't Markup Language), a Unicode-based, human-readable, and computationally powerful data serialization language.

## What is bash programming?
Bash programming is one of the scripting languages. You can automate and program (conditions and loops) as many commands that you want to run in a bash shell. It is basically used when one has to run multiple bash commands for a particular task.

## Prerequests

- aws account with this **permissions**: AmazonEC2FullAccess, AmazonRoute53FullAccess, AmazonS3FullAccess, IAMFullAccess, AmazonVPCFullAccess http://aws.amazon.com/

- aws-cli with user keys created above: https://docs.aws.amazon.com/cli/latest/userguide/installing.html

- kops: https://github.com/kubernetes/kops/blob/master/docs/install.md

- helm: https://docs.helm.sh/using_helm/#installing-helm

- ansible: http://docs.ansible.com/ansible/latest/intro_installation.html


### Create Kubernetes Cluster

Create the Kubernetes cluster using `Kops`:
```
ansible-playbook create-cluster.yaml
```

This playbook will install;
- Create S3 bucket for cluster state store (It's contains everything about cluster. Really everythings. Keep it secure)
- Kubernetes cluster (1 master node and 1 worker node)
- Prometheus
- Grafana
- Alertmanager (with configs)

## Delete Kubernetes Cluster

Delete the Kubernetes cluster and bucket using `Kops`: 
```
ansible-playbook delete-cluster.yaml
```
Notes: Be patience because this process takes approximately 10 minutes..

This playbook will delete;
- Kubernetes cluster
- S3 bucket with versions

# Check Installations

## Cluster Healty
```
kubectl get cs
```
## Prometheus Pods
```
kubectl get pods -n monitoring
```
## Prometheus Alert
You can see current alert rules.
```
kubectl port-forward -n monitoring prometheus-kube-prometheus-0 9090
```
```
http://localhost:9090/alerts
```
## Alertmanager Config
You can see current alarms and alertmanager configuration
```
kubectl port-forward -n monitoring alertmanager-kube-prometheus-0 9093
```
- http://localhost:9093/#/alerts

- http://localhost:9093/#/status
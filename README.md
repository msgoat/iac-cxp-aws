# iac-at41tools-aws

Creates all AWS resources to host the AT41 toolchain on AWS.

@TODO: create VPC, ALB, Route DNS Entry and Certificate with Terraform before setting up EKS with eksctl

## HOW-TO Setup an AT.41 Tools Runtime Environment

### (Optional) Create VPC for AWS EKS Cluster

### Create an AWS EKS Cluster with eksctl

### Create default namespaces

### Install Ingress Tool Stack

### Create Security Group for AWS ALB Loadbalancer

### Create AWS ALB Loadbalancer

### Create DNS Name for AWS ALB Loadbalancer

### Create SSL Certificate for AWS ALB Loadbalancer

### Install Ingress Tool Stack

1\. Move to folder __charts/sys-monitoring__.

2\. Update chart dependendencies by running __helm dependency update__:

```
helm dependency update .
```

3\. Install all custom resource definitions with __kubectl__ by running __create_crds.cmd__.

4\. Install chart by running __helm install__:

```
helm install sys-ingress . --namespace sys-ingress --skip-crds --debug --atomic
```

### Install IAM Tool Stack

@see [sys-iam-bootstrap](helm/sys-iam-bootstrap/README.md)

@see [sys-iam](helm/sys-iam/README.md)

### Install Monitoring Tool Stack

@see [sys-monitoring-bootstrap](helm/sys-monitoring-bootstrap/README.md)

@see [sys-monitoring](helm/sys-monitoring/README.md)

### Install Logging Tool Stack

1\. Move to folder __charts/sys-logging__.

2\. Update chart dependendencies by running __helm dependency update__:

```
helm dependency update .
```

3\. Install chart by running __helm install__:

```
helm install sys-logging . --namespace sys-logging  --debug --atomic
```

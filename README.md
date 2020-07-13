# iac-cxp-aws

Creates all AWS resources to host CXP Kubernetes cluster on AWS.

### Bootstrap AWS EKS infrastructure using Terraform

1\. Move to folder __terraform__

2\. Run `terraform plan` 

3\. Run `terraform apply` 

### Create AWS EKS cluster using eksctl

1\. Move to folder __eksctl__

2\. Replace all VPC IDs and subnet IDs in __eks-eu-west1-cxp.yaml__ with identifiers returned by Terraform.

3\. Run `create_cluster.cmd`

### Install Ingress Tool Stack

1\. Move to folder __charts/sys-ingress__.

2\. Update chart dependendencies by running __helm dependency update__:

```
helm dependency update .
```

3\. Install chart by running __helm install__:

```
helm install sys-ingress . --namespace sys-ingress --debug --atomic
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

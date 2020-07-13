# sys-iam-bootstrap

Creates some bootstrapping Kubernetes resources which simplify the deployment
of tool stack sys-iam.

## HOW-TO install this chart

Add your confidential values to a Helm values file named secret-values.yaml.

Run `helm install` from the Helm charts root folder:

```shell
helm install sys-iam-bootstrap sys-iam-bootstrap --namespace sys-iam --create-namespace --values secret-values.yaml --debug
``` 
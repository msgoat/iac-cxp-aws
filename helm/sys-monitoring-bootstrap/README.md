# sys-monitoring-bootstrap

Creates some bootstrapping Kubernetes resources which simplify the deployment
of tool stack sys-monitoring.

## HOW-TO install this chart

Add your confidential values to a Helm values file named secret-values.yaml.

Run `helm install` from the Helm charts root folder:

```shell
helm install sys-monitoring-bootstrap sys-monitoring-bootstrap --namespace sys-monitoring --create-namespace --values secret-values.yaml --debug
``` 
# sys-monitoring

Represents a monitoring system tool stack based on Prometheus and Grafana.

## Prerequisites

* Expects Helm chart [sys-monitoring-bootstrap](../sys-monitoring-bootstrap/README.md) to be installed first.
* Expects target namespace __sys-monitoring__ to exist

## HOW-TO install this chart

Run `helm install` from the Helm charts root folder:

```shell
helm install sys-monitoring sys-monitoring --namespace sys-monitoring --debug --atomic
``` 

## HOW-TO upgrade this chart

Apply modifications to Chart templates or values first.

Then, run `helm upgrade` from the Helm charts root folder:

```shell
helm upgrade sys-monitoring sys-monitoring --namespace sys-monitoring --debug --atomic
``` 

## HOW-TO delete this chart

Run `helm delete` from the Helm charts root folder:

```shell
helm delete sys-monitoring --namespace sys-monitoring
``` 

Remove all remaining persistent volume claims running:

```shell
kubectl -n sys-monitoring delete pvc --all
```
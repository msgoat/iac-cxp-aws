# sys-iam

Represents an Identity and Accessmanagement system tool stack based on KeyCloak using PostgreSQL as its datastore.

## Prerequisites

* Expects Helm chart [sys-iam-bootstrap](../sys-iam-bootstrap/README.md) to be installed first.
* Expects target namespace __sys-iam__ to exist

## HOW-TO install this chart

Run `helm install` from the Helm charts root folder:

```shell
helm install sys-iam sys-iam --namespace sys-iam --debug --atomic
``` 

## HOW-TO upgrade this chart

Apply modifications to Chart templates or values first.

Then, run `helm upgrade` from the Helm charts root folder:

```shell
helm upgrade sys-iam sys-iam --namespace sys-iam --debug --atomic
``` 

## HOW-TO delete this chart

Run `helm delete` from the Helm charts root folder:

```shell
helm delete sys-iam --namespace sys-iam
``` 

Remove all remaining persistent volume claims running:

```shell
kubectl -n sys-iam delete pvc --all
```
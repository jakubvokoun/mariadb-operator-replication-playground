# MariaDB Operator replication playground

## Requirements

- GNU Make
- minikube
- kubectl
- kustomize

## Generate MariaDB Operator manifests

```sh
helm repo add mariadb-operator https://helm.mariadb.com/mariadb-operator
mkdir generated
helm template mariadb-operator-crds mariadb-operator/mariadb-operator-crds > generated/01-mariadb-operator-crds.yml
helm template mariadb-operator mariadb-operator/mariadb-operator > generated/02-mariadb-operator.yml
```

## Demo

```sh
minikube start
make install-operator
make install-demo
make check-demo
make check-demo-databases
```

## Basic replication demo

```sh
make add-testing-table
make check-replication
````
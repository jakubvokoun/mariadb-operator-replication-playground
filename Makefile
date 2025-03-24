.PHONY: install-operator
install-operator:
	kubectl apply -f generated

.PHONY: install-demo
install-demo:
	kustomize build demo | kubectl apply -f -

PHONY: check-demo
check-demo:
	kubectl get mariadbs
	kubectl get svc
	kubectl exec -it demo-mariadb-0 -- mariadb -uroot -pverysecret -hdemo-mariadb-primary -e 'show replica hosts;'

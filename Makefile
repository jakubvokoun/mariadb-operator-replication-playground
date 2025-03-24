.PHONY: install-operator
install-operator:
	kubectl apply -f generated

.PHONY: install-demo
install-demo:
	kustomize build demo | kubectl apply -f -

.PHONY: check-demo
check-demo:
	kubectl get mariadbs
	kubectl get svc
	kubectl exec -it demo-mariadb-0 -- mariadb -uroot -pverysecret -hdemo-mariadb-primary -e 'show replica hosts;'

.PHONY: check-demo-databases
check-demo-databases:
	kubectl exec -it demo-mariadb-0 -- mariadb -udemo -psecret demo -e 'show databases;'
	kubectl exec -it demo-mariadb-1 -- mariadb -udemo -psecret demo -e 'show databases;'
	kubectl exec -it demo-mariadb-2 -- mariadb -udemo -psecret demo -e 'show databases;'

.PHONY: add-testing-table
add-testing-table:
	kubectl exec -it demo-mariadb-0 -- mariadb -udemo -psecret demo -e 'use demo; show tables;'
	kubectl exec -it demo-mariadb-0 -- mariadb -udemo -psecret demo -e 'use demo; create table demo_table (id int);'
	kubectl exec -it demo-mariadb-0 -- mariadb -udemo -psecret demo -e 'use demo; show tables;'

.PHONY: check-replication
check-replication:
	kubectl exec -it demo-mariadb-1 -- mariadb -udemo -psecret demo -e 'use demo; show tables;'
	kubectl exec -it demo-mariadb-2 -- mariadb -udemo -psecret demo -e 'use demo; show tables;'
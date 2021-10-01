kubectl delete sts posatgresql-db
kubectl delete pvc postgresql-db-disk-postgresql-db-0
kubectl delete pv postgres-pv-local
kubectl delete svc postgres-db-lb
rm -rf /mnt/postgres-data


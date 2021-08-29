===========================
POSTGRES POD
===========================

------------------------
REFERENCES - POSTGRES
------------------------
Postgres statefulset: https://www.bmc.com/blogs/kubernetes-postgresql/
Postgres docker image, using and setting password: https://hub.docker.com/_/postgres?tab=description&page=1&ordering=last_updated

--------------------------------
REFERENCES - PERSISTENT VOLUMES
--------------------------------
Persistent Volumes:
example with manual local fs/directory - https://kubernetes.io/docs/tasks/configure-pod-container/configure-persistent-volume-storage/
example with volumeClaimTemplate - https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/

concept - https://kubernetes.io/docs/concepts/storage/persistent-volumes/
concept - https://kubernetes.io/docs/concepts/storage/storage-classes/
default storageclass - https://kubernetes.io/docs/tasks/administer-cluster/change-default-storage-class/
design - https://github.com/kubernetes/community/blob/master/contributors/design-proposals/storage/persistent-storage.md

Volume Claim Template - for statefulsets (seems different from persistent volume):
- https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/
- postgres with pvc - https://www.bmc.com/blogs/kubernetes-postgresql/

==============================================
PULL IMAGE
==============================================
docker pull postgres:alpine3.14

==============================================
RUNNING THE IMAGE JUST AS A DOCKER CONTAINER
==============================================
https://hub.docker.com/_/postgres?tab=description&page=1&ordering=last_updated

docker run --name some-postgres -e POSTGRES_PASSWORD=mysecretpassword -d postgres
docker run -it --rm --network some-network postgres psql -h some-postgres -U postgres
docker run -d \
    --name some-postgres \
    -e POSTGRES_PASSWORD=mysecretpassword \
    -e PGDATA=/var/lib/postgresql/data/pgdata \
    -v /custom/mount:/var/lib/postgresql/data \
    postgres

docker run --name some-postgres -e POSTGRES_PASSWORD_FILE=/run/secrets/postgres-passwd -d postgres

==============================================
PERSISTENT VOLUME FOR POSTGRES
==============================================
Use HostPath - ONLY FOR SINGLE-NODE TESTING - will not work for multi-node - as this will be non-shared local volume
- https://kubernetes.io/docs/concepts/storage/persistent-volumes/
- https://kubernetes.io/docs/tasks/configure-pod-container/configure-persistent-volume-storage/#create-a-persistentvolume

Reference: https://kubernetes.io/docs/tasks/configure-pod-container/configure-persistent-volume-storage/#create-a-persistentvolume
The configuration file specifies that the volume is at /mnt/data on the cluster's Node. 
The configuration also specifies a size of 10 gibibytes and an access mode of ReadWriteOnce, 
which means the volume can be mounted as read-write by a single Node. 
It defines the StorageClass name manual for the PersistentVolume, 
which will be used to bind PersistentVolumeClaim requests to this PersistentVolume.

Modify this according to your needs:

apiVersion: v1
kind: PersistentVolume
metadata:
  name: task-pv-volume
  labels:
    type: local
spec:
  storageClassName: manual
  capacity:
    storage: 10Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/mnt/data"

==============================================
POSTGRES STATEFULSET
==============================================
postgres-sts.yaml

Set password and data mount point within the pod in the sts definition:
          env:
            - name: POSTGRES_PASSWORD
              value: testpassword
            - name: PGDATA
              value: /data/pgdata

=====================================
LOADBALANCER SERVICE
=====================================
postgres-service.yaml

=====================================
CREATE RESOURCES
=====================================

kubectl apply -f postgres-pv-local.yaml
kubectl apply -f postgres-sts.yaml
kubectl apply -f postgres-service.yaml

----------------------------------------
VERIFY
----------------------------------------
# kubectl get pvc
NAME                                 STATUS   VOLUME                 CAPACITY   ACCESS MODES   STORAGECLASS    AGE
postgresql-db-disk-postgresql-db-0   Bound    postgres-pv-hostpath   1Gi        RWO            local-storage   45m

# kubectl get pv
NAME                   CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS        CLAIM                                        STORAGECLASS             REASON   AGE
postgres-pv-local      1Gi        RWO            Retain           Available                                                  postgres-local-storage            10m

# kubectl get sts
NAME            READY   AGE
postgresql-db   1/1     9m

# kubectl get sts -o wide
NAME            READY   AGE    CONTAINERS      IMAGES
postgresql-db   1/1     9m5s   postgresql-db   postgres:latest

# kubectl get pods -o wide
NAME                    READY   STATUS    RESTARTS   AGE     IP           NODE   NOMINATED NODE   READINESS GATES
postgresql-db-0         1/1     Running   0          9m17s   172.17.0.9   ksn3   <none>           <none>

# kubectl get svc -o wide
NAME               TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE     SELECTOR
postgres-db-lb     LoadBalancer   10.102.116.32   <pending>     5432:31654/TCP   8m26s   app=postgresql-db

# kubectl get storageclass
No resources found

----------------------------------------
POSTGRES DISKS
----------------------------------------
- ON THE HOST

=====================================
ACCESS THE DATABASE
=====================================
With the above deployment, we will use the external IP of the postgres-db-lb service (from kubectl get svc) 
with port 5432. Since we only defined a password in our environment variables for the PostgreSQL StatefulSet, 
the configuration will have the default username “postgres” with the password we defined.

----------------------------------------
FROM OUTSIDE OF THE KUBERNETES CLUSTER
----------------------------------------
Use host's IP/hostname and the nodeport port of the service

$ psql -U postgres -h 192.168.99.103 -p 31654
Password for user postgres: 
psql (13.2, server 13.4 (Debian 13.4-1.pgdg100+1))
Type "help" for help.

postgres=# \conninfo
You are connected to database "postgres" as user "postgres" on host "192.168.99.103" at port "31654".

-------------------------------------
FROM WITHIN THE POD
-------------------------------------
# kubectl exec -ti postgresql-db-0 /bin/sh

Now, inside the pod:
# psql
psql: error: FATAL:  role "root" does not exist

# psql -U postgres
psql (13.4 (Debian 13.4-1.pgdg100+1))

postgres=# \conninfo
You are connected to database "postgres" as user "postgres" via socket in "/var/run/postgresql" at port "5432".

postgres=# select 1;
 ?column? 
----------
        1
(1 row)

postgres=# \d
Did not find any relations.

postgres=# \l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges   
-----------+----------+----------+------------+------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
(3 rows)


============================
TO CLEANUP
============================

# kubectl delete sts posatgresql-db

# kubectl delete pvc postgresql-db-disk-postgresql-db-0
persistentvolumeclaim "postgresql-db-disk-postgresql-db-0" deleted

# kubectl delete pv postgres-pv-local
persistentvolume "postgres-pv-local" deleted

# kubectl delete svc postgres-db-lb

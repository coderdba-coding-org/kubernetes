https://github.com/coderdba/NOTES/blob/master/kubernetes-kb/postgres/postgres-on-kubernetes.txt

My Git that uses this: git/coderdba-coding-org/kubernetes/postgres/postgres1
My Influx-Grafana setup: https://github.com/coderdba/NOTES/blob/master/influx-db-kb/influx-grafana-install-on-docker.txt

First create a folder or fileystem of nfs-mount /data1 to keep persistent data

Then run in this sequence:

- WITHOUT TELEGRAF SIDECAR
pv.yaml
pv-claim-1.yaml
postgres-secrets.yaml
postgres-sts.yaml
postgres-service.yaml

- WITH TELEGRAF SIDECAR
pv.yaml
pv-claim-1.yaml
postgres-secrets.yaml
telegraf-configmap.yaml
telegraf-secrets.sh
postgres-sts-with-telegraf-sidecar.yaml
postgres-service.yaml



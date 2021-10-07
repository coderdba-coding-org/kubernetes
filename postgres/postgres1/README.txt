https://github.com/coderdba/NOTES/blob/master/kubernetes-kb/postgres/postgres-on-kubernetes.txt

First create a folder or fileystem of nfs-mount /data1 to keep persistent data

Then run in this sequence:
pv.yaml
pv-claim-1.yaml
postgres-secrets.yaml
postgres-sts.yaml


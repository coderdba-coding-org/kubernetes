Run Sequence:
etcd-data-volume-create.sh
etcd-data-volume-verify.sh
etcd-verify.sh

Then modify the etcd.service of 'docker' type in osfiles/etc/systemd/system 
and copy it as /etc/systemd/system/etcd.service
Then start etcd service

Utilities:
etcd-user-list.sh

Dont run these:
DONT RUN: dont-run-etcd-start-manually-docker-run.sh
DONT RUN: dont-run-etcd-start-manually-docker-run.sh.orig

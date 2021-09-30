- CREATE VOLUME
etcd-data-volume-create.sh
etcd-data-volume-verify.sh

- MODIFY CONFIG FILES
Modify the etcd.service of 'docker' type in osfiles/etc/systemd/system 
Modify the "environment" file in osfiles/etc

- COPY CONFIG FILES AND START ETCD
NOTE: Utility for these steps - etcd-start-first-time.sh

Copy it as /etc/systemd/system/etcd.service
Copy it as /etc/environment
Start etcd service

- VERIFY
etcd-verify.sh

- Utilities:
etcd-user-list.sh

==================================================================
- Dont run these:
DONT RUN: dont-run-etcd-start-manually-docker-run.sh
DONT RUN: dont-run-etcd-start-manually-docker-run.sh.orig
==================================================================

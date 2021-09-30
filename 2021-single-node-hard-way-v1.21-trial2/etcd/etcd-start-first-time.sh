/bin/cp -p osfiles/etc/environment /etc/environment
/bin/cp -p osfiles/etc/systemd/system/etcd.service.docker /etc/systemd/system/etcd.service

systemctl enable etcd
systemctl start etcd
systemctl status etcd

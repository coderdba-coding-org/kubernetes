docker exec etcd /bin/sh -c "export ETCDCTL_API=3 && etcdctl user list --cacert=/etc/kubernetes/pki/ca.pem --cert=/etc/kubernetes/pki/kubernetes.pem --key=/etc/kubernetes/pki/kubernetes-key.pem "


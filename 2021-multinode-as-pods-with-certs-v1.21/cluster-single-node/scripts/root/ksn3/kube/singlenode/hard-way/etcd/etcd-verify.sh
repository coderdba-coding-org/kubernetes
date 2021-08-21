docker ps -a  | grep etcd

etcdctl --endpoints=http://${NODE1}:2379 member list

docker exec etcd /bin/sh -c "export ETCDCTL_API=3 && etcdctl member list --cacert=/etc/kubernetes/pki/ca.pem --cert=/etc/kubernetes/pki/kubernetes.pem --key=/etc/kubernetes/pki/kubernetes-key.pem -w table"


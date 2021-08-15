# NOTE:
ETCD ones are from: https://github.com/etcd-io/etcd/blob/main/hack/tls-setup/config/req-csr.json

After creating certs, move all .pem and .csr files to certs folder here - to avoid clutter

=======================
RUN SEQUENCE
=======================
ca-gen.sh
admin-gen.sh
etcd-gen.sh
kube-apiserver-gen.sh
kube-proxy-gen.sh
kubelet-gen.sh
kubeconfig-kubelet-gen.sh

=======================
Manually created files
=======================
ca-config.json
ca-csr.json
ca-gen.sh

admin-csr.json
admin-gen.sh

kubelet-node1-csr.json
kubelet-node2-csr.json
kubelet-node3-csr.json
kubelet-ksn1-csr.json (for single node)
kubelet-gen.sh

kube-proxy-csr.json
kube-proxy-gen.sh

kube-apiserver-csr.json
kube-apiserver-gen.sh

etcd-singlenode-csr.json
etcd-multinode-csr.json
etcd-gen.sh

kubeconfig-kubelet-gen.sh



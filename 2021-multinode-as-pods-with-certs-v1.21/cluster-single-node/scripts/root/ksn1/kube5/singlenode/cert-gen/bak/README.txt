# NOTE:
ETCD ones are from: https://github.com/etcd-io/etcd/blob/main/hack/tls-setup/config/req-csr.json

After creating certs, move all .pem and .csr files to certs folder here - to avoid clutter

NOTE:
embed-certs=true will embed certs in the kubeconfig file itself in base64 format
if embed-certs is omitted then path to cert and key pem files will be placed in kubeconfig 
- you must verify and ensure that it is the right path like /etc/kubernetes/pki and not the local work directory

NOTE:
CN and O are important
Others can be arbitrary like ABC

OU: In all csr.json OU has been set oas ABC. 
- Only in CA and etcd csr.json files OU has been different 
- It mostly need not be different and can be arbitrary in etcd and ca csr.json also

=======================
RUN SEQUENCE
=======================
ca-gen.sh
admin-gen.sh
etcd-gen.sh
kube-apiserver-gen.sh
kube-proxy-gen.sh
kube-controller-manager-gen.sh
kube-scheduler-gen.sh
kubelet-gen.sh

kubeconfig-kubelet-gen.sh
kubeconfig-kub-proxy-gen.sh
kubeconfig-kub-controller-manager-gen.sh
kubeconfig-admin.sh

Optional: kubeconfig-admin-noEmbedCerts.sh

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



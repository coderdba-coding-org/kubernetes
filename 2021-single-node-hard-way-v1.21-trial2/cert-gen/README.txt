https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/04-certificate-authority.md

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
STEPS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTE: Use utility scripts available for this

--------------------------
STEPS (see scripts below)
--------------------------
Modify json files - for correct hostnames
Modify shell files - for correct hostname, for correct IP address - use host-change-in-scripts.sh

Create pem files
Create kubeconfig files
Copy all .pem files to /etc/kubernetes/pki
Copy all .kubeconfig files to /etc/kubernetes/kubeconfig

--------------------------------
SCRIPTS - RUN IN THIS SEQUENCE
--------------------------------
host-change-in-scripts.sh - to change hostname and ip addresses in scripts 
runall.sh - run all scripts to generate certs, kubeconfig
copy-to-destination.sh

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Utilities
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
host-change-in-scripts.sh - to change hostname and ip addresses in scripts 
runall.sh - run all scripts to generate certs, kubeconfig
copy-to-destination.sh

check-cert.sh - check contents of certificate in text form
encode-base64.sh - encode key and cert files with base64 and concatenate output to a single string

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
kubernetes.pem peculiarity
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
kubernetes.pem and kubernetes-key.pem will be used for:
- etcd, etcd-peer and kube-apiserver
- and embedded as etcd tls files in calico also

NOTE: Instead, you can create different cert and key - using the same CA - 
      for kubernetes, etcd, etcd-peer and calico to talk to etcd

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
RUN SEQUENCE
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cert-ca-gen.sh
cert-admin-gen.sh
cert-kube-apiserver-gen.sh
cert-kube-controller-manager-gen.sh
cert-kubelet-gen.sh
cert-kube-proxy-gen.sh
cert-kubernetes-gen.sh
cert-kubernetes.sh
cert-kube-scheduler-gen.sh
cert-service-account-gen.sh

kubeconfig-admin-gen.sh
kubeconfig-kube-controller-manager-gen.sh
kubeconfig-kubelet-gen.sh
kubeconfig-kube-proxy-gen.sh
kubeconfig-kube-scheduler-gen.sh

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

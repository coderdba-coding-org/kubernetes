https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/04-certificate-authority.md

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
DESTINATION FOLDERS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Copy all .pem files to /etc/kubernetes/pki
Copy all .kubeconfig files to /etc/kubernetes/kubeconfig

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

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Utilities
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
runall.sh - run all scripts to generate certs, kubeconfig
check-cert.sh - check contents of certificate in text form
encode-base64.sh - encode key and cert files with base64 and concatenate output to a single string
host-change-in-scripts.sh - to change hostname and ip addresses in scripts 

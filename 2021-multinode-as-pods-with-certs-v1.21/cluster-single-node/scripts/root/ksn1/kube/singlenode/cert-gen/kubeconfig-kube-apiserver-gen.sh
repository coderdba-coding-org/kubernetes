# Single Node
# https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/05-kubernetes-configuration-files.md

# Set this
export KUBERNETES_PUBLIC_ADDRESS=192.168.99.101

# Multinode - use this line
#for instance in worker-0 worker-1 worker-2; do
# Single node - use this line
#for instance in worker-0
for instance in ksn1
do

kubectl config set-cluster kubernetes \
--certificate-authority=certs/ca.pem \
--embed-certs=true \
--server=https://${KUBERNETES_PUBLIC_ADDRESS}:6443 \
--kubeconfig=kubeconfig/kube-apiserver.kubeconfig

kubectl config set-credentials kubernetes \
--client-certificate=certs/kube-apiserver.pem \
--client-key=certs/kube-apiserver-key.pem \
--embed-certs=true \
--kubeconfig=kubeconfig/kube-apiserver.kubeconfig

kubectl config set-context default \
--cluster=kubernetes \
--user=kubernetes \
--kubeconfig=kubeconfig/kube-apiserver.kubeconfig

kubectl config use-context default --kubeconfig=kubeconfig/kube-apiserver.kubeconfig

done

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
--kubeconfig=kubeconfig/kubelet-${instance}.kubeconfig

kubectl config set-credentials system:node:${instance} \
--client-certificate=certs/kubelet-${instance}.pem \
--client-key=certs/kubelet-${instance}-key.pem \
--embed-certs=true \
--kubeconfig=kubeconfig/kubelet-${instance}.kubeconfig

kubectl config set-context default \
--cluster=kubernetes \
--user=system:node:${instance} \
--kubeconfig=kubeconfig/kubelet-${instance}.kubeconfig

kubectl config use-context default --kubeconfig=kubeconfig/kubelet-${instance}.kubeconfig

done

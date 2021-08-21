export KUBERNETES_PUBLIC_ADDRESS=192.168.99.103

#for instance in worker-0 worker-1 worker-2; do
for instance in ksn3; do
  kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=ca.pem \
    --embed-certs=true \
    --server=https://${KUBERNETES_PUBLIC_ADDRESS}:6443 \
    --kubeconfig=kubelet-${instance}.kubeconfig

  kubectl config set-credentials system:node:${instance} \
    --client-certificate=kubelet-${instance}.pem \
    --client-key=kubelet-${instance}-key.pem \
    --embed-certs=true \
    --kubeconfig=kubelet-${instance}.kubeconfig

  kubectl config set-context default \
    --cluster=kubernetes-the-hard-way \
    --user=system:node:${instance} \
    --kubeconfig=kubelet-${instance}.kubeconfig

  kubectl config use-context default --kubeconfig=kubelet-${instance}.kubeconfig
done

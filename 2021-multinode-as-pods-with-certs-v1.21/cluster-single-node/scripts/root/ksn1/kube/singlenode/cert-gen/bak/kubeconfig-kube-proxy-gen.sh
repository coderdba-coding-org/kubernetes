# Kube-proxy kubeconfig file generation
# https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/05-kubernetes-configuration-files.md

# Set this
export KUBERNETES_PUBLIC_ADDRESS=192.168.99.101

{
  kubectl config set-cluster kubernetes \
    --certificate-authority=certs/ca.pem \
    --embed-certs=true \
    --server=https://${KUBERNETES_PUBLIC_ADDRESS}:6443 \
    --kubeconfig=kubeconfig/kube-proxy.kubeconfig

  kubectl config set-credentials system:kube-proxy \
    --client-certificate=certs/kube-proxy.pem \
    --client-key=certs/kube-proxy-key.pem \
    --embed-certs=true \
    --kubeconfig=kubeconfig/kube-proxy.kubeconfig

  kubectl config set-context default \
    --cluster=kubernetes \
    --user=system:kube-proxy \
    --kubeconfig=kubeconfig/kube-proxy.kubeconfig

  kubectl config use-context default --kubeconfig=kubeconfig/kube-proxy.kubeconfig
}

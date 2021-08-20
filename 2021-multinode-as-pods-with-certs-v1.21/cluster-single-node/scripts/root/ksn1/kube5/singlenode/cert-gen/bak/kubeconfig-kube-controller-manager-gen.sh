# Kube-controller-manager kubeconfig file generation
# https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/05-kubernetes-configuration-files.md

{
  kubectl config set-cluster kubernetes \
    --certificate-authority=certs/ca.pem \
    --embed-certs=true \
    --server=https://127.0.0.1:6443 \
    --kubeconfig=kubeconfig/kube-controller-manager.kubeconfig

  kubectl config set-credentials system:kube-controller-manager \
    --client-certificate=certs/kube-controller-manager.pem \
    --client-key=certs/kube-controller-manager-key.pem \
    --embed-certs=true \
    --kubeconfig=kubeconfig/kube-controller-manager.kubeconfig

  kubectl config set-context default \
    --cluster=kubernetes \
    --user=system:kube-controller-manager \
    --kubeconfig=kubeconfig/kube-controller-manager.kubeconfig

  kubectl config use-context default --kubeconfig=kubeconfig/kube-controller-manager.kubeconfig
}

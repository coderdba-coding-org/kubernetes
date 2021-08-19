# admin user kubeconfig file generation
# https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/05-kubernetes-configuration-files.md


{
  kubectl config set-cluster kubernetes \
    --certificate-authority=certs/ca.pem \
    --embed-certs=true \
    --server=https://127.0.0.1:6443 \
    --kubeconfig=kubeconfig/admin.kubeconfig

  kubectl config set-credentials admin \
    --client-certificate=certs/admin.pem \
    --client-key=certs/admin-key.pem \
    --embed-certs=true \
    --kubeconfig=kubeconfig/admin.kubeconfig

  kubectl config set-context default \
    --cluster=kubernetes \
    --user=admin \
    --kubeconfig=kubeconfig/admin.kubeconfig

  kubectl config use-context default --kubeconfig=kubeconfig/admin.kubeconfig
}

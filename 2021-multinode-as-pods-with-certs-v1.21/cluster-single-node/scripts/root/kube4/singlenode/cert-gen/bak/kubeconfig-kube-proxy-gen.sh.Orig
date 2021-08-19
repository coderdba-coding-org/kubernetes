 kubectl config set-cluster kubernetes \
--certificate-authority=certs/ca.pem \
--embed-certs=true \
--server=https://ksn1:6443 \
--kubeconfig=kubeconfig/kube-proxy.kubeconfig

kubectl config set-credentials kube-proxy \
--client-certificate=certs/kube-proxy.pem \
--client-key=certs/kube-proxy-key.pem \
--embed-certs=true \
--kubeconfig=kubeconfig/kube-proxy.kubeconfig

kubectl config set-context default \
--cluster=kubernetes \
--user=kube-proxy \
--kubeconfig=kube-proxy.kubeconfig

kubectl config use-context default --kubeconfig=kube-proxy.kubeconfig

# CREATE A KUBECONFIG FILE FOR 'admin' USER


kubectl config set-cluster kubernetes \
--certificate-authority=certs/ca.pem \
--server=https://ksn1:6443 \
--embed-certs=true \
--kubeconfig=kubeconfig/admin.kubeconfig

kubectl config set-credentials admin \
--client-certificate=certs/admin.pem \
--client-key=certs/admin-key.pem \
--embed-certs=true \
--kubeconfig=kubeconfig/admin.kubeconfig

kubectl config set-context kubernetes --cluster=kubernetes --user=admin --kubeconfig=kubeconfig/admin.kubeconfig

kubectl config use-context kubernetes --kubeconfig=kubeconfig/admin.kubeconfig

kubectl get nodes

# CREATE A KUBECONFIG FILE FOR 'admin' USER


kubectl config set-cluster kubernetes \
--certificate-authority=/etc/kubernetes/pki/ca.pem \
--server=https://ksn1:6443 \
--kubeconfig=kubeconfig/admin.kubeconfig.noEmbedCerts

kubectl config set-credentials admin \
--client-certificate=/etc/kubernetes/pki/admin.pem \
--client-key=/etc/kubernetes/pki/admin-key.pem \
--kubeconfig=kubeconfig/admin.kubeconfig.noEmbedCerts

kubectl config set-context kubernetes --cluster=kubernetes --user=admin --kubeconfig=kubeconfig/admin.kubeconfig.noEmbedCerts

kubectl config use-context kubernetes --kubeconfig=kubeconfig/admin.kubeconfig.noEmbedCerts

kubectl get nodes

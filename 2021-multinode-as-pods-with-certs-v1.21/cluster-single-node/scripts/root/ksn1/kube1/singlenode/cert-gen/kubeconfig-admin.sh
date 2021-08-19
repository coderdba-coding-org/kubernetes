# CREATE A kubeconfig FILE FOR ADMIN - for the node IP

# Add the cluster information for the node IP
kubectl config set-cluster kubernetes \
--certificate-authority=certs/ca.pem \
--embed-certs=true \
--server=https://192.168.99.101:6443 \
--kubeconfig=kubeconfig/192.168.99.101.admin.kubeconfig

# Add the credentials for the node IP

kubectl config set-credentials kubernetes-admin \
--client-certificate=certs/kubelet-ksn1.pem \
--client-key=certs/kubelet-ksn1-key.pem \
--embed-certs=true \
--kubeconfig=kubeconfig/192.168.99.101.admin.kubeconfig

# Add the context
#kubectl config set-context default \
#--cluster=kubernetes \
#--user=kubernetes-admin \
#--kubeconfig=kubeconfig/192.168.99.101.admin.kubeconfig

# Use the context for the node
#kubectl config use-context default --kubeconfig=kubeconfig/192.168.99.101.admin.kubeconfig

#=================
# CREATE A kubeconfig FILE FOR ADMIN - for the node hostname

# Add the cluster information for the node
kubectl config set-cluster kubernetes \
--certificate-authority=certs/ca.pem \
--embed-certs=true \
--server=https://ksn1:6443 \
--kubeconfig=kubeconfig/ksn1.admin.kubeconfig

# Add the credentials for the node

kubectl config set-credentials kubernetes-admin \
--client-certificate=certs/kubelet-ksn1.pem \
--client-key=certs/kubelet-ksn1-key.pem \
--embed-certs=true \
--kubeconfig=kubeconfig/ksn1.admin.kubeconfig

# Add the context
#kubectl config set-context default \
#--cluster=kubernetes \
#--user=kubernetes-admin \
#--kubeconfig=kubeconfig/ksn1.admin.kubeconfig

# Use the context for the node
#kubectl config use-context default --kubeconfig=kubeconfig/ksn1.admin.kubeconfig

#=================
# CREATE A kubeconfig FILE FOR ADMIN - for loopback IP

# Add the cluster information for loopback
kubectl config set-cluster kubernetes \
--certificate-authority=certs/ca.pem \
--embed-certs=true \
--server=https://127.0.0.1:6443 \
--kubeconfig=kubeconfig/127.0.0.1.admin.kubeconfig

# Add the credentials for loopback

kubectl config set-credentials kubernetes-admin \
--client-certificate=certs/kubelet-ksn1.pem \
--client-key=certs/kubelet-ksn1-key.pem \
--embed-certs=true \
--kubeconfig=kubeconfig/127.0.0.1.admin.kubeconfig

# Add the context
#kubectl config set-context default \
#--cluster=kubernetes \
#--user=kubernetes-admin \
#--kubeconfig=kubeconfig/127.0.0.1.admin.kubeconfig

# Use the context for the node
#kubectl config use-context default --kubeconfig=kubeconfig/127.0.0.1.admin.kubeconfig

# CREATE A kubeconfig FILE FOR KUBELET - for the node IP

# Add the cluster information for the node IP
kubectl config set-cluster kubernetes \
--certificate-authority=certs/ca.pem \
--embed-certs=true \
--server=https://192.168.99.101:6443 \
--kubeconfig=kubeconfig/kubelet-192.168.99.101.kubeconfig

# Add the credentials for the node IP

kubectl config set-credentials system:node:192.168.99.101 \
--client-certificate=certs/kubelet-ksn1.pem \
--client-key=certs/kubelet-ksn1-key.pem \
--embed-certs=true \
--kubeconfig=kubeconfig/kubelet-192.168.99.101.kubeconfig

# Add the context
kubectl config set-context default \
--cluster=kubernetes \
--user=system:node:192.168.99.101 \
--kubeconfig=kubeconfig/kubelet-192.168.99.101.kubeconfig

# Use the context for the node
kubectl config use-context default --kubeconfig=kubeconfig/kubelet-192.168.99.101.kubeconfig

#=================
# CREATE A kubeconfig FILE FOR KUBELET - for the node hostname

# Add the cluster information for the node
#kubectl config set-cluster kubernetes \
#--certificate-authority=certs/ca.pem \
#--embed-certs=true \
#--server=https://ksn1:6443 \
#--kubeconfig=kubeconfig/kubelet-ksn1.kubeconfig

# Add the credentials for the node

kubectl config set-credentials system:node:ksn1 \
--client-certificate=certs/kubelet-ksn1.pem \
--client-key=certs/kubelet-ksn1-key.pem \
--embed-certs=true \
--kubeconfig=kubeconfig/kubelet-ksn1.kubeconfig

# Add the context
kubectl config set-context default \
--cluster=kubernetes \
--user=system:node:ksn1 \
--kubeconfig=kubeconfig/kubelet-ksn1.kubeconfig

# Use the context for the node
kubectl config use-context default --kubeconfig=kubeconfig/kubelet-ksn1.kubeconfig

#=================
# CREATE A kubeconfig FILE FOR KUBELET - for loopback IP

# Add the cluster information for loopback
kubectl config set-cluster kubernetes \
--certificate-authority=certs/ca.pem \
--embed-certs=true \
--server=https://127.0.0.1:6443 \
--kubeconfig=kubeconfig/kubelet-127.0.0.1.kubeconfig

# Add the credentials for loopback

kubectl config set-credentials system:node:127.0.0.1 \
--client-certificate=certs/kubelet-ksn1.pem \
--client-key=certs/kubelet-ksn1-key.pem \
--embed-certs=true \
--kubeconfig=kubeconfig/kubelet-127.0.0.1.kubeconfig

# Add the context
kubectl config set-context default \
--cluster=kubernetes \
--user=system:node:127.0.0.1 \
--kubeconfig=kubeconfig/kubelet-127.0.0.1.kubeconfig

# Use the context for the node
kubectl config use-context default --kubeconfig=kubeconfig/kubelet-127.0.0.1.kubeconfig

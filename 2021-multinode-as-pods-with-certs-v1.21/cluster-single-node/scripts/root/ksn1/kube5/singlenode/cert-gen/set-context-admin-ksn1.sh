# Add the context for the node IP
#kubectl config set-context kube-system \
#--cluster=kubernetes \
#--user=kubernetes-admin \
#--kubeconfig=config

# Use the context for the node
#kubectl config use-context kube-system --kubeconfig=config

# test
#kubectl get pods --all-namespaces

# Add the context for the node IP
# Context: kubernetes-admin@kubernetes
kubectl config set-context kubernetes-admin@kubernetes \
--cluster=kubernetes \
--user=kubernetes-admin \
--kubeconfig=config

# Use the context for the node
kubectl config use-context kubernetes-admin@kubernetes --kubeconfig=config

# test
kubectl get pods --all-namespaces

# Add the context for the node IP
kubectl config set-context kube-system \
--cluster=kubernetes \
--user=system:node:ksn1 \
--kubeconfig=config

# Use the context for the node
kubectl config use-context kube-system --kubeconfig=config

# test
kubectl get pods --all-namespaces

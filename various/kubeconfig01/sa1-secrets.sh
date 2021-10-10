echo
echo "for all namespaces"
kubectl --kubeconfig=./sa1.kubeconfig  get secrets --all-namespaces

echo
echo "for default namespace"
kubectl --kubeconfig=./sa1.kubeconfig  get secrets -n default


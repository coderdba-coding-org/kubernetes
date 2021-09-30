kubectl apply -f calico-etcd.yaml --kubeconfig /etc/kubernetes/kubeconfig/admin.kubeconfig

sleep 2

echo
echo Pods
kubectl get pods --all-namespaces -o wide

echo
echo Daemonsets
kubectl get pods --all-namespaces -o wide

echo 
echo Services
kubectl get service --all-namespaces -o wide


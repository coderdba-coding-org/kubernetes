kubectl apply -f calico-etcd.yaml --kubeconfig /etc/kubernetes/kubeconfig/admin.kubeconfig

sleep 2

echo
echo Pods
kubectl get pods --all-namespaces -o wide --kubeconfig=/root/.kube/admin.kubeconfig

echo
echo Daemonsets
kubectl get daemonsets --all-namespaces -o wide --kubeconfig=/root/.kube/admin.kubeconfig

echo 
echo Services
kubectl get service --all-namespaces -o wide --kubeconfig=/root/.kube/admin.kubeconfig


# NOTE: You MUST use the admin.kubeconfig file to create pod, rbac etc

echo creatig rbac
kubectl apply -f kube-proxy-rbac.yaml --kubeconfig /etc/kubernetes/kubeconfig/admin.kubeconfig

echo
echo creating daemonset
kubectl apply -f kube-proxy-ds.yaml --kubeconfig /etc/kubernetes/kubeconfig/admin.kubeconfig

sleep 2
echo
echo Pods
kubectl get pods --all-namespaces -o wide --kubeconfig=/root/.kube/admin.kubeconfig

echo
echo Daemonsets
kubectl get daemonsets --all-namespaces -o wide --kubeconfig=/root/.kube/admin.kubeconfig

echo

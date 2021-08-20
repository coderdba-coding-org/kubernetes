# NOTE: You MUST use the admin.kubeconfig file to create pod, rbac etc

echo running kubectl apply

# Dont run the remote file itself 
# - download and modify it to suite your cluster-ip-range requirements and then run local file
#kubectl apply -f https://storage.googleapis.com/kubernetes-the-hard-way/coredns-1.8.yaml --kubeconfig /etc/kubernetes/kubeconfig/admin.kubeconfig

kubectl apply -f ./coredns-1.8.yaml --kubeconfig /etc/kubernetes/kubeconfig/admin.kubeconfig

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

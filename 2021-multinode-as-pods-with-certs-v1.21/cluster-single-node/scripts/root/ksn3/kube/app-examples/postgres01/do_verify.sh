echo
echo PVC
kubectl get pvc
echo
echo PV
kubectl get pv
echo
echo STS
kubectl get sts -o wide  | grep postgres
echo
echo PODS
kubectl get pods -o wide  | grep postgres
echo
echo SVC
kubectl get svc -o wide  | grep postgres
echo
echo StorageClass
kubectl get storageclass
echo

kubectl scale sts postgres1 --replicas=0

sleep 10

kubectl delete sts postgres1
sleep 10

kubectl get pods --all-namespaces |grep postgres

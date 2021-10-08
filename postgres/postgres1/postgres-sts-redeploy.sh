kubectl scale sts postgres1 --replicas=0

sleep 10

kubectl delete sts postgres1
sleep 3

kubectl apply -f telegraf-configmap.yaml
kubectl apply -f postgres-sts-with-telegraf-sidecar.yaml

kubectl get sts --all-namespaces |grep postgres

sleep 10
kubectl get pods --all-namespaces |grep postgres

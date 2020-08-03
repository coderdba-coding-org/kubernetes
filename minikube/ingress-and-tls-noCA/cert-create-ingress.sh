manifest=example-ingress-tls.yaml

kubectl delete -f $manifest
kubectl apply -f $manifest

kubectl delete secret tls-secret
kubectl create secret tls tls-secret --key ingress-tls.key --cert ingress-tls.crt

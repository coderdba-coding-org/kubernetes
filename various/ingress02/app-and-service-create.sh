docker pull gcr.io/google-samples/hello-app:1.0
docker pull gcr.io/google-samples/hello-app:2.0

kubectl create deployment web --image=gcr.io/google-samples/hello-app:1.0
kubectl create deployment web2 --image=gcr.io/google-samples/hello-app:2.0

kubectl expose deployment web --type=NodePort --port=8080
kubectl expose deployment web2 --type=NodePort --port=8080

kubectl get service web
kubectl get service web2


Basic example Ingress: https://kubernetes.io/docs/tasks/access-application-cluster/ingress-minikube/  

The Hello-App: https://github.com/GoogleCloudPlatform/kubernetes-engine-samples/blob/master/hello-app/Dockerfile
(runs on pod-port 8080)

Ingress: https://kubernetes.io/docs/concepts/services-networking/ingress/
TLS Cert: https://kubernetes.github.io/ingress-nginx/user-guide/tls/  
Client Cert: https://kubernetes.github.io/ingress-nginx/examples/auth/client-certs/

Example with TLS: https://kubernetes.github.io/ingress-nginx/examples/tls-termination/
- https://kubernetes.github.io/ingress-nginx/examples/PREREQUISITES/#tls-certificates
- https://kubernetes.github.io/ingress-nginx/examples/PREREQUISITES/#test-http-service


### Start Minikube
```
minikube start
```

### Enable Ingress

```
minikube addons enable ingress

kubectl get pods -n kube-system

```

Following get created initially:  
```
ingress-nginx-admission-create-wp5n7        0/1       ContainerCreating   0          7s
ingress-nginx-admission-patch-92xcl         0/1       ContainerCreating   0          7s
ingress-nginx-controller-7bb4c67d67-cdt7n   0/1       ContainerCreating   0          7s
```

This will remain at the end:  
```
ingress-nginx-controller-7bb4c67d67-cdt7n 

```

### Create an App Pod

```
kubectl create deployment web --image=gcr.io/google-samples/hello-app:1.0
```

### Create service for the app

```
kubectl expose deployment web --type=NodePort --port=8080

kubectl get service web

minikube service web --url

http://172.17.0.15:31637

```

Verify and note the IPs:  
NOTE: For service "web" the Node-Port of host is 31807 while the pod's port is 8080  
```
$ kubectl get deployments -o wide
NAME   READY   UP-TO-DATE   AVAILABLE   AGE   CONTAINERS   IMAGES                                SELECTOR
web    1/1     1            1           88s   hello-app    gcr.io/google-samples/hello-app:1.0   app=web

$ kubectl get pods -o wide
NAME                  READY   STATUS    RESTARTS   AGE   IP           NODE       NOMINATED NODE   READINESS GATES
web-6785d44d5-7dzc4   1/1     Running   0          97s   172.17.0.6   minikube   <none>           <none>

$ kubectl get services  -o wide
NAME         TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)          AGE   SELECTOR
web          NodePort    10.99.231.40   <none>        8080:31807/TCP   84s   app=web --> this is the one
kubernetes   ClusterIP   10.96.0.1      <none>        443/TCP          18m   <none>

```

### Create an Ingress resource

example-ingress.yaml
NOTE: The keyword "servicePort" refers to the port of the pod and not of the service itself (which is the NodePort port in this case)  
NOTE: "host" is the hostname in our /etc/hosts pointing to the minikube VM's IP  

```
 apiVersion: networking.k8s.io/v1beta1
 kind: Ingress
 metadata:
   name: example-ingress
   annotations:
     nginx.ingress.kubernetes.io/rewrite-target: /$1
 spec:
   rules:
   - host: hello-world.info
     http:
       paths:
       - path: /
         backend:
           serviceName: web
           servicePort: 8080
```

NOTE: The ingress Port itself is 80   
```
kubectl apply -f example-ingress.yaml

kubectl get ingress
--> 
NAME              CLASS    HOSTS              ADDRESS   PORTS   AGE
example-ingress   <none>   hello-world.info             80      12s
```

NOTE: The ingress Port itself is 80   
NOTE: If you omit the line 'host' in the yml, the output will show the IP of Minikube VM:  
```
$ kubectl get ingress
NAME              CLASS    HOSTS   ADDRESS          PORTS   AGE
example-ingress   <none>   *       192.168.99.135   80      94s
```

### Add the following line to the bottom of the /etc/hosts file.

```
Note: If you are running Minikube locally, use "minikube ip" to get the external IP. The IP address displayed within the ingress list will be the internal IP.
172.17.0.15 hello-world.info
```

### Verify that the Ingress controller is directing traffic:

NOTE: Curl to IP defaults to http and port 80  
```
curl hello-world.info  
or 
curl 192.168.99.135
```

Output:  
```
Hello, world!
Version: 1.0.0
Hostname: web-6785d44d5-7dzc4
```

### Create Second Deployment

```
kubectl create deployment web2 --image=gcr.io/google-samples/hello-app:2.0

kubectl expose deployment web2 --port=8080 --type=NodePort
```

Verify:  
```
$ kubectl get svc  -o wide
NAME         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE   SELECTOR
web          NodePort    10.99.231.40    <none>        8080:31807/TCP   11m   app=web
web2         NodePort    10.100.208.74   <none>        8080:31000/TCP   11s   app=web2
kubernetes   ClusterIP   10.96.0.1       <none>        443/TCP          28m   <none>
```


### Edit the existing example-ingress.yaml and add the following lines:
```
      - path: /v2
        backend:
          serviceName: web2
          servicePort: 8080
```

```
kubectl apply -f example-ingress.yaml
```

### Test Your Ingress

```
curl hello-world.info
curl hello-world.info/v2
```
- OR -  

```
$ curl 192.168.99.135
Hello, world!
Version: 1.0.0
Hostname: web-6785d44d5-7dzc4

$ curl 192.168.99.135/v2
Hello, world!
Version: 2.0.0
Hostname: web2-8474c56fd-6gftf
```
## ----------------------------
## TLS - NO CA CERT
## ----------------------------

https://kubernetes.github.io/ingress-nginx/user-guide/tls/

#### TLS Secrets
Anytime we reference a TLS secret, we mean a PEM-encoded X.509, RSA (2048) secret.  

You can generate a self-signed certificate and private key with:  

```
KEY_FILE=./ingress.key
CERT_FILE=./ingress.crt
HOST=`minikube ip`
CERT_NAME="nginx-ingress-tls-secret"

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ${KEY_FILE} -out ${CERT_FILE} -subj "/CN=${HOST}/O=${HOST}"
```

Then create the secret in the cluster via:  
```
kubectl create secret tls ${CERT_NAME} --key ${KEY_FILE} --cert ${CERT_FILE}
```

The resulting secret will be of type kubernetes.io/tls  

### Create ingress with secret

Use this yaml with "tls" section added:  
```
apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
  name: example-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /$1
spec:
  rules:
  - http:
      paths:
      - path: /
        backend:
          serviceName: web
          servicePort: 8080
      - path: /v2
        backend:
          serviceName: web2
          servicePort: 8080
  tls:
  - secretName: nginx-ingress-tls-secret
```

Verify: Now, you can see 443 also in ports
```
kubectl apply -f example-ingress-tls.yaml

kybectl get ingress
-->
example-ingress   <none>   *       192.168.99.135   80, 443   3h8m

```

Using just curl gives cert error.  
Use curl -k.  

```
$ curl -k  https://192.168.99.135
Hello, world!
Version: 1.0.0
Hostname: web-6785d44d5-7dzc4

$ curl -k https://192.168.99.135/v2
Hello, world!
Version: 2.0.0
Hostname: web2-8474c56fd-6gftf
```

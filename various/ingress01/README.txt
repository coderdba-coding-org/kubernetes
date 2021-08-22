Kubernetes site
- https://kubernetes.io/docs/concepts/services-networking/ingress/
- https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/
- https://kubernetes.io/docs/tasks/access-application-cluster/ingress-minikube/

Official nginx site:
- https://kubernetes.github.io/ingress-nginx/
- Deployment: https://kubernetes.github.io/ingress-nginx/deploy/
- Troubleshooting: https://kubernetes.github.io/ingress-nginx/troubleshooting/

Tutorial - the nginx-ingress-controller: 
- https://www.fairwinds.com/blog/intro-to-kubernetes-ingress-set-up-nginx-ingress-in-kubernetes-bare-metal

Manually setting up ingress controller: (with LoadBalancer object)
- https://docs.oracle.com/en-us/iaas/Content/ContEng/Tasks/contengsettingupingresscontroller.htm

Maybe refer to this also: 
- https://github.com/coderdba/NOTES/blob/master/kubernetes-kb/ingress-controller-W-nginx.txt

==================================
INSTALL NGINX-INGRESS-CONTROLLER
==================================
- https://www.fairwinds.com/blog/intro-to-kubernetes-ingress-set-up-nginx-ingress-in-kubernetes-bare-metal
- https://kubernetes.github.io/ingress-nginx/deploy/

$ curl -O https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.49.0/deploy/static/provider/baremetal/deploy.yaml
$ kubectl apply -f ./deploy.yaml --kubeconfig ~/.kube/admin.kubeconfig.ksn3

$ kubectl describe service -n ingress-nginx ingress-nginx-controller --kubeconfig ~/.kube/admin.kubeconfig.ksn3

$ kubectl describe service -n ingress-nginx ingress-nginx-controller --kubeconfig ~/.kube/admin.kubeconfig.ksn3
Name:                     ingress-nginx-controller
Namespace:                ingress-nginx
Labels:                   app.kubernetes.io/component=controller
                          app.kubernetes.io/instance=ingress-nginx
                          app.kubernetes.io/managed-by=Helm
                          app.kubernetes.io/name=ingress-nginx
                          app.kubernetes.io/version=0.49.0
                          helm.sh/chart=ingress-nginx-3.36.0
Annotations:              <none>
Selector:                 app.kubernetes.io/component=controller,app.kubernetes.io/instance=ingress-nginx,app.kubernetes.io/name=ingress-nginx
Type:                     NodePort
IP Family Policy:         SingleStack
IP Families:              IPv4
IP:                       10.106.8.102
IPs:                      10.106.8.102
Port:                     http  80/TCP
TargetPort:               http/TCP
NodePort:                 http  31097/TCP
Endpoints:                172.17.0.3:80
Port:                     https  443/TCP
TargetPort:               https/TCP
NodePort:                 https  32202/TCP
Endpoints:                172.17.0.3:443
Session Affinity:         None
External Traffic Policy:  Cluster
Events:                   <none>

In this case, connect to localhost:32202 on your machine. You should receive a page which displays “404 Not Found" - 
this is the Ingress Controller default response. IF you are using cloud-hosted Kubernetes, use the above “kubectl describe” command, 
and connect to the host name of the load balancer instead.

=========================
INSTALL AN APP 
=========================
https://kubernetes.io/docs/tasks/access-application-cluster/ingress-minikube/

- Create the deployment of a hello-world app
kubectl create deployment web --image=gcr.io/google-samples/hello-app:1.0 --kubeconfig ~/.kube/admin.kubeconfig.ksn3

- Expose the deployment with a NodePort service
kubectl expose deployment web --type=NodePort --port=8080 --kubeconfig ~/.kube/admin.kubeconfig.ksn3
service/web exposed

kubectl get service web --kubeconfig ~/.kube/admin.kubeconfig.ksn3
NAME   TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
web    NodePort   10.98.154.232   <none>        8080:32263/TCP   4s

- Curl and check (to host ksn3's IP - 192.168.99.103 and nodeport of the service)
curl http://192.168.99.103:32263
Hello, world!
Version: 1.0.0

=========================
CREATE INGRESS 
=========================
Create example-ingress.yaml from the following file: example-ingress.yaml
-- Taken from https://k8s.io/examples/service/networking/example-ingress.yaml

NOTE: In the rules-->path section "/" refers to the service 'web' created earlier and its 8080 port of the 'pod'
NOTE: This service itself is 'hostport' which is default and not 'NodePort' - so uses 80 port of the host

apiVersion: networking.k8s.io/v1
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
            pathType: Prefix
            backend:
              service:
                name: web
                port:
                  number: 8080


- Apply the yaml
kubectl apply -f https://k8s.io/examples/service/networking/example-ingress.yaml --kubeconfig ~/.kube/admin.kubeconfig.ksn3
or - from local file
kubectl apply -f example-ingress.yaml --kubeconfig ~/.kube/admin.kubeconfig.ksn3
ingress.networking.k8s.io/example-ingress created

- Verify
kubectl get ingress --kubeconfig ~/.kube/admin.kubeconfig.ksn3

NAME              CLASS    HOSTS              ADDRESS          PORTS   AGE
example-ingress   <none>   hello-world.info   192.168.99.103   80      16s

- Verify with curl --> NOT WORKING
curl 192.168.99.103
curl: (7) Failed to connect to 192.168.99.103 port 80: Connection refused

- Verify entering a hostname in /etc/hosts (do it on a vm - not on Mac)

/etc/hosts:
192.168.99.103 hello-world.info

curl hello-world.info
curl: (7) Failed connect to hello-world.info:80; Connection refused

=============================
CREATE A SECOND APP
=============================

- Create a v2 Deployment using the following command:

kubectl create deployment web2 --image=gcr.io/google-samples/hello-app:2.0 --kubeconfig ~/.kube/admin.kubeconfig.ksn3

Output:
deployment.apps/web2 created

- Expose the Deployment:

kubectl expose deployment web2 --port=8080 --type=NodePort --kubeconfig ~/.kube/admin.kubeconfig.ksn3

Output:
service/web2 exposed

- VERIFY SERVICES LIST
# kubectl get svc --all-namespaces
NAMESPACE       NAME                                 TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                      AGE
default         kubernetes                           ClusterIP   10.96.0.1        <none>        443/TCP                      28h
default         web                                  NodePort    10.98.154.232    <none>        8080:32263/TCP               21m
default         web2                                 NodePort    10.102.88.36     <none>        8080:31760/TCP               10s
ingress-nginx   ingress-nginx-controller             NodePort    10.106.8.102     <none>        80:31097/TCP,443:32202/TCP   168m
ingress-nginx   ingress-nginx-controller-admission   ClusterIP   10.100.144.118   <none>        443/TCP                      168m
kube-system     kube-dns                             ClusterIP   10.96.0.10       <none>        53/UDP,53/TCP,9153/TCP       23h

- Curl and check
curl 192.168.99.103:31760

Hello, world!
Version: 2.0.0
Hostname: web2-5d47994f45-44xqs

===============================
ADD THE SECOND APP TO INGRESS
===============================

- Edit Ingress 
Edit the existing example-ingress.yaml and add the following lines:

      - path: /v2
        pathType: Prefix
        backend:
          service:
            name: web2
            port:
              number: 8080

- Apply the changes:
kubectl apply -f example-ingress.yaml --kubeconfig ~/.kube/admin.kubeconfig.ksn3

Output:
ingress.networking/example-ingress configured 

===============================
TEST THE INGRESS
===============================

- Access the 1st version of the Hello World app.

curl hello-world.info --> NOT WORKING
curl: (7) Failed connect to hello-world.info:80; Connection refused

Expected Output:
Hello, world!
Version: 1.0.0
Hostname: web-55b8c6998d-8k564

- Access the 2nd version of the Hello World app.

curl hello-world.info/v2 --> NOT WORKING
curl: (7) Failed connect to hello-world.info:80; Connection refused

Expected Output:

Hello, world!
Version: 2.0.0
Hostname: web2-75cd47646f-t8cjk

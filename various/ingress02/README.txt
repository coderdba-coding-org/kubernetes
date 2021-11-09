=====================================================================
REFERENCES
=====================================================================
https://kubernetes.io/docs/tasks/access-application-cluster/ingress-minikube/
https://kubernetes.github.io/ingress-nginx/user-guide/basic-usage/

https://kubernetes.io/docs/concepts/services-networking/ingress/
https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/

=====================================================================
MY DOCUMENTATION
=====================================================================
https://github.com/coderdba/NOTES/blob/master/kubernetes-kb/ingress-controller-F-nginx.txt

=====================================================================
PROBLEMS
=====================================================================
connection refused or bad-gateway error
- stop firewall - OR - open necessary firewall ports

=====================================================================
STEPS
=====================================================================

- PULL SAMPLE APPLICATION IMAGES
docker pull gcr.io/google-samples/hello-app:1.0

- CREATE INGRESS CONTROLLER
Modify the manifest nginx-ingress-controller-deploy.yaml - add correct externalIp (which is the same as that of the node)
Apply the manifest nginx-ingress-controller-deploy.yaml
- Run ingress-controller-create.sh

- CREATE THE APPS AND THEIR SERVICES
app-and-service-create.sh

- CREATE THE INGRESS
Modify 'host' in ingress.yaml if you like
ingress-create.sh

- IMPORTANT STEP
Add the 'host' in the ingress into /etc/hosts
Get the IP assigned to ingress by running the command: kubectl get ingress

NAME              CLASS   HOSTS                 ADDRESS         PORTS   AGE
example-ingress   nginx   my-hello-world.info   192.168.56.11   80      17m

Add the ip "ADDRESS" into /etc/hosts as follows:
192.168.56.11   my-hello-world.info

- ACCESS THE ENDPOINTS
# curl http://my-hello-world.info
Hello, world!
Version: 1.0.0
Hostname: web-79d88c97d6-zvrbr

# curl  http://my-hello-world.info/v2
Hello, world!
Version: 2.0.0
Hostname: web2-5d47994f45-ttcsh

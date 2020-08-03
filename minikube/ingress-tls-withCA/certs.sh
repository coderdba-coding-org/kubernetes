# https://kubernetes.github.io/ingress-nginx/examples/tls-termination/

# https://kubernetes.github.io/ingress-nginx/examples/PREREQUISITES/#tls-certificates
# And, to create with CA: https://kubernetes.github.io/ingress-nginx/examples/auth/client-certs/#creating-certificate-secrets

# https://www.serverlab.ca/tutorials/containers/kubernetes/certificate-based-mutual-authentication-with-nginx-ingress/

HOST=`minikube ip`

#============================================================
# Cert-Key Without CA
#openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -keyout tls.key -out tls.crt -subj "/CN=nginxsvc/O=nginxsvc"

# Create secret
#kubectl create secret tls tls-secret --key tls.key --cert tls.crt
#============================================================

# Cert-Key with CA
## Generate the CA Key and Certificate:
openssl req -x509 -sha256 -newkey rsa:4096 -keyout ca.key -out ca.crt -days 356 -nodes -subj '/CN=My Cert Authority'

## Generate the Server Key, and Certificate and Sign with the CA Certificate:
### Generate key
#openssl req -new -newkey rsa:4096 -keyout server.key -out server.csr -nodes -subj '/CN=mydomain.com'
openssl req -new -newkey rsa:4096 -keyout server.key -out server.csr -nodes -subj '/CN=${HOST}'
### Generate cert signed with ca cert
openssl x509 -req -sha256 -days 365 -in server.csr -CA ca.crt -CAkey ca.key -set_serial 01 -out server.crt

# CLIENT-KEY - ONLY IF YOU WANT CLIENT-AUTH IN SERVER (USUALLY WE DONT NEED THIS)
# Generate the Client Key, and Certificate and Sign with the CA Certificate:
## Generate key
openssl req -new -newkey rsa:4096 -keyout client.key -out client.csr -nodes -subj '/CN=My Client'
## Generate cert signed with ca cert
openssl x509 -req -sha256 -days 365 -in client.csr -CA ca.crt -CAkey ca.key -set_serial 02 -out client.crt

echo
echo INFO - Creating Kubernetes secret

# Create tls secret - when we dont need client-auth
kubectl delete secret tls-secret
kubectl create secret tls tls-secret --key server.key --cert server.crt
#This does not work: kubectl create secret tls tls-secret --from-file=tls.crt=server.crt --from-file=tls.key=server.key

# Create secret with cert, key and CA cert as well (this CA cert will be used by server to do client-auth)
#  https://kubernetes.github.io/ingress-nginx/examples/auth/client-certs/#creating-certificate-secrets)

## Create a combined one
#kubectl create secret generic ca-secret-tls --from-file=tls.crt=server.crt --from-file=tls.key=server.key --from-file=ca.crt=ca.crt

## Or, create two separate ones - the first one will be used for client-auth
#kubectl create secret generic ca-secret --from-file=ca.crt=ca.crt
#kubectl create secret generic/tls?? tls-secret --from-file=tls.crt=server.crt --from-file=tls.key=server.key

# Create the http-svc pod
kubectl create -f http-svc.yaml
kubectl apply -f http-svc.yaml
kubectl get po
kubectl get svc

# Create the ingress
kubectl apply -f ingres.yaml

# Access the app
curl https://minikube-ip:80
--> this will fail

curl -k https://minikube-ip:80
--> this will work

curl --cacert=ca.crt https://minikube-ip:80
--> IS FAILING - TBD


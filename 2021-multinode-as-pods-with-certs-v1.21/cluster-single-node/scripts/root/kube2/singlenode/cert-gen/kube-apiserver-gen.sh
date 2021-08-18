#NOTE: hostname has IP and hostname (not just IP as in the web 'deploying...' example)
#NOTE: 10.96.0.1 is derived from pod-ip cidr - with 1 at the end - this is assigned to apiserver pod by default
#NOTE: 127.0.0.1 is required as well

# Change CIDR IP as needed
# Use multi or single node modified as needed

# Multi Node
#-hostname=10.96.0.1,192.168.99.101,k1,192.168.99.102,k2,192.168.99.103,k3,127.0.0.1,kubernetes,kubernetes.default,kubernetes.default.svc,kubernetes.default.svc.cluster,kubernetes.svc.cluster.local \
#cfssl gencert \
#-ca=certs/ca.pem \
#-ca-key=certs/ca-key.pem \
#-config=ca-config.json \
##-hostname=10.96.0.1,192.168.99.101,k1,192.168.99.102,k2,192.168.99.103,k3,127.0.0.1,kubernetes.default \
#-profile=kubernetes kube-apiserver-csr.json | \
#cfssljson -bare certs/kube-apiserver

# Single Node
#-hostname=10.96.0.1,192.168.99.101,ksn1,127.0.0.1,kubernetes.default \
cfssl gencert \
-ca=certs/ca.pem \
-ca-key=certs/ca-key.pem \
-config=ca-config.json \
-hostname=10.96.0.1,192.168.99.101,ksn1,127.0.0.1,kubernetes,kubernetes.default,kubernetes.default.svc,kubernetes.default.svc.cluster,kubernetes.svc.cluster.local \
-profile=kubernetes kube-apiserver-csr.json | \
cfssljson -bare certs/kube-apiserver



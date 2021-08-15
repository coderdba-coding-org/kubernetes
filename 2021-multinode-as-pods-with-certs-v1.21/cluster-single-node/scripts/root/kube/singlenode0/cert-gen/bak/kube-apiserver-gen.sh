#NOTE: hostname has IP and hostname (not just IP as in the web 'deploying...' example)
#NOTE: 10.96.0.1 is derived from pod-ip cidr - with 1 at the end - this is assigned to apiserver pod by default
#NOTE: 127.0.0.1 is required as well

# Change CIDR IP as needed
# Use multi or single node modified as needed

# Multi Node
#cfssl gencert \
#-ca=ca.pem \
#-ca-key=ca-key.pem \
#-config=ca-config.json \
#-hostname=10.96.0.1,192.168.99.101,k1,192.168.99.102,k2,192.168.99.103,k3,127.0.0.1,kubernetes.default \
#-profile=kubernetes kube-apiserver-csr.json | \
#cfssljson -bare kube-apiserver

# Single Node
cfssl gencert \
-ca=ca.pem \
-ca-key=ca-key.pem \
-config=ca-config.json \
-hostname=10.96.0.1,192.168.99.101,ksn1,127.0.0.1,kubernetes.default \
-profile=kubernetes kube-apiserver-csr.json | \
cfssljson -bare kube-apiserver



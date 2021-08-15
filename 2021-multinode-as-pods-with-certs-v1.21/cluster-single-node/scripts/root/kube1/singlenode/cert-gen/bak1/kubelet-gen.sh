# 3-node model commands below
# Uncomment and change IP and hostname as needed
# If a single-node cluster, then copy just one and change IP and hostname as needed
#cfssl gencert \
#-ca=ca.pem \
#-ca-key=ca-key.pem \
#-config=ca-config.json \
#-hostname=192,168.99.201,k1 \
#-profile=kubernetes kubelet-k1-csr.json | \
#cfssljson -bare kubelet-k1
#
#cfssl gencert \
#-ca=ca.pem \
#-ca-key=ca-key.pem \
#-config=ca-config.json \
#-hostname=192,168.99.202,k2 \
#-profile=kubernetes kubelet-k2-csr.json | \
#cfssljson -bare kubelet-k2
#
#cfssl gencert \
#-ca=ca.pem \
#-ca-key=ca-key.pem \
#-config=ca-config.json \
#-hostname=192,168.99.203,k3 \
#-profile=kubernetes kubelet-k3-csr.json | \
#cfssljson -bare kubelet-k3

# Single node
cfssl gencert \
-ca=certs/ca.pem \
-ca-key=certs/ca-key.pem \
-config=ca-config.json \
-hostname=192,168.99.101,ksn1 \
-profile=kubernetes kubelet-ksn1-csr.json | \
cfssljson -bare kubelet-ksn1

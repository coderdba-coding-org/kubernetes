# NOTE: Uncomment and modify as needed - for single and multi nodes
# NOTE: Modify hostname-suffix ksn1, k1, k2, k3 as needed
# NOTE: Also, probably we dont really need k1,k2,k3 - maybe one file-pair can be used by all etcd instances

#================
# Single Node
#================
# Client certificates
cfssl gencert \
-ca certs/ca.pem -ca-key certs/ca-key.pem \
-config ca-config.json -profile=kubernetes etcd-singlenode-csr.json | \
cfssljson -bare certs/etcd-ksn1

# Peer certificates
cfssl gencert \
-ca certs/ca.pem -ca-key certs/ca-key.pem \
-config ca-config.json -profile=kubernetes etcd-singlenode-csr.json | \
cfssljson -bare certs/etcd-peer-ksn1


#================
# Multi Node
#================
# Client certificates
#cfssl gencert \
#-ca certs/ca.pem -ca-key certs/ca-key.pem \
#-config ca-config.json -profile=kubernetes etcd-multinode-csr.json | \
#cfssljson -bare certs/etcd-k1

# Peer certificates
#cfssl gencert \
#-ca certs/ca.pem -ca-key certs/ca-key.pem \
#-config ca-config.json -profile=kubernetes etcd-multinode-csr.json | \
#cfssljson -bare certs/etcd-peer-k1

# Client certificates
#cfssl gencert \
#-ca certs/ca.pem -ca-key certs/ca-key.pem \
#-config ca-config.json -profile=kubernetes etcd-multinode-csr.json | \
#cfssljson -bare certs/etcd-k2

# Peer certificates
#cfssl gencert \
#-ca certs/ca.pem -ca-key certs/ca-key.pem \
#-config ca-config.json etcd-multinode-csr.json | \
#cfssljson -bare certs/etcd-peer-k2

# Client certificates
#cfssl gencert \
#-ca certs/ca.pem -ca-key certs/ca-key.pem \
#-config ca-config.json etcd-multinode-csr.json | \
#cfssljson -bare certs/etcd-k3

# Peer certificates
#cfssl gencert \
#-ca certs/ca.pem -ca-key certs/ca-key.pem \
#-config ca-config.json etcd-multinode-csr.json | \
#cfssljson -bare certs/etcd-peer-k3


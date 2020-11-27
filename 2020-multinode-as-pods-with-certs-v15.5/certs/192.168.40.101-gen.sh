cfssl gencert \
-ca=ca.pem \
-ca-key=ca-key.pem \
-config=ca-config.json \
-hostname=192,168.40.101,k1 \
-profile=kubernetes 192,168.40.101-csr.json | \
cfssljson -bare 192,168.40.101

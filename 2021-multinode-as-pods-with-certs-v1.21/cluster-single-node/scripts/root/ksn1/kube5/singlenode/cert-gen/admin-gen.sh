#-hostname=192.168.99.101,ksn1,127.0.0.1 \

cfssl gencert \
-ca=certs/ca.pem \
-ca-key=certs/ca-key.pem \
-config=ca-config.json \
-profile=kubernetes admin-csr.json | \
cfssljson -bare certs/admin

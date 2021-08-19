cfssl gencert \
-ca=certs/ca.pem -ca-key=certs/ca-key.pem \
-config=ca-config.json \
-profile=kubernetes kube-proxy-csr.json | \
cfssljson -bare certs/kube-proxy

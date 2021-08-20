cfssl gencert \
  -ca=certs/ca.pem \
  -ca-key=certs/ca-key.pem \
  -config=ca-config.json \
  -profile=kubernetes \
  service-account-csr.json | cfssljson -bare certs/service-account

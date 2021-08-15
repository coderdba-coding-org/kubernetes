cfssl gencert -initca ca-csr.json | cfssljson -bare certs/ca

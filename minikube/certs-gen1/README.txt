https://deliciousbrains.com/ssl-certificate-authority-for-local-https-development/

CA KEY *****
openssl genrsa -des3 -out myCA.key 2048
--> passphrase: kubernetes

CA ROOT CERT *****
openssl req -x509 -new -nodes -key myCA.key -sha256 -days 1825 -out myCA.pem

  Country Name (2 letter code) [AU]:IN
  State or Province Name (full name) [Some-State]:IN
  Locality Name (eg, city) []:IN
  Organization Name (eg, company) [Internet Widgits Pty Ltd]:IN
  Organizational Unit Name (eg, section) []:
  Common Name (e.g. server FQDN or YOUR name) []:
  Email Address []:

ADD ROOT CERT TO MAC KEYCHAIN
sudo security add-trusted-cert -d -r trustRoot -k "/Library/Keychains/System.keychain" myCA.pem

PRIVATE KEY *****
#openssl genrsa -out dev.deliciousbrains.com.key 2048
openssl genrsa -out ingress-tls.key 2048

CSR
#openssl req -new -key dev.deliciousbrains.com.key -out dev.deliciousbrains.com.csr
openssl req -new -key ingress-tls.key -out ingress-tls.csr

   Country Name (2 letter code) [AU]:IN
   State or Province Name (full name) [Some-State]:IN
   Locality Name (eg, city) []:IN
   Organization Name (eg, company) [Internet Widgits Pty Ltd]:IN
   Organizational Unit Name (eg, section) []:
   Common Name (e.g. server FQDN or YOUR name) []:
   Email Address []:
   
   Please enter the following 'extra' attributes
   to be sent with your certificate request
   A challenge password []: <<< leave null >>>
   An optional company name []:


-->>>>> Next we’ll create the certificate using our CSR, the CA private key, the CA certificate,

CREATE EXT FILE (optional??)
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = dev.deliciousbrains.com

CREATE CERT *****
#openssl x509 -req -in dev.deliciousbrains.com.csr -CA myCA.pem -CAkey myCA.key -CAcreateserial \
#-out dev.deliciousbrains.com.crt -days 825 -sha256 -extfile dev.deliciousbrains.com.ext

# Touched an empty file ingress-tls.ext
openssl x509 -req -in ingress-tls.csr -CA myCA.pem -CAkey myCA.key -CAcreateserial \
-out ingress-tls.crt -days 825 -sha256 -extfile ingress-tls.ext

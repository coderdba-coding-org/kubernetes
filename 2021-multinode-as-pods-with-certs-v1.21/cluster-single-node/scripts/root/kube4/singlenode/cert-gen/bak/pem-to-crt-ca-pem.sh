# https://stackoverflow.com/questions/13732826/convert-pem-to-crt-and-key`
# openssl x509 -outform der -in your-cert.pem -out your-cert.crt

openssl x509 -outform der -in certs/ca.pem -out certs/ca.crt

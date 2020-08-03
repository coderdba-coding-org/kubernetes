TLS termination:  
https://kubernetes.github.io/ingress-nginx/examples/tls-termination/  
  
Prerequisites:  
- https://kubernetes.github.io/ingress-nginx/examples/PREREQUISITES/#tls-certificates  
- https://kubernetes.github.io/ingress-nginx/examples/auth/client-certs/#creating-certificate-secrets  
- https://kubernetes.github.io/ingress-nginx/examples/PREREQUISITES/#test-http-service  

Client Certs stuff:  
https://kubernetes.github.io/ingress-nginx/examples/auth/client-certs/

HSTS:  
https://kubernetes.github.io/ingress-nginx/user-guide/tls/  
- https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/configmap/

Reference:  
Curl with cacert option: https://stackoverflow.com/questions/31305376/using-client-certificate-in-curl-command
Create certs and CA in pem: https://www.simba.com/products/SEN/doc/Client-Server_user_guide/content/clientserver/configuringssl/signingca.htm
Create certs and ca in pem:https://blogs.oracle.com/blogbypuneeth/steps-to-create-a-self-signed-certificate-using-openssl
Convert crt to pem: https://cheapsslsecurity.com/p/convert-a-certificate-to-pem-crt-to-pem-cer-to-pem-der-to-pem/

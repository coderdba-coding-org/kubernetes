cat /etc/kubernetes/pki/ca.pem | base64 -w 0 > ca.pem.base64
cat /etc/kubernetes/pki/kubernetes.pem | base64 -w 0 > kubernetes.pem.base64
cat /etc/kubernetes/pki/kubernetes-key.pem | base64 -w 0 > kubernetes-key.pem.base64


# kubectl apply -f ./secret.yaml --kubeconfig /root/.kube/admin.kubeconfig
secret/goweb1defaultmessage created

# kubectl describe secret goweb1defaultmessage
Name:         goweb1defaultmessage
Namespace:    default
Labels:       <none>
Annotations:  <none>

Type:  Opaque

Data
====
message_text:  20 bytes


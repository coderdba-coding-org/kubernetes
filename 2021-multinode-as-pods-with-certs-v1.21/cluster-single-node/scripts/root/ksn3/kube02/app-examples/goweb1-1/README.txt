====================================
POD WITH CONFIGMAP AS MOUNTED FILE
====================================

====================================
REFERENCES
====================================

Configmap:
- Concept: https://kubernetes.io/docs/concepts/configuration/configmap/
- Example: https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/

Service:
- Concept: https://kubernetes.io/docs/concepts/services-networking/service/
- Example: https://www.bmc.com/blogs/kubernetes-port-targetport-nodeport/
- Example: https://kubernetes.io/docs/concepts/services-networking/connect-applications-service/


====================================
STEPS
====================================

# kubectl apply -f configmap-goweb1-default-message.yaml --kubeconfig=~/.kube/admin.kubeconfig
# kubectl apply -f pod-goweb1.yaml --kubeconfig=~/.kube/admin.kubeconfig
# kubectl apply -f service.yaml --kubeconfig=~/.kube/admin.kubeconfig

# kubectl get svc -n default -o wide
NAME               TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE    SELECTOR
goweb1-1-service   NodePort    10.97.125.13    <none>        8081:30036/TCP   6m4s   app=goweb1-1
kubernetes         ClusterIP   10.96.0.1       <none>        443/TCP          5d5h   <none>
web                NodePort    10.98.154.232   <none>        8080:32263/TCP   4d     app=web
web2               NodePort    10.102.88.36    <none>        8080:31760/TCP   4d     app=web2

- From host where kubernetes is running - curl localhost's nodeport
# curl localhost:30036
{"message":"Welcome!"}

# curl localhost:30036/message
{"message":"message from configmap"}

- From outside world (say, virtualbox host which is laptop)
# curl 192.168.99.103:30036
{"message":"Welcome!"}

# curl 192.168.99.103:30036/message
{"message":"message from configmap"}

- From another pod - curl the service name / ip
# kubectl exec -ti  another-pod-that-has-curl /bin/sh
/ # curl 10.97.125.13:8081
/ # curl 10.97.125.13:8081/message

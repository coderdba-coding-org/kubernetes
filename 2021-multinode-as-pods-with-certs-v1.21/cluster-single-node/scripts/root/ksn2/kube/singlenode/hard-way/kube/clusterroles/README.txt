https://kubernetes.io/docs/reference/access-authn-authz/rbac/
https://docs.bitnami.com/tutorials/configure-rbac-in-your-kubernetes-cluster/

===================================
ERROR WHILE DOING kubectl get logs
===================================

FIXED:
Refer to kube-apiserver-to-kubelet-bind.yaml.user.and.group
--> added Group system:nodes which is the group of kubelet (see the csr for kubelet) 
       Reference for system:nodes 'O' group which is 'Group' kind in Kubernetes
       cert-kubelet-gen.sh:      "O": "system:nodes",
       kubelet-ksn2-csr.json:      "O": "system:nodes",
--> added pods/log in the clusterrole file kube-apiserver-to-kubelet.yaml (pods/log was not in the hard-way)

IDEALLY:
Create another user and see if pods/log can be assigned to it

EARLIER ERRORS:
The kubernetes one is failing kubectl get pods - with admin and kubelet kubeconfigs bot
- File: kube-apiserver-to-kubelet-bind.yaml.user.kubernetes
- # kubectl logs kube-apiserver-ksn2  -n kube-system
Error from server (Forbidden): Forbidden (user=system:node:ksn2, verb=get, resource=nodes, subresource=proxy) ( pods/log kube-apiserver-ksn2)

The system.node.ksn2 one is working ok with kubectl get pods - with admin and kubelet kubeconfigs bot
- File: kube-apiserver-to-kubelet-bind.yaml.user.system:node:ksn2
- # kubectl logs kube-apiserver-ksn2  -n kube-system --> gives the log output

These changes to admin user still gave the same error as before
admin-user-clusterrole-bind-cluster-admin.yaml
admin-user-clusterrole-bind.yaml
admin-user-clusterrole.yaml

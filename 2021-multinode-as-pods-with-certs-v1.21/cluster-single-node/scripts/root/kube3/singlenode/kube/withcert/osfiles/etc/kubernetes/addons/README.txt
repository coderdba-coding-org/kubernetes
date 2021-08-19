Reference for config files:
- Mostly taken first from this: https://github.com/coderdba-coding-org/code1/blob/master/kubernetes/kube-vbox-ans-singlenode-15.5/roles/kube-proxy/templates/kube-proxy.yaml.j2
- https://gitlab.cncf.ci/kubernetes/kubernetes/tree/master/cluster/addons/kube-proxy
- https://github.com/QingCloudAppcenter/kubernetes/blob/master/k8s/addons/kube-proxy/kube-proxy-ds.yaml


===========================
COMMANDS
===========================
# kubectl apply -f kube-proxy-rbac.yaml --kubeconfig /etc/kubernetes/admin.kubeconfig
# kubectl apply -f kube-proxy-ds.yaml --kubeconfig /etc/kubernetes/admin.kubeconfig

# kubectl get ds --kubeconfig /etc/kubernetes/admin.kubeconfig --all-namespaces
# kubectl logs kube-proxy -n kube-system --kubeconfig /etc/kubernetes/admin.kubeconfig
# kubectl describe ds kube-proxy -n kube-system --kubeconfig /etc/kubernetes/admin.kubeconfig

# kubectl cluster-info dump | grep authorization-modek


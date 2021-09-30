==================================================
STEPS
==================================================
Modify IP address and hostname of node in yaml files
Modify (if needed) cluster cidr and service ip address range in yaml files
Copy the yaml files to /etc/kubernetes/manifests


==================================================
TROUBLESHOOTING
==================================================
- SCHEDULER ERROR 1
FIX: Add --kubeconfig parameter to kube-scheduler.yaml

I0819 13:34:20.913298       1 serving.go:347] Generated self-signed cert in-memory
W0819 13:34:21.727683       1 authentication.go:308] No authentication-kubeconfig provided in order to lookup client-ca-file in configmap/extension-apiserver-authentication in kube-system, so client certificate authentication won't work.
W0819 13:34:21.727707       1 authentication.go:332] No authentication-kubeconfig provided in order to lookup requestheader-client-ca-file in configmap/extension-apiserver-authentication in kube-system, so request-header client certificate authentication won't work.
W0819 13:34:21.727731       1 authorization.go:184] No authorization-kubeconfig provided, so SubjectAccessReview of authorization tokens won't work.
W0819 13:34:21.727805       1 options.go:335] Neither --kubeconfig nor --master was specified. Using default API client. This might not work.
invalid configuration: no configuration has been provided, try setting KUBERNETES_MASTER environment variable


- KUBELET ERROR - though all docker containers had started
   CGroup: /system.slice/kubelet.service
           └─22122 /usr/bin/kubelet --authorization-mode=Webhook --kubeconfig=/etc/kubernetes/kubeconfig/kubelet-ksn2.kubeconfig --config=/var/lib/kubelet/config.yaml --client-ca-file=/etc/kubernetes/pki/ca.pem --tls-cert-file=/etc/kubernetes/pki/kubelet-ksn2.pem --tls-private-key-file=/etc/kubernetes/pki/kubelet-ksn2-key.pem

Aug 19 19:23:57 ksn2 kubelet[22122]: E0819 19:23:57.644330   22122 reflector.go:138] k8s.io/client-go/informers/factory.go:134: Failed to watch *v1.RuntimeClass: failed to list *v1.RuntimeClass: runtimeclasses.node.k8s.io is forbidden: User "system:anonymous" cannot list resource "runtimeclasses" in API group "node.k8s.io" at the cluster scope
Aug 19 19:23:57 ksn2 kubelet[22122]: E0819 19:23:57.688391   22122 kubelet.go:2291] "Error getting node" err="node \"ksn2\" not found"
Aug 19 19:23:57 ksn2 kubelet[22122]: E0819 19:23:57.789554   22122 kubelet.go:2291] "Error getting node" err="node \"ksn2\" not found"
Aug 19 19:23:57 ksn2 kubelet[22122]: E0819 19:23:57.891523   22122 kubelet.go:2291] "Error getting node" err="node \"ksn2\" not found"
Aug 19 19:23:57 ksn2 kubelet[22122]: E0819 19:23:57.992646   22122 kubelet.go:2291] "Error getting node" err="node \"ksn2\" not found"
Aug 19 19:23:58 ksn2 kubelet[22122]: E0819 19:23:58.093050   22122 kubelet.go:2291] "Error getting node" err="node \"ksn2\" not found"
Aug 19 19:23:58 ksn2 kubelet[22122]: E0819 19:23:58.193617   22122 kubelet.go:2291] "Error getting node" err="node \"ksn2\" not found"
Aug 19 19:23:58 ksn2 kubelet[22122]: E0819 19:23:58.294340   22122 kubelet.go:2291] "Error getting node" err="node \"ksn2\" not found"
Aug 19 19:23:58 ksn2 kubelet[22122]: E0819 19:23:58.395369   22122 kubelet.go:2291] "Error getting node" err="node \"ksn2\" not found"
Aug 19 19:23:58 ksn2 kubelet[22122]: E0819 19:23:58.496694   22122 kubelet.go:2291] "Error getting node" err="node \"ksn2\" not found"


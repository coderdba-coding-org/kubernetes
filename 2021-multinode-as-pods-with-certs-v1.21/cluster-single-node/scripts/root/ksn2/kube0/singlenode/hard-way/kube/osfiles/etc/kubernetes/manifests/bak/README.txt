- SCHEDULER ERROR 1
FIX: Add --kubeconfig parameter to kube-scheduler.yaml

I0819 13:34:20.913298       1 serving.go:347] Generated self-signed cert in-memory
W0819 13:34:21.727683       1 authentication.go:308] No authentication-kubeconfig provided in order to lookup client-ca-file in configmap/extension-apiserver-authentication in kube-system, so client certificate authentication won't work.
W0819 13:34:21.727707       1 authentication.go:332] No authentication-kubeconfig provided in order to lookup requestheader-client-ca-file in configmap/extension-apiserver-authentication in kube-system, so request-header client certificate authentication won't work.
W0819 13:34:21.727731       1 authorization.go:184] No authorization-kubeconfig provided, so SubjectAccessReview of authorization tokens won't work.
W0819 13:34:21.727805       1 options.go:335] Neither --kubeconfig nor --master was specified. Using default API client. This might not work.
invalid configuration: no configuration has been provided, try setting KUBERNETES_MASTER environment variable


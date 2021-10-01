=======================
COREDNS
=======================

Reference: https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/12-dns-addon.md

=======================
STEPS
=======================
- Review and ONLY IF NECESSARY modify the yaml file coredns-1.8.yaml
- Create: kubectl apply -f ./coredns-1.8.yaml --kubeconfig /etc/kubernetes/kubeconfig/admin.kubeconfig


=================================
ISSUE - COREDNS CrashLoopBackoff
=================================
https://github.com/projectcalico/calico/issues/3422
https://github.com/kubernetes/dashboard/issues/3709

-- ISSUE
# kubectl logs coredns-8494f9c688-qfp25 -n kube-system
plugin/kubernetes: Get "https://10.96.0.1:443/version?timeout=32s": dial tcp 10.96.0.1:443: i/o timeout

[root@ksn1 kube]#  kubectl get svc --all-namespaces -o wide
NAMESPACE     NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)                  AGE   SELECTOR
default       kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP                  11h   <none>
kube-system   kube-dns     ClusterIP   10.96.0.10   <none>        53/UDP,53/TCP,9153/TCP   11m   k8s-app=kube-dns



=======================
NOTES
=======================
1. Made replics=1 from 2

~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~
Warning in kubectl logs of the pod:
W0820 06:47:41.978545       1 warnings.go:70] discovery.k8s.io/v1beta1 EndpointSlice is deprecated in v1.21+, unavailable in v1.25+; use discovery.k8s.io/v1 EndpointSlice





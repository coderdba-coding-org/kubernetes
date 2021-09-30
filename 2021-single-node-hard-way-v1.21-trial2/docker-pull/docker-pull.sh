#=====================================================
#- ETCD
# docker pull quay.io/coreos/etcd:latest
#docker pull quay.io/coreos/etcd:3.4.13-0
#
#- MASTER (with additional components for workers also)
#--- FOR SPECIFIC VERSIONS
#https://kubernetes.io/docs/setup/release/notes/ 
#gcr.io/google_containers/kube-proxy-amd64(and such)
#=====================================================

#-- REQUIRED
docker pull k8s.gcr.io/etcd:3.4.13-0
docker pull k8s.gcr.io/kube-apiserver:v1.21.2
docker pull k8s.gcr.io/kube-scheduler:v1.21.2
docker pull k8s.gcr.io/kube-controller-manager:v1.21.2
docker pull k8s.gcr.io/kube-proxy:v1.21.2
docker pull calico/node:v3.19.1
docker pull calico/pod2daemon-flexvol:v3.19.1
docker pull calico/cni:v3.19.1
docker pull calico/kube-controllers:v3.19.1
docker pull k8s.gcr.io/coredns/coredns:v1.8.0
docker pull k8s.gcr.io/pause-amd64:3.1

#-- ADDITIONAL (TBD)
#docker pull quay.io/jcmoraisjr/haproxy-ingress:v0.12.7
#- older docker pull quay.io/jcmoraisjr/haproxy-ingress:v0.12.6 --> to make common vm image for master and worker
#- https://quay.io/repository/jcmoraisjr/haproxy-ingress?tag=latest&tab=tags
#docker pull gcr.io/google-containers/kube-addon-manager-amd64:v9.1.1
#docker pull bitnami/metrics-server:0.5.0
#- old docker pull gcr.io/google-containers/metrics-server-amd64:v0.3.6
#docker pull gcr.io/google-containers/rescheduler:v0.4.0

#-- DID NOT WORK
#docker pull k8s.gcr.io/pause-amd64:3.4.1

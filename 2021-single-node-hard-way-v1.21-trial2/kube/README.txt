====================================
DIRECTORIES WITH NECESSARY FILES
====================================
osfiles
addons
clusterroles
roles

====================================
IP ADDRESS STUFF
====================================

-------------
cluster-cidr
-------------
This is what pods will get

kube-controller-manager.yaml:    - --cluster-cidr=172.16.0.0/16
kube-proxy-ds.yaml: - --cluster-cidr=172.16.0.0/16

-------------------------
service-cluster-ip-range
-------------------------
This is what 'clusterIp' services will get for system services???

kube-apiserver.yaml:    - --service-cluster-ip-range=10.96.0.0/12
kube-controller-manager.yaml:    - --service-cluster-ip-range=10.96.0.0/12

====================================
STEPS
====================================

- CERTIFICATES AND KUBECONFIG
Generate and copy certificates and kubeconfig in the "certs-gen" folder (not subfolder of this folder)

- COPY KUBECONFIG TO ~/.kube
NOTE: This step is necessary for kubectl to communicate with kube apiserver 
      - otherwise kubectl get nodes and such commands give localhost:8080 connection refused error

mkdir ~/.kube
cp -p /etc/kubernetes/kubeconfig/* ~/.kube/.
cp -p ~/.kube/admin.kubeconfig ~/.kube/config

- MANIFESTS
Modify and copy files in osfiles/etc/kubernetes/manifests --> see README.txt in it

- KUBELET CONFIG FILE
Modify and copy file in osfiles/var/lib/kubelet --> see README.txt in it

- KUBELET SERVICE FILE
Modify and copy file in osfiles/usr/lib/systemd/system --> see README.txt in it

- CNI BRIDGE AND LOOPBACK CONFIGURATION
Modify and copy files in osfiles/etc/cni/net.d --> see README.txt in it

- START KUBELET
systemctl enable kubelet
systemctl start kubelet

- CREATE CLUSTER ROLE AND BINDING
Do steps in README.txt of clusterroles folder

- NOTE
The following are yet to be done: (do after the VERIFY step below)
- Still we dont have kube-dns (actually coredns), flannel and such setup
- Also kube-proxy is not set up yet

- VERIFY
Use admin.kubeconfig as config in ~/.kube (ln -s admin.kubeconfig config)

# kubectl get pods --all-namespaces -o wide
NAMESPACE     NAME                           READY   STATUS    RESTARTS   AGE   IP              NODE   NOMINATED NODE   READINESS GATES
kube-system   kube-apiserver-ksn1            1/1     Running   0          19m   192.168.56.11   ksn1   <none>           <none>
kube-system   kube-controller-manager-ksn1   1/1     Running   0          19m   192.168.56.11   ksn1   <none>           <none>
kube-system   kube-scheduler-ksn1            1/1     Running   0          19m   192.168.56.11   ksn1   <none>           <none>

# kubectl get componentstatus
Warning: v1 ComponentStatus is deprecated in v1.19+
NAME                 STATUS    MESSAGE             ERROR
scheduler            Healthy   ok                  
controller-manager   Healthy   ok                  
etcd-0               Healthy   {"health":"true"}  

-- KUBE-PROXY
Follow README.txt in addons/kube-proxy

-- COREDNS
Follow README.txt in addons/coredns

-- VERIFY
At this point, the components will be like this:

# kubectl get nodes -o wide
NAME   STATUS   ROLES    AGE   VERSION   INTERNAL-IP     EXTERNAL-IP   OS-IMAGE                KERNEL-VERSION           CONTAINER-RUNTIME
ksn1   Ready    <none>   11h   v1.21.2   192.168.56.11   <none>        CentOS Linux 7 (Core)   3.10.0-1160.el7.x86_64   docker://20.10.0

#  kubectl get pods --all-namespaces -o wide
NAMESPACE     NAME                           READY   STATUS    RESTARTS   AGE     IP              NODE   NOMINATED NODE   READINESS GATES
kube-system   coredns-8494f9c688-9nr6t       1/1     Running   0          2m10s   172.17.0.3      ksn1   <none>           <none>
kube-system   kube-apiserver-ksn1            1/1     Running   1          11h     192.168.56.11   ksn1   <none>           <none>
kube-system   kube-controller-manager-ksn1   1/1     Running   1          11h     192.168.56.11   ksn1   <none>           <none>
kube-system   kube-proxy-rvbsn               1/1     Running   0          2m51s   192.168.56.11   ksn1   <none>           <none>
kube-system   kube-scheduler-ksn1            1/1     Running   2          11h     192.168.56.11   ksn1   <none>           <none>

#  kubectl get svc --all-namespaces -o wide
NAMESPACE     NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)                  AGE   SELECTOR
default       kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP                  11h   <none>
kube-system   kube-dns     ClusterIP   10.96.0.10   <none>        53/UDP,53/TCP,9153/TCP   19m   k8s-app=kube-dns

- CALICO
Follow README.txt in addons/calico

- VERIFY
At this point, the components will be like this:

# kubectl get pods --all-namespaces -o wide
NAMESPACE     NAME                                       READY   STATUS    RESTARTS   AGE     IP              NODE   NOMINATED NODE   READINESS GATES
kube-system   calico-kube-controllers-86475544f5-cbbg5   1/1     Running   0          21s     192.168.56.11   ksn1   <none>           <none>
kube-system   calico-node-4q4fm                          1/1     Running   4          7m12s   192.168.56.11   ksn1   <none>           <none>
kube-system   coredns-8494f9c688-9nr6t                   1/1     Running   0          20m     172.17.0.3      ksn1   <none>           <none>
kube-system   kube-apiserver-ksn1                        1/1     Running   1          12h     192.168.56.11   ksn1   <none>           <none>
kube-system   kube-controller-manager-ksn1               1/1     Running   1          12h     192.168.56.11   ksn1   <none>           <none>
kube-system   kube-proxy-rvbsn                           1/1     Running   0          20m     192.168.56.11   ksn1   <none>           <none>
kube-system   kube-scheduler-ksn1                        1/1     Running   2          12h     192.168.56.11   ksn1   <none>           <none>

# kubectl get svc --all-namespaces -o wide
NAMESPACE     NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)                  AGE   SELECTOR
default       kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP                  12h   <none>
kube-system   kube-dns     ClusterIP   10.96.0.10   <none>        53/UDP,53/TCP,9153/TCP   38m   k8s-app=kube-dns



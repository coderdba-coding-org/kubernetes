====================================
DIRECTORIES WITH NECESSARY FILES
====================================
osfiles
addons
clusterroles
roles

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

- NEXT STEPS
-- COREDNS
-- CALICO
-- KUBE-PROXY

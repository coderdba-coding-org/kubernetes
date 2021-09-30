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

- MANIFESTS
Modify and copy files in osfiles/etc/kubernetes/manifests --> see README.txt in it

- KUBELET CONFIG FILE
Modify and copy file in osfiles/var/lib/kubelet --> see README.txt in it

- KUBELET SERVICE FILE
Modify and copy file in osfiles/usr/lib/systemd/system --> see README.txt in it

- START KUBELET
systemctl enable kubelet
systemctl start kubelet

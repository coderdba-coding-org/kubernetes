echo
echo etcd service
ls -l /etc/systemd/system/etcd.service

echo
echo kubelet service
ls -l /usr/lib/systemd/system/kubelet.service.d/10*f

echo
echo kubelet config
ls -l /var/lib/kubelet/config*yaml

echo
echo manifests
ls -l /etc/kubernetes/manifests/*

echo
echo certs and keys
ls -l /etc/kubernetes/pki/*

echo
echo kubeconfig files
ls -l /etc/kubernetes/kubeconfig/*

echo
echo /etc/environment file
ls -l /etc/environment



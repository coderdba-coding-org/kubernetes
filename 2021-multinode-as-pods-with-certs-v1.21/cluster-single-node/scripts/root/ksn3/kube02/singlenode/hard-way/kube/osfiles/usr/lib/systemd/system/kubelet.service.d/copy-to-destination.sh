echo
echo Copying
mkdir -p /usr/lib/systemd/system/kubelet.service.d
/bin/cp -p 10-kubeadm.conf /usr/lib/systemd/system/kubelet.service.d/.

echo
echo Listing destination files
ls -l /usr/lib/systemd/system/kubelet.service.d/*

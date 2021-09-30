echo 
echo Copying
mkdir -p /var/lib/kubelet
/bin/cp -p config.yaml /var/lib/kubelet/.

echo
echo Listing destination files
ls -l /var/lib/kubelet/*

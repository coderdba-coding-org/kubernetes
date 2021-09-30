echo
echo Copying to destinations

mkdir -p /etc/kubernetes/pki
mkdir -p /etc/kubernetes/kubeconfig

/bin/cp -p *pem /etc/kubernetes/pki
/bin/cp -p *kubeconfig /etc/kubernetes/kubeconfig

echo
echo Listing copied destination files
echo

ls -l /etc/kubernetes/pki/*
ls -l /etc/kubernetes/kubeconfig/*

echo
echo Copying to ~/.kube
echo

mkdir -p ~/.kube
cp -p /etc/kubernetes/kubeconfig/* ~/.kube/.
cp -p ~/.kube/admin.kubeconfig ~/.kube/config

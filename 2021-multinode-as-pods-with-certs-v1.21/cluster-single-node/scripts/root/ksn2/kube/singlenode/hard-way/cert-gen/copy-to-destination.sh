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


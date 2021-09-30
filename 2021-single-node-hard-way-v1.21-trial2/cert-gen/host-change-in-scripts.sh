sed -i 's/192\.168\.99\.103/192\.168\.56\.11/g' cert-kube-apiserver-gen.sh
sed -i 's/192\.168\.99\.103/192\.168\.56\.11/g' cert-kubelet-gen.sh
sed -i 's/192\.168\.99\.103/192\.168\.56\.11/g' cert-kubernetes-gen.sh
sed -i 's/192\.168\.99\.103/192\.168\.56\.11/g' cert-kubernetes.sh
sed -i 's/192\.168\.99\.103/192\.168\.56\.11/g' kubeconfig-kubelet-gen.sh
sed -i 's/192\.168\.99\.103/192\.168\.56\.11/g' kubeconfig-kube-proxy-gen.sh

sed -i 's/ksn3/ksn1/g' cert-kube-apiserver-gen.sh
sed -i 's/ksn3/ksn1/g' cert-kubelet-gen.sh
sed -i 's/ksn3/ksn1/g' cert-kubernetes-gen.sh
sed -i 's/ksn3/ksn1/g' cert-kubernetes.sh
sed -i 's/ksn3/ksn1/g' kubeconfig-kubelet-gen.sh

export THIS_NAME=ksn1
export THIS_IP=192.168.99.101
export DATA_DIR="etcd-data"
export ETCD_IMAGE="k8s.gcr.io/etcd:3.4.13-0"
CLUSTER_STATE=new
CLUSTER="ksn1=https://192.168.99/101:2380"
TOKEN=arbitrary-token

docker run --rm \
--net=host \
-p 2379:2379 \
-p 2380:2380 \
--volume=${DATA_DIR}:/etcd-data \
--volume=/etc/kubernetes/pki:/etc/kubernetes/pki \
--name etcd ${ETCD_IMAGE} \
/usr/local/bin/etcd \
--data-dir=/etcd-data --name=${THIS_NAME} \
--initial-advertise-peer-urls https://${THIS_IP}:2380 \
--listen-peer-urls https://${THIS_IP}:2380 \
--advertise-client-urls https://${THIS_IP}:2379 \
--listen-client-urls https://${THIS_IP}:2379 \
--initial-cluster ${CLUSTER} \
--initial-cluster-state ${CLUSTER_STATE} \
--initial-cluster-token ${TOKEN} \
--cert-file=/etc/kubernetes/pki/etcd-ksn1.pem \
--key-file=/etc/kubernetes/pki/etcd-ksn1-key.pem \
--trusted-ca-file=/etc/kubernetes/pki/ca.pem \
--peer-cert-file=/etc/kubernetes/pki/etcd-peer-ksn1.pem \
--peer-key-file=/etc/kubernetes/pki/etcd-peer-ksn1-key.pem \
--peer-trusted-ca-file=/etc/kubernetes/pki/ca.pem 



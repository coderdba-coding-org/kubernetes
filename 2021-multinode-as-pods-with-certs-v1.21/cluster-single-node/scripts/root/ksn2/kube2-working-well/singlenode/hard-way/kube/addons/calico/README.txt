------------------------------------------------
CALICO
------------------------------------------------
Official doc: https://docs.projectcalico.org/getting-started/kubernetes/
      For self-managed clusters: https://docs.projectcalico.org/getting-started/kubernetes/self-managed-onprem/
      
Customize manifests: https://docs.projectcalico.org/getting-started/kubernetes/installation/config-options
Install: https://docs.projectcalico.org/getting-started/kubernetes/self-managed-onprem/onpremises

ETCD RBAC: https://docs.projectcalico.org/reference/etcd-rbac/kubernetes
Generating certificates: https://docs.projectcalico.org/reference/etcd-rbac/certificate-generation

Architecture diagram good one: https://tanzu.vmware.com/developer/guides/kubernetes/container-networking-calico-refarch/

~~~~~~~~~~~~~~~
NOTES
~~~~~~~~~~~~~~~
1. Modified image versions from 3.20.0 to 3.19.1 - as 3.19.1 images were already downloaded

~~~~~~~~~~~~~~~~~~~~~~~~~~~~
MANIFESTS - READ CAREFULLY
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
https://docs.projectcalico.org/getting-started/kubernetes/self-managed-onprem/onpremises

You can install Calico with its own data stored in different ways:

      Install options:
      Install Calico with Kubernetes API datastore, 50 nodes or less
             https://docs.projectcalico.org/manifests/calico.yaml

             
      Install Calico with Kubernetes API datastore, more than 50 nodes --> This installs something called Typha
            https://docs.projectcalico.org/manifests/calico-typha.yaml
            
      Install Calico with etcd datastore
            https://docs.projectcalico.org/manifests/calico-etcd.yaml 

If you use etcd with certifictes, then download calico-etcd.yaml and set up certificates in it 
      Reference: https://docs.projectcalico.org/getting-started/kubernetes/installation/config-options

To generate certs to talk to etcd:
      Use the (client) ones (not the etcd-peer ones)
      Or, the ones used by apiserver to connect to etcd in apiserver manifest
      - OR - generate client-certs - refer to https://docs.projectcalico.org/reference/etcd-rbac/certificate-generation
		--> Note: this site does not mention all hosts in etcd cluster in csr json - add all etcd hosts

~~~~~~~~~~~~~~~~~~~~~~
MANIFEST - CIDR
~~~~~~~~~~~~~~~~~~~~~~
https://docs.projectcalico.org/getting-started/kubernetes/self-managed-onprem/onpremises
(If you are using pod CIDR 192.168.0.0/16, skip to the next step)
If you are using a different pod CIDR with kubeadm, no changes are required - 
Calico will automatically detect the CIDR based on the running configuration. 
For other platforms, make sure you uncomment the CALICO_IPV4POOL_CIDR variable 
in the manifest and set it to the same value as your chosen pod CIDR.


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
MANIFEST CHANGS REQUIRED
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
etcd_endpoints	Comma-delimited list of etcd endpoints to connect to.	http://127.0.0.1:2379

Within the ConfigMap section, uncomment the etcd_ca, etcd_key, and etcd_cert lines so that they look as follows.

etcd_ca: "/calico-secrets/etcd-ca"
etcd_cert: "/calico-secrets/etcd-cert"
etcd_key: "/calico-secrets/etcd-key"

Using a command like the following to strip the newlines from the files and base64-encode their contents.

cat <file> | base64 -w 0

In the Secret named calico-etcd-secrets, uncomment etcd_ca, etcd_key, and etcd_cert and paste in the appropriate base64-encoded values.

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: calico-etcd-secrets
  namespace: kube-system

data:
  # Populate the following files with etcd TLS configuration if desired, but leave blank if
  # not using TLS for etcd.
  # This self-hosted install expects three files with the following names.  The values
  # should be base64 encoded strings of the entire contents of each file.
  etcd-key: LS0tLS1CRUdJTiB...VZBVEUgS0VZLS0tLS0=
  etcd-cert: LS0tLS1...ElGSUNBVEUtLS0tLQ==
  etcd-ca: LS0tLS1CRUdJTiBD...JRklDQVRFLS0tLS0=

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ERROR 1 - cert/key file not found
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
2021-08-20 06:50:53.863 [INFO][9] startup/startup.go 390: Early log level set to info
2021-08-20 06:50:53.863 [INFO][9] startup/startup.go 410: Using HOSTNAME environment (lowercase) for node name ksn2
2021-08-20 06:50:53.863 [INFO][9] startup/startup.go 418: Determined node name: ksn2
2021-08-20 06:50:53.863 [INFO][9] startup/startup.go 103: Starting node ksn2 with version v3.19.1
Calico node failed to start
ERROR: Error accessing the Calico datastore: could not initialize etcdv3 client: open /etc/kubernetes/pki/kubernetes.pem: no such file or directory

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ERROR 2 and 3  
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Fixed after following the document properly
Kubeconfig and Cert x509

[root@ksn2 manifests]# kubectl logs calico-kube-controllers-86475544f5-9q65x -n kube-system
2021-08-20 07:34:12.237 [INFO][1] main.go 92: Loaded configuration from environment config=&config.Config{LogLevel:"info", WorkloadEndpointWorkers:1, ProfileWorkers:1, PolicyWorkers:1, NodeWorkers:1, Kubeconfig:"", DatastoreType:"etcdv3"}
I0820 07:34:12.238156       1 client.go:360] parsed scheme: "endpoint"
I0820 07:34:12.238224       1 endpoint.go:68] ccResolverWrapper: sending new addresses to cc: [{https://192.168.99.102:2379  <nil> 0 <nil>}]

W0820 07:34:12.238406       1 client_config.go:615] Neither --kubeconfig nor --master was specified.  Using the inClusterConfig.  This might not work.

2021-08-20 07:34:12.267 [INFO][1] main.go 113: Ensuring Calico datastore is initialized
W0820 07:34:12.288334       1 clientconn.go:1223] grpc: addrConn.createTransport failed to connect to {https://192.168.99.102:2379  <nil> 0 <nil>}. Err :connection error: desc = "transport: authentication handshake failed: x509: certificate signed by unknown authority". Reconnecting...
W0820 07:34:13.296926       1 clientconn.go:1223] grpc: addrConn.createTransport failed to connect to {https://192.168.99.102:2379  <nil> 0 <nil>}. Err :connection error: desc = "transport: authentication handshake failed: x509: certificate signed by unknown authority". Reconnecting...
W0820 07:34:14.751778       1 clientconn.go:1223] grpc: addrConn.createTransport failed to connect to {https://192.168.99.102:2379  <nil> 0 <nil>}. Err :connection error: desc = "transport: authentication handshake failed: x509: certificate signed by unknown authority". Reconnecting...
W0820 07:34:16.928272       1 clientconn.go:1223] grpc: addrConn.createTransport failed to connect to {https://192.168.99.102:2379  <nil> 0 <nil>}. Err :connection error: desc = "transport: authentication handshake failed: x509: certificate signed by unknown authority". Reconnecting...


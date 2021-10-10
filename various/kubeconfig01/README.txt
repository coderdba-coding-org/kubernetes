===============
KUBECONFIG
===============
A utility: https://github.com/zlabjp/kubernetes-scripts/blob/master/create-kubeconfig

Main Reference: http://docs.shippable.com/deploy/tutorial/create-kubeconfig-for-self-hosted-kubernetes-cluster/

Create service account manifest sa.yaml
Apply it: kubectl apply -f sa.yaml

Describe the service account to get its token:
  kubectl describe serviceAccounts svcs-acct-dply > sa-svcs-acct-dply.describe
  It will have these two:
  Mountable secrets:   svcs-acct-dply-token-n5w2t
  Tokens:              svcs-acct-dply-token-n5w2t

Get the token secret:
  kubectl describe secrets svcs-acct-dply-token-n5w2t > svcs-acct-dply-token-n5w2t.describe

Get the cluster's certificate authority data:
  kubectl config view --flatten --minify > cluster-cert.txt
  In that output, "certificate-authority-data" will have the cert-authority data

Create the kubeconfig file
  Use the model file kubeconfig.sa-svcs-acct-dply.model
  Create a file kubeconfig.sa-svcs-acct-dply 
  Use the token from the token secret gotten earlier
  Use the certificate-authority-data from the cluster cert auth data gotten earlier
  Get the server, cluster and such from cert auth data gotten earlier
  Give a name and current-context appropriate to the service-account name created or purpose or both combined

Set the current context:
  kubectl config --kubeconfig=./sa-confa-svcs-acct-dply set-context sa-svcs-acct-dply

Try using the kubeconfig on the cluster:
NOTE: Getting error because the service-account did not have any privilege - or something else is wrong
  kubectl --kubeconfig=./kubeconfig.sa-svcs-acct-dply get pods
  error: You must be logged in to the server (Unauthorized)

====================================
RBAC ACCESS TO SA1 SERVICE ACCOUNT
====================================
------------------------------
CREATE ROLE AND CLUSTER-ROLE
------------------------------
Create role: rbac-role-pod-reader.yaml
Create cluster-role: rbac-clusterrole-secret-reader.yaml

------------------------------
BIND POD-READER ROLE
------------------------------
Bind role to service account: rbac-rolebinding-pod-reader.yaml
Verify: kubectl --kubeconfig=./sa1.kubeconfig  get pods -n default

--------------------------------------------------------
BIND SECRET-READER CLUSTER-ROLE AS JUST ROLEBINDING
--------------------------------------------------------
Bind cluster-role as just 'role' to service account: rbac-rolebinding-secret-reader.yaml
- Note: apiGroup should be just "" for ServiceAccounts
Verify: kubectl --kubeconfig=./sa1.kubeconfig  get secrets -n default

--------------------------------------------------------
BIND SECRET-READER CLUSTER-ROLE AS CLUSTER-ROLE-BINDING
--------------------------------------------------------
Bind cluster-role to service account: rbac-clusterrolebinding-secret-reader-global.yaml
- Note: for service-account we still need to mention namespace to bind to - because service accounts are namespace bound
        NOTE FURTHER: HOWEVER, CLUSTER-ROLE IS BOUND TO THE SERVICE-ACCOUNT FOR THE WHOLE CLUSTER
-       https://stackoverflow.com/questions/58876847/clusterrolebinding-requires-namespace
- Note: apiGroup should be just "" for ServiceAccounts

Verify: kubectl --kubeconfig=./sa1.kubeconfig  get secrets --all-namespaces
NOTE: Here, we are getting for "all namespaces" - because it is a ClusterRoleBinding

-----------------------------------------------------------
BIND CLUSTER-ADMIN INBUILT CLUSTERROLE TO SERVICE ACCOUNT
-----------------------------------------------------------
sa1-ClusterRoleBinding-cluster-admin-remove.sh
sa1-ClusterRoleBinding-cluster-admin.sh


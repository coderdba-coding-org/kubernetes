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


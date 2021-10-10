#kubectl create clusterrolebinding <binding-name> --clusterrole=cluster-admin --serviceaccount=kube-system:<service-account-name>

kubectl create clusterrolebinding sa1-clusterrolebinding-cluster-admin --clusterrole=cluster-admin --serviceaccount=default:sa1


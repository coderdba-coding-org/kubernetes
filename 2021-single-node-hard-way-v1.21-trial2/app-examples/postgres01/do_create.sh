echo
echo STARTING
echo

echo "creating persistent volume"
kubectl apply -f postgres-pv-local.yaml
sleep 5

echo "creating postgres sts"
kubectl apply -f postgres-sts.yaml
sleep 10

echo "creating service"
kubectl apply -f postgres-service.yaml

echo
echo DONE
echo

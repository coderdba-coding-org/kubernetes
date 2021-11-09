# Forward pod's 9090 port to localhost 9091 port
# Replace the prometheus pod name with the real one of your deployment

# sample
#kubectl port-forward prometheus-monitoring-3331088907-hm5n1 9091:9090 -n monitoring

kubectl port-forward prometheus-deployment-87cc8fb88-87ts2 9091:9090 -n monitoring

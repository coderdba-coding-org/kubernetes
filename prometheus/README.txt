========================
REFERENCES
========================
https://devopscube.com/setup-prometheus-monitoring-on-kubernetes/

========================
RUN SEQUENCE
========================
namespace.sh
clusterRole.sh
config-map.sh
prometheus-deployment.sh
prometheus-service.sh (if not using port forwarding with "port-forward.sh")
Place prometheus.example.com in /etc/hosts as "192.168.56.11   prometheus.example.com" --> with host's IP address
ingress.sh


==============================
ACCESS PROMETHEUS IN BROWSER
==============================
WITH INGRESS
http://prometheus.example.com

WITH NODEPORT SERVICE
http://localhost:30000 --> or other port used in nodeport service

WITH POD IP
http://ip-of-prometheus-server-pod:9090

========================
CONFIG MAP
========================
config-map.yml is from: https://raw.githubusercontent.com/bibinwilson/kubernetes-prometheus/master/config-map.yaml

========================
ABOUT SERVICE PORTS
========================
  type: NodePort  
  ports:
    - port: 8080 --> port of service
      targetPort: 9090 --> port of pod
      nodePort: 30000 --> node port on the host

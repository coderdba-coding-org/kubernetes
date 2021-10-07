apiVersion: apps/v1
kind: Deployment
metadata:
  name: postgres1
spec:
  replicas: 1
selector:
  matchLabels:
    app: postgres
template:
  metadata:
    labels:
      app: postgres
spec:
  containers:
  - name: postgres
    image: postgres:14.0
    imagePullPolicy: IfNotPresent
    ports:
    - containerPort: 5432
  volumes:
  - name: postgres-pv-storage
    persistentVolumeClaim:
      claimName: postgres-pv-claim-1
  volumeMounts:
  - mountPath: /var/lib/postgresql/data
    name: postgres-pv-storage
  env:
  - name: POSTGRES_PASSWORD
    valueFrom:
      secretKeyRef:
        name: postgres-secret-config
        key: password
  - name: PGDATA
    value: /var/lib/postgresql/data/pgdata

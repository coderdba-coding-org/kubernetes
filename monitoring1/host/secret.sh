# name of the secret: telegraf
# monitor_host is the influx database host
# monitor_database is the influx database name
# monitor_username is influx username, and monitor_password is its password

#kubectl create secret -n monitoring generic telegraf --from-literal=env=prod --from-literal=monitor_username=youruser --from-literal=monitor_password=yourpassword --from-literal=monitor_host=https://your.influxdb.local --from-literal=monitor_database=yourdb

kubectl create secret -n monitoring generic telegraf --from-literal=env=prod --from-literal=monitor_username=admin --from-literal=monitor_password=admin123 --from-literal=monitor_host=http://192.168.56.41:8086 --from-literal=monitor_database=metrics

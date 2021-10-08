kubectl create secret -n default generic telegraf \
--from-literal=env=acc \
--from-literal=monitor_retention_policy="threedays" \
--from-literal=monitor_username="admin" \
--from-literal=monitor_password="admin123" \
--from-literal=monitor_host=http://192.168.56.41:8086 \
--from-literal=monitor_database=metrics

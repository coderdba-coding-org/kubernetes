# without etcd
#docker ps -a |grep -v etcd |grep -v CONTAIN | awk '{print "docker stop " $1}' > x
#docker ps -a |grep -v etcd |grep -v CONTAIN | awk '{print "docker rm " $1}' > y

# with etcd
docker ps -a |grep -v CONTAIN | awk '{print "docker stop " $1}' > x
docker ps -a |grep -v CONTAIN | awk '{print "docker rm " $1}' > y

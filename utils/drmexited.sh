#docker ps --filter "status=exited" | grep 'weeks ago' | awk '{print $1}' | xargs --no-run-if-empty docker rm
docker ps --filter "status=exited" | awk '{print $1}' | xargs --no-run-if-empty docker rm

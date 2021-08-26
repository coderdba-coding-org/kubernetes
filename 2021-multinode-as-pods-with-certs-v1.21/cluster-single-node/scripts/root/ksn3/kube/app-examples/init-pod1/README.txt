Reference: https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-initialization/

curl -O https://raw.githubusercontent.com/kubernetes/website/main/content/en/examples/pods/init-containers.yaml

wget -O work-dir/index.html http://info.cern.ch

kubectl apply -f init-containers.yaml -n default --kubeconfig=/root/.kube/admin.kubeconfig

VERIFY:

# kubectl exec -it init-demo -- /bin/bash
Defaulted container "nginx" out of: nginx, install (init)

root@init-demo:/# apt-get install curl
Reading package lists... Done
Building dependency tree       
Reading state information... Done
curl is already the newest version (7.64.0-4+deb10u2).
0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.

root@init-demo:/# curl localhost
<html><head></head><body><header>
<title>http://info.cern.ch</title>
</header>

<h1>http://info.cern.ch - home of the first website</h1>
<p>From here you can:</p>
<ul>
<li><a href="http://info.cern.ch/hypertext/WWW/TheProject.html">Browse the first website</a></li>
<li><a href="http://line-mode.cern.ch/www/hypertext/WWW/TheProject.html">Browse the first website using the line-mode browser simulator</a></li>
<li><a href="http://home.web.cern.ch/topics/birth-web">Learn about the birth of the web</a></li>
<li><a href="http://home.web.cern.ch/about">Learn about CERN, the physics laboratory where the web was born</a></li>
</ul>
</body></html>


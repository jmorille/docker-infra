Kibana
======
##
To set this value permanently, update the *vm.max_map_count* setting in */etc/sysctl.conf*

```
sysctl -w vm.max_map_count=262144
```


## Build
```
docker build --rm -t jmorille/elastticsearch -f Dockerfile-elasticsearch .
docker build --rm -t jmorille/kibana -f Dockerfile-kibana .
```

```
docker build --build-arg http_proxy=$http_proxy  --build-arg https_proxy=$https_proxy  --rm -t jmorille/elastticsearch -f Dockerfile-elasticsearch .
docker build --build-arg http_proxy=$http_proxy  --build-arg https_proxy=$https_proxy  --rm -t jmorille/kibana -f Dockerfile-kibana . 
```


## Run

```
docker run --rm -it jmorille/kibana /bin/bash
```


```
docker run --rm -it --net=host jmorille/kibana /bin/bash
```

## Install X-pack licence
```
curl -XPUT -u elastic 'http://127.0.0.1:9200/_xpack/license?acknowledge=true' -d @license.json
```

TODO https://www.elastic.co/guide/en/x-pack/current/installing-xpack.html
TODO https://www.elastic.co/guide/en/x-pack/current/ssl-tls.html

xpack.security.enabled=false
xpack.graph.enabled=false
xpack.watcher.enabled=false
xpack.reporting.enabled=false
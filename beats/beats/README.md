

## Build
```
docker build --rm -t jmorille/beat .
```

```
docker build --build-arg http_proxy=$http_proxy  --build-arg https_proxy=$https_proxy --rm -t jmorille/beat .
```

## Kibana Load Template


```
docker run -it jmorille/beat curl -XPUT 'http://localhost:9200/_template/filebeat' -d@/opt/filebeat/filebeat.template.json
```


## Run  
```
docker run -it jmorille/beat /bin/bash
```

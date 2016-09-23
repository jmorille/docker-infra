

## Build
```
docker build --rm -t jmorille/filebeat .
```

## filebeat
```
# Import Template
docker run --rm  -it --net=host jmorille/beat curl -XPUT 'http://thor:9200/_template/filebeat' -d@/opt/filebeat/filebeat.template.json
# Import Kibana Dashboard
docker run --rm  -it --net=host jmorille/beat  /opt/filebeat/scripts/import_dashboards -es http://127.0.0.1:9200
```


## Run  
```
docker run --rm -it --net=host jmorille/filebeat /bin/bash
```

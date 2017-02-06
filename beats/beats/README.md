

## Build
```
docker build --rm -t jmorille/beat .
```

```
docker build --build-arg http_proxy=$http_proxy  --build-arg https_proxy=$https_proxy --rm -t jmorille/beat .
```

## Kibana Load Template

#### filebeat
```
# Import Template
docker run --rm  -it --net=host jmorille/beat curl -XPUT 'http://localhost:9200/_template/filebeat' -d@/opt/filebeat/filebeat.template.json
# Import Kibana Dashboard
docker run --rm  -it --net=host  -e https_proxy=$https_proxy jmorille/beat  /opt/filebeat/scripts/import_dashboards -es http://127.0.0.1:9200
```



#### metricbeat
```
docker run --rm -it --net=host jmorille/beat curl -XPUT 'http://localhost:9200/_template/metricbeat' -d@/opt/metricbeat/metricbeat.template.json
# Import Kibana Dashboard
docker run --rm  -it  -e https_proxy=$https_proxy --net=host jmorille/beat  /opt/metricbeat/scripts/import_dashboards -es http://127.0.0.1:9200
```

#### packetbeat
```
docker run --rm  -it --net=host jmorille/beat curl -XPUT 'http://localhost:9200/_template/packetbeat' -d@/opt/packetbeat/packetbeat.template.json
# Import Kibana Dashboard
docker run --rm  -it  -e https_proxy=$https_proxy --net=host jmorille/beat  /opt/packetbeat/scripts/import_dashboards -es http://127.0.0.1:9200
```

## Index managements

### List All indexes
```
curl 'localhost:9200/_cat/indices?v'
```

### Delete Indexes
```
curl -XDELETE localhost:9200/metricbeat-2016.11.17
```



## Run  
```
docker run --rm -it --net=host jmorille/beat /bin/bash
```



## Build
```
docker build --rm -t jmorille/logstash .
```

```
docker build --build-arg http_proxy=$http_proxy --rm -t jmorille/logstash .
```

## Run  
```
docker run -it jmorille/logstash /bin/bash
```



## TODO
sed "s,xxx,${ELASTICSEARCH_HOST},g" logstash.conf.tpl > logstash.conf

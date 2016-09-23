

## Build
```
docker build --rm -t jmorille/elasticsearch .
```
 

## Run  
```
docker run -it jmorille/elasticsearch /bin/bash
```


# Config
* https://www.elastic.co/guide/en/elasticsearch/guide/current/heap-sizing.html

Before run elasticsearch on host

```
sudo sysctl -w vm.max_map_count=262144
````
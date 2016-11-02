Kibana
======

## Build
```
docker build --rm -t jmorille/kibana .
```

```
docker build --build-arg http_proxy=$http_proxy  --build-arg https_proxy=$https_proxy --rm -t jmorille/kibana .
```


## Run

```
docker run --rm -it jmorille/kibana /bin/bash
```


```
docker run --rm -it --net=host jmorille/kibana /bin/bash
```

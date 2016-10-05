hhvm-php-compiler
====================

## Build
```
 docker build --rm -t jmorille/hhvm .
```

With proxy
```
docker build --build-arg http_proxy=$http_proxy --rm -t jmorille/hhvm .
```

## Run
```
docker run --rm -it -v $(pwd)/test:/data/php -v $(pwd)/hhvm:/data/hhvm -p 8080:8080 -p 9000:9000 jmorille/hhvm /bin/bash
```


## Compilation
```
docker run -it --rm -v $(pwd)/php:/data/php jmorille/hhvm  
```
 
 
## Configure Nginx
https://docs.hhvm.com/hhvm/advanced-usage/fastCGI


### RHEL 7
https://github.com/facebook/hhvm/wiki/building-and-installing-hhvm-on-rhel-7


### Doc

https://docs.hhvm.com/hhvm/installation/linux#debian-8-jessie

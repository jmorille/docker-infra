 
==> TODO follow  : https://weakdh.org/sysadmin.html


# Docker
## Build Images
```
docker build --rm -t jmorille/php7-fpm .
docker build --build-arg http_proxy=$http_proxy  --build-arg https_proxy=$https_proxy  --rm -t jmorille/php7-fpm .
```

```
docker tag jmorille/nginx thor:5000/nginx:latest
docker push thor:5000/nginx
```


## View Images
```
docker run -ti jmorille/nginx /bin/bash
```

## Host configuration

```
 sudo  groupadd  -g 48  apache
 sudo  useradd -u 48 -g48  apache
```
 
## Some generator
 https://phpdocker.io/generator
 
## Linking container

https://docs.docker.com/engine/userguide/networking/work-with-networks/#linking-containers-in-user-defined-networks
https://www.guillaume-leduc.fr/une-autre-facon-dutiliser-php-fpm.html


https://www.if-not-true-then-false.com/2011/nginx-and-php-fpm-configuration-and-optimizing-tips-and-tricks/

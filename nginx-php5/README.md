 
# Docker

https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mysql-php-lemp-stack-on-debian-7

## Build Images
```
docker build --rm -t jmorille/nginx-php5 .
```

## View Images
```
docker run -ti jmorille/nginx-php5 /bin/bash
```


## Run Images
```
docker rm  cert
docker create -v /data/cert --name cert jmorille/cert /bin/true

docker run -ti -p 80:80 -p 443:443 \
   --volumes-from cert \
   jmorille/nginx-php5

docker run -ti -p 80:80 -p 443:443 \
   -v $(pwd)/build/html:/data/html \
   jmorille/nginx-php5
```


```
docker run -ti -p 80:80 -p 443:443 \
  -v /home/a000cqp/project/ttstore-admin/back:/data/wwww \
  -v /data2/ttsore-ngnix/logs:/etc/nginx/logs \
   jmorille/nginx
```

# Sample
* https://github.com/eugeneware/docker-wordpress-nginx/blob/master/supervisord.conf
* https://github.com/ngineered/nginx-php-fpm/blob/master/Dockerfile

# Multi process
http://stackoverflow.com/questions/23692470/why-cant-i-use-docker-cmd-multiple-times-to-run-multiple-services

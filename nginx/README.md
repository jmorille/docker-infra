# Generate Self Signed Certificate
```
./build/install.sh tlscertif password
```

==> TODO follow  : https://weakdh.org/sysadmin.html

# Docker
## Build Images
```
docker build --rm -t jmorille/nginx .
```

```
docker tag jmorille/nginx thor:5000/nginx:latest
docker push thor:5000/nginx
```


## View Images
```
docker run -ti jmorille/nginx /bin/bash
```


## Run Images
```
docker rm  cert
docker create -v /data/cert --name cert jmorille/cert /bin/true

docker run -ti -p 80:80 -p 443:443 \
   --volumes-from cert \
   jmorille/nginx
```


```
docker run -ti -p 80:80 -p 443:443 \
  -v /home/a000cqp/project/ttstore-admin/back:/data/wwww \
  -v /data2/ttsore-ngnix/logs:/etc/nginx/logs \
   jmorille/nginx
```


== Source
https://github.com/dod91/docker_nginx_spdy

TODO https://gist.github.com/plentz/6737338


# Security Guide
http://www.nginxtips.com/nginx-security-guide/


# Other
```
     location /esd/ {
        rewrite  ^/esd/(.*)  /$1 break;

        proxy_pass http://lb-es; # Load balance the URL location "/" to the upstream lb-subprint
        proxy_http_version 1.1;

        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;

        # proxy_read_timeout 600s;
        # proxy_buffering off;
     }
     location /head {
        proxy_pass http://lb-es/_plugin/head; # Load balance the URL location "/" to the upstream lb-subprint
        proxy_http_version 1.1;

        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
     }
```


# Quic reverse proxy
https://hub.docker.com/r/devsisters/quic-reverse-proxy/

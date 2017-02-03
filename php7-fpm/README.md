 
==> TODO follow  : https://weakdh.org/sysadmin.html

# Docker
## Build Images
```
docker build --rm -t jmorille/php7-fpm .
```

```
docker tag jmorille/nginx thor:5000/nginx:latest
docker push thor:5000/nginx
```


## View Images
```
docker run -ti jmorille/nginx /bin/bash
```
 
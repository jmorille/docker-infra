Auto Generate Certificate
===

https://certbot.eff.org/#debianwheezy-nginx


## Build Docker
```
docker build --rm -t jmorille/certbot .
```

## View Images
```
docker run -ti --rm -p 443:443 -p 80:80  --name certbot \
   -v "$(pwd)/etc/letsencrypt:/etc/letsencrypt" \
   -v "$(pwd)/var/lib/letsencrypt:/var/lib/letsencrypt" \
jmorille/certbot /bin/bash
```

```
docker run -ti --rm -p 443:443 -p 80:80  --name certbot \
   -v "$(pwd)/etc/letsencrypt:/etc/letsencrypt" \
   -v "$(pwd)/var/lib/letsencrypt:/var/lib/letsencrypt" \
jmorille/certbot ./certbot-auto --standalone  -d example.com --agree-tos --email user@example.com
```
## For Use
==> TODO follow  : https://weakdh.org/sysadmin.html

 

 

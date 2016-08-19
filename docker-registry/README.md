Docker Registry
===============


# Documentation

## Docker registry
https://docs.docker.com/registry/deploying/

## Docker UI
https://hub.docker.com/r/konradkleine/docker-registry-frontend/


# Generate Configuration

## Native auth
```
$ mkdir -p auth
$ docker run --entrypoint htpasswd registry:2 -Bbn admin admin > auth/htpasswd
```

## Tls 
``` 
$ ../cert/genCert.sh -d THOR autoSignCert 
```
  

# Run Docker registry
```
$ docker-compose up
```

## Docker Registry HTTP API V2
https://docs.docker.com/registry/spec/api/#/detail
* https://thor:5000/v2/_catalog

## Health Check
* https://thor:5000/v2/

```
$ curl -k https://admin:admin@thor/v2/
```

## Docker login
Copying the domain.crt file to /etc/docker/certs.d/myregistrydomain.com:5000/ca.crt ( https://docs.docker.com/registry/insecure/ )
https://github.com/docker/machine/issues/1872
```
$ docker login https://thor
```

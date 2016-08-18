Docker Registry
===

# Documentation

## Docker registry
https://docs.docker.com/registry/deploying/

## Docker UI
https://hub.docker.com/r/konradkleine/docker-registry-frontend/


# Generate Configuration


## Native auth
```
$ mkdir auth
$ docker run --entrypoint htpasswd registry:2 -Bbn admin admin > auth/htpasswd
```


## Tls 

```
$ mkdir certs
$ ../cert/genCert.sh -d THOR -f thor autoSignCert 
```
  

# Run Docker registry

```
$ docker-compose up
```

# Test API
https://thor:5000/v2/

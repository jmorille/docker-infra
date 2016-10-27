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
### Using certificates for repository client verification
 Source : 
* https://docs.docker.com/engine/security/certificates/
* https://docs.docker.com/registry/insecure/

The following illustrates a configuration with multiple certs:
```
  /etc/docker/certs.d/        <-- Certificate directory
    └── thor:5000               <-- Hostname
       ├── client.cert          <-- Client certificate
       ├── client.key           <-- Client key
       └── localhost.crt        <-- Certificate authority that signed
                                    the registry certificate
```

Copying the domain.crt file to /etc/docker/certs.d/myregistrydomain.com:5000/ca.crt ( https://docs.docker.com/registry/insecure/ )
https://github.com/docker/machine/issues/1872
```
$ docker login thor:5000
```


# Docker Daemon for use proxy
You will need to pass the --registry-mirror option to your Docker daemon on startup:
```
docker --registry-mirror=https://<my-docker-mirror-host> daemon
```


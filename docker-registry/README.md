Docker Registry
===

# Documentation
https://docs.docker.com/registry/deploying/

## Tls
```
mkdir -p certs
```
Then move and/or rename your crt file to: certs/domain.crt, and your key file to: certs/domain.key.

A certificate issuer may supply you with an intermediate certificate.
In this case, you must combine your certificate with the intermediate’s to form a certificate bundle.
You can do this using the cat command:
```
cat domain.crt intermediate-certificates.pem > certs/domain.crt
```


## Native auth
```
mkdir auth
docker run --entrypoint htpasswd registry:2 -Bbn testuser testpassword > auth/htpasswd
```

Auto Generate Certificate
===

* https://jamielinux.com/docs/openssl-certificate-authority/
* https://www.feistyduck.com/library/openssl-cookbook/online/ch-openssl.html

## Generate Self Signed Certificate
./build/genCert.sh setup

## Build Docker
docker build --rm -t jmorille/cert .


## View Images
docker run -ti jmorille/cert ls /data/cert

## For Use
==> TODO follow  : https://weakdh.org/sysadmin.html

 
##  Concaténer les fichiers de certificat
Respecter l'ordre suivant
```
-----BEGIN RSA PRIVATE KEY----- 
(Your Private Key: server.key) 
-----END RSA PRIVATE KEY----- 
-----BEGIN CERTIFICATE----- 
(Your Primary SSL certificate: server.crt) 
-----END CERTIFICATE----- 
-----BEGIN CERTIFICATE----- 
(Your Intermediate certificate: DigiCertCA.crt) 
-----END CERTIFICATE----- 
-----BEGIN CERTIFICATE----- 
(Your Root certificate: TrustedRoot.crt) 
-----END CERTIFICATE-----
```


# Install the CA on the client
```
cp certs/ca.crt /usr/local/share/ca-certificates/thor.crt
update-ca-certificates
```

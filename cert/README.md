Auto Generate Certificate
===

## Generate Self Signed Certificate
./build/genCert.sh setup

## Build Docker
docker build --rm -t jmorille/cert .


## View Images
docker run -ti jmorille/cert ls /data/cert

## For Use
==> TODO follow  : https://weakdh.org/sysadmin.html

 
 

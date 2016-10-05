hhvm-php-compiler
====================

## Build
```
docker build --rm -t jmorille/hhvm .
```

```
docker build --build-arg http_proxy=$http_proxy --rm -t jmorille/hhvm .
```

## Compilation
```
docker run -it --rm -v $(pwd)/php:/data/php jmorille/hhvm  
```

### RHEL 7
https://github.com/facebook/hhvm/wiki/building-and-installing-hhvm-on-rhel-7


### Doc

https://docs.hhvm.com/hhvm/installation/linux#debian-8-jessie

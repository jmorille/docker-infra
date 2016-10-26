docker-infra
============
# Install Docker compose 
```
sudo  pip install docker-compose
```


# Docker command
## Delete all containers
```
$ docker stop $(docker ps -q)
$ docker rm -v $(docker ps -a -q)
$ docker rm -v -f $(docker ps -a -q)
```

## Delete all untagged images
```
$ docker rmi $(docker images | grep "^<none>" | awk '{print $3}')
```

## Start docker-compose
```
$ docker-compose up -d IMAGES
```

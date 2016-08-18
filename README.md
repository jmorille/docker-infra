# docker-infra

# Delete all containers
```
$ docker stop $(docker ps -q)
$ docker rm -v $(docker ps -a -q)
$ docker rm -v -f $(docker ps -a -q)
```

## Delete all untagged images
```
$ docker rmi $(docker images | grep "^<none>" | awk ‘{print $3}’)
```


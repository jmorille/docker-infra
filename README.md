# docker-infra

# Delete all containers
```
docker rm $(docker ps -a -q)
```

## Delete all untagged images
```
docker rmi $(docker images | grep "^<none>" | awk ‘{print $3}’)
```


#!/bin/bash

#DOCKER_REGISTRY_URL=127.0.0.1:5000
#DOCKER_REGISTRY_URL=docker-registry:5000
DOCKER_REGISTRY_URL=thor:5000
PROJECT_NAMESPACE=jmorille
PROJECT_VERSION=0.0.1

function dockerBuild {
      echo ""
      echo "### #################################################### ###"
      echo "### Building docker images : $1"
      echo "### #################################################### ###"
      docker build --rm -t $PROJECT_NAMESPACE/$1 $1/. || exit 1
      echo ""
}


function dockerTagAndPush {
      echo ""
      echo "### #################################################### ###"
      echo "### Tag docker images : $1 to Version $PROJECT_VERSION"
      echo "### #################################################### ###"
      docker tag $PROJECT_NAMESPACE/$1 $DOCKER_REGISTRY_URL/$1:$PROJECT_VERSION
      docker tag $PROJECT_NAMESPACE/$1 $DOCKER_REGISTRY_URL/$1:latest
      docker push $DOCKER_REGISTRY_URL/$1
      echo ""
}



function buildDockerImages { 
    for v
    in  nginx nginx-php5
    do
      dockerBuild $v  || exit 1
    done
}

function tagDockerImages { 
    for v
    in  nginx nginx-php5
    do
      dockerTagAndPush $v  || exit 1
    done
}

function buildAndTagDockerImages {
  buildDockerImages || exit 1
  tagDockerImages || exit 1
}


buildAndTagDockerImages < /dev/tty

#!/bin/bash

if [[ -z "$1" ]]; then
    VERSION=develop
else
    VERSION=$1
fi

docker build --rm --build-arg BRANCH=$VERSION -t foxi352/smarthome:$VERSION --file Dockerfile.smarthome .

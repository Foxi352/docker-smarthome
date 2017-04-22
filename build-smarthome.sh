#!/bin/bash

if [[ -z "$1" ]]; then
    VERSION=1.3
else
    VERSION=$1
fi

docker build --rm --build-arg BRANCH=release-$VERSION -t foxi352/smarthome:$VERSION -t foxi352/smarthome:latest --file Dockerfile.smarthome .

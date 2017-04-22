#!/bin/bash

if [[ -z "$1" ]]; then
    VERSION=1.2
else
    VERSION=$1
fi

docker build --rm --build-arg BRANCH=v$VERSION -t foxi352/smarthome:$VERSION --file Dockerfile.smarthome .

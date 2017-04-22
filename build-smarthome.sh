#!/bin/bash

if [[ -z "$1" ]]; then
    VERSION=master
else
    VERSION=$1
fi

docker build --rm --build-arg BRANCH=master -t foxi352/smarthome:latest --file Dockerfile.smarthome .

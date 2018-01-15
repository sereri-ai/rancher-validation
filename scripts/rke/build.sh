#!/bin/bash

set -x
set -eu

DEBUG="${DEBUG:-}"
RKE_VERSION="${RKE_VERSION:v0.0.8-dev}"

if [ "false" != "${DEBUG}" ]; then
    echo "Environment:"
    env | sort
fi

cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )/../../" && pwd )"

count=0
while [[ 3 -gt $count ]]; do
    docker build --rm --build-arg RKE_VERSION=$RKE_VERSION  -f Dockerfile_rke -t rancher-validation-tests .
    if [[ $? -eq 0 ]]; then break; fi
    count=$(($count + 1))
    echo "Repeating failed Docker build ${count} of 3..."
done
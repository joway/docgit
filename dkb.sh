#!/usr/bin/env bash
if [[ -n "${DOCKER_REGISTRY}" ]]; then
  DOCKER_REGISTRY=$DOCKER_REGISTRY/
else
  DOCKER_REGISTRY=''
fi

DOCKER_REPO=${DOCKER_REPO:-'joway'}

ORIGIN_NAME=$(basename `git rev-parse --show-toplevel`)
IMAGE_NAME=$(echo $ORIGIN_NAME | awk '{print tolower($0)}')
BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)
GIT_COMMIT=$(git rev-parse --short HEAD)

IMAGE_FULL_URL=$DOCKER_REGISTRY$DOCKER_REPO/$IMAGE_NAME:$BRANCH_NAME-$GIT_COMMIT
echo "docker building : ${IMAGE_FULL_URL}"
docker build . -t $IMAGE_FULL_URL
echo "docker build finished : ${IMAGE_FULL_URL}"

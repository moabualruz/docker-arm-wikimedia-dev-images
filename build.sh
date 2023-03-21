#!/bin/bash
export DOCKER_BUILDKIT=0
export COMPOSE_DOCKER_CLI_BUILD=0
REGISTRY=docker-registry.wikimedia.org
DISTRO=bullseye
dateToday=$(date -u +%Y%m%d)
img="${REGISTRY}/${DISTRO}"
imgFull="${img}:${dateToday}"
imgTag="${REGISTRY}/wikimedia-${DISTRO}"
apache2Img="${REGISTRY}/dev/bullseye-apache2"
apache2Tag="1.0.0-arm1"
phpImg="${REGISTRY}/dev/bullseye-php81"
phpTag="1.0.0"
phpFpmImg="${REGISTRY}/dev/bullseye-php81-fpm"
phpFpmTag="2.0.0-arm1"
phpJobRunnerImg="${REGISTRY}/dev/bullseye-php81-jobrunner"
phpJobRunnerTag="1.0.0-arm1"
## Remove old images
docker rmi "${imgFull}"
docker rmi "${img}:latest"
docker rmi "${imgTag}:latest"
docker rmi "${apache2Img}:${apache2Tag}"
docker rmi "${phpImg}:${phpTag}"
docker rmi "${phpFpmImg}:${phpFpmTag}"
docker rmi "${phpJobRunnerImg}:${phpJobRunnerTag}"
## Building Core bullseye image
echo "Building Core bullseye image ${imgFull}"
docker build . -f bullseye/Dockerfile -t "${imgFull}"
## Tagging Core bullseye image
echo "Tagging Core bullseye image ${img}:latest and ${imgTag}:latest"
docker tag "${imgFull}" "${img}:latest"
docker tag "${imgFull}" "${imgTag}:latest"
## Building Apache2 bullseye image
echo "Building Apache2 bullseye image ${apache2Img}:${apache2Tag}"
docker build . -f apache2/Dockerfile -t "${apache2Img}:${apache2Tag}"
## Building php8.1 bullseye image
echo "Building php8.1 bullseye image ${phpImg}:${phpTag}"
docker build . -f php81/Dockerfile -t "${phpImg}:${phpTag}"
## Building php8.1 FPM bullseye image
echo "Building php8.1 FPM bullseye image ${phpFpmImg}:${phpFpmTag}"
docker build . -f fpm/Dockerfile -t "${phpFpmImg}:${phpFpmTag}"
## Building php8.1 Job Runner bullseye image
echo "Building php8.1 Job Runner bullseye image ${phpJobRunnerImg}:${phpJobRunnerTag}"
docker build . -f jobrunner/Dockerfile -t "${phpJobRunnerImg}:${phpJobRunnerTag}"

## Remove unused images
docker rmi "${imgFull}"
docker rmi "${img}:latest"
docker rmi "${imgTag}:latest"
docker rmi "${phpImg}:${phpTag}"

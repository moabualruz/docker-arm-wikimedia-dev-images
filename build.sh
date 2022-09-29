#!/bin/bash
REGISTRY=docker-registry.wikimedia.org
DISTRO=buster
dateToday=$(date -u +%Y%m%d)
img="${REGISTRY}/${DISTRO}"
imgFull="${img}:${dateToday}"
imgTag="${REGISTRY}/wikimedia-${DISTRO}"
apache2Img="${REGISTRY}/dev/buster-apache2"
apache2Tag="1.0.0-arm1"
phpImg="${REGISTRY}/dev/buster-php74"
phpTag="1.0.0"
phpFpmImg="${REGISTRY}/dev/buster-php74-fpm"
phpFpmTag="2.0.0-arm1"
phpJobRunnerImg="${REGISTRY}/dev/buster-php74-jobrunner"
phpJobRunnerTag="1.0.0-arm1"
## Remove old images
docker rmi "${imgFull}"
docker rmi "${img}:latest"
docker rmi "${imgTag}:latest"
docker rmi "${apache2Img}:${apache2Tag}"
docker rmi "${phpImg}:${phpTag}"
docker rmi "${phpFpmImg}:${phpFpmTag}"
docker rmi "${phpJobRunnerImg}:${phpJobRunnerTag}"
## Building Core Buster image
echo "Building Core Buster image"
docker build --no-cache . -f buster/Dockerfile -t "${imgFull}"
## Tagging Core Buster image
echo "Tagging Core Buster image"
docker tag "${imgFull}" "${img}:latest"
docker tag "${imgFull}" "${imgTag}:latest"
## Building Apache2 Buster image
echo "Building Apache2 Buster image"
docker build --no-cache . -f apache2/Dockerfile -t "${apache2Img}:${apache2Tag}"
## Building php7.4 Buster image
echo "Building php7.4 Buster image"
docker build --no-cache . -f php74/Dockerfile -t "${phpImg}:${phpTag}"
## Building php7.4 FPM Buster image
echo "Building php7.4 FPM Buster image"
docker build --no-cache . -f fpm/Dockerfile -t "${phpFpmImg}:${phpFpmTag}"
## Building php7.4 Job Runner Buster image
echo "Building php7.4 Job Runner Buster image"
docker build --no-cache . -f jobrunner/Dockerfile -t "${phpJobRunnerImg}:${phpJobRunnerTag}"

## Remove unused images
docker rmi "${imgFull}"
docker rmi "${img}:latest"
docker rmi "${imgTag}:latest"
docker rmi "${phpImg}:${phpTag}"

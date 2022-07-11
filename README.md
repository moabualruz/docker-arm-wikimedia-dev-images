# Wikimedia dev debian images with Dockerfiles

- Run the following to create local images

```bash
./build.sh
```

- Create `docker-compose.override.yml` file in your core project and put the following in:
```yaml
version: '3.7'
services:
  mediawiki:
    image: docker-registry.wikimedia.org/dev/buster-php72-fpm:2.0.0-arm1
  mediawiki-web:
    image: docker-registry.wikimedia.org/dev/buster-apache2:1.0.0-arm1
  mediawiki-jobrunner:
    image: docker-registry.wikimedia.org/dev/buster-php72-jobrunner:1.0.0-arm1
```
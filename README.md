# Wikimedia dev debian images with Dockerfiles
This tool and script helps to create arm/(Mac M1 compatible) images for the developer environment on the Wikimedia framework. Which helps with performance and debugging on arm machines.
 
## How to use Arm Docker images in your project

- Run the following to create local images

    ```bash
    ./build.sh
    ```

- Create `docker-compose.override.yml` file in your core project and put the following in:
    ```yaml
    version: '3.7'
    services:
      mediawiki:
        image: docker-registry.wikimedia.org/dev/buster-php74-fpm:2.0.0-arm1
      mediawiki-web:
        image: docker-registry.wikimedia.org/dev/buster-apache2:1.0.0-arm1
      mediawiki-jobrunner:
        image: docker-registry.wikimedia.org/dev/buster-php74-jobrunner:1.0.0-arm1
    ```

- Shutdown the current containers:
  ```sh
  docker-compose down
  ```

- Start the containers:
  ```sh
  docker-compose up -d
  ```

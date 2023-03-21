FROM debian:bullseye

COPY ../files/mediawiki-bullseye/docker/ /docker/
RUN ls -l /docker/
COPY ../files/mediawiki-bullseye/php_entrypoint.sh /php_entrypoint.sh

RUN echo 'APT::Install-Recommends "false";' > /etc/apt/apt.conf.d/00InstallRecommends

RUN apt-get update && apt-get install -yq --no-install-recommends dialog apt-utils

RUN apt-get dist-upgrade -yq

ENV LC_ALL=C.UTF-8

CMD ["/bin/bash"]

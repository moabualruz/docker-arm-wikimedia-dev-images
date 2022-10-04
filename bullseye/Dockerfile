FROM debian:bullseye

COPY ../files/mediawiki-bullseye/sources.list /etc/apt/sources.list
COPY ../files/mediawiki-bullseye/wikimedia.pub.gpg /etc/apt/trusted.gpg.d/wikimedia-bullseye.pub.gpg
COPY ../files/mediawiki-bullseye/wikimedia /etc/apt/preferences.d/wikimedia
COPY ../files/mediawiki-bullseye/docker/ /docker/
RUN ls -l /docker/
COPY ../files/mediawiki-bullseye/php_entrypoint.sh /php_entrypoint.sh

RUN echo 'APT::Install-Recommends "false";' > /etc/apt/apt.conf.d/00InstallRecommends

RUN apt-get update && apt-get dist-upgrade -yq

ENV LC_ALL=C.UTF-8

CMD ["/bin/bash"]

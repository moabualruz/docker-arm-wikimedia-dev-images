FROM debian:buster

COPY ../files/mediawiki-buster/sources.list /etc/apt/sources.list
COPY ../files/mediawiki-buster/wikimedia.pub.gpg /etc/apt/trusted.gpg.d/wikimedia-buster.pub.gpg
COPY ../files/mediawiki-buster/wikimedia /etc/apt/preferences.d/wikimedia
COPY ../files/mediawiki-buster/docker/ /docker/
RUN ls -l /docker/
COPY ../files/mediawiki-buster/php_entrypoint.sh /php_entrypoint.sh

RUN echo 'APT::Install-Recommends "false";' > /etc/apt/apt.conf.d/00InstallRecommends

RUN apt-get update && apt-get dist-upgrade -yq

ENV LC_ALL=C.UTF-8

CMD ["/bin/bash"]

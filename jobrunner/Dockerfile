FROM docker-registry.wikimedia.org/dev/bullseye-php74:1.0.0

RUN echo "deb http://apt.wikimedia.org/wikimedia bullseye-wikimedia component/vp9" > /etc/apt/sources.list.d/bullseye-vp9.list

RUN apt update && apt install -yq ffmpeg

# MediaWiki default settings
COPY ../files/mediawiki-jobrunner/docker/PlatformSettings.php /docker/PlatformSettings.php

WORKDIR "/var/www/html/w"

COPY ../files/mediawiki-jobrunner/entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]

FROM docker-registry.wikimedia.org/dev/buster-php72:1.0.0

RUN echo "deb http://apt.wikimedia.org/wikimedia buster-wikimedia component/vp9" > /etc/apt/sources.list.d/buster-vp9.list

RUN apt update && apt install -yq ffmpeg

# MediaWiki default settings
COPY ../files/mediawiki-jobrunner/docker/PlatformSettings.php /docker/PlatformSettings.php

WORKDIR "/var/www/html/w"

COPY ../files/mediawiki-jobrunner/entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]

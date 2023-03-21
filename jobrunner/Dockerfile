FROM docker-registry.wikimedia.org/dev/bullseye-php81:1.0.0

RUN apt-get update && apt-get install -yq ffmpeg

# MediaWiki default settings
COPY ../files/mediawiki-jobrunner/docker/PlatformSettings.php /docker/PlatformSettings.php

WORKDIR "/var/www/html/w"

COPY ../files/mediawiki-jobrunner/entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]

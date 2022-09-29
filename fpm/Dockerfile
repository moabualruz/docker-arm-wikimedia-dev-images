FROM docker-registry.wikimedia.org/dev/buster-php74:1.0.0

# We don't want the default index.html for running PHP applications, and
# xdebug is a major performance drag, so disable it here (it's already
# been disabled for CLI PHP in buster-php74).

RUN apt update && apt install -yq php7.4-fpm

# php-fpm configuration:
COPY ../files/mediawiki-fpm/docker/20-xdebug.ini /docker/20-xdebug.ini
COPY ../files/mediawiki-fpm/docker/php-xhprof-extension/ /docker/php-xhprof-extension/
COPY ../files/mediawiki-fpm/php-fpm.conf /etc/php/7.4/fpm/php-fpm.conf
RUN cp /docker/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# MediaWiki-specific php.ini settings
# upload_max_filesize and post_max_size here match production, per T246930
RUN echo 'opcache.file_update_protection=0\n\
opcache.memory_consumption=256\n\
opcache.max_accelerated_files=24000\n\
opcache.max_wasted_percentage=10\n\
opcache.fast_shutdown=1\n\
zlib.output_compression=On\n\
upload_max_filesize=100M\n\
post_max_size=100M\n' | tee -a /etc/php/7.4/fpm/php.ini /etc/php/7.4/cli/php.ini

RUN test -f "/etc/php/7.4/fpm/conf.d/20-xdebug.ini" && rm "/etc/php/7.4/fpm/conf.d/20-xdebug.ini" || true

RUN ln -s /docker/20-xdebug.ini "/etc/php/7.4/fpm/conf.d/20-xdebug.ini"

EXPOSE 9000
EXPOSE 9003

WORKDIR "/var/www/html/w"

ENTRYPOINT ["/bin/bash", "/php_entrypoint.sh"]

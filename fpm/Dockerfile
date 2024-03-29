FROM docker-registry.wikimedia.org/dev/bullseye-php81:1.0.0

# We don't want the default index.html for running PHP applications, and
# xdebug is a major performance drag, so disable it here (it's already
# been disabled for CLI PHP in bullseye-php81).

RUN apt-get update && apt-get install -yq php8.1-fpm

# php-fpm configuration:
COPY ../files/mediawiki-fpm/docker/20-xdebug.ini /docker/20-xdebug.ini
COPY ../files/mediawiki-fpm/php-fpm.conf /etc/php/8.1/fpm/php-fpm.conf
RUN cp /docker/www.conf /etc/php/8.1/fpm/pool.d/www.conf

# MediaWiki-specific php.ini settings
# upload_max_filesize and post_max_size here match production, per T246930
RUN echo 'opcache.file_update_protection=0\n\
opcache.memory_consumption=256\n\
opcache.max_accelerated_files=24000\n\
opcache.max_wasted_percentage=10\n\
opcache.fast_shutdown=1\n\
zlib.output_compression=On\n\
upload_max_filesize=100M\n\
post_max_size=100M\n\
extension=ast.so\n' | tee -a /etc/php/8.1/fpm/php.ini /etc/php/8.1/cli/php.ini

#install PECL extensions
RUN wget http://pear.php.net/go-pear.phar && php go-pear.phar && rm go-pear.phar

# Install phan dependencies
RUN pecl install ast

# install Xdebug and xhprof
RUN test -f "/etc/php/8.1/fpm/conf.d/20-xdebug.ini" && rm "/etc/php/8.1/fpm/conf.d/20-xdebug.ini" || true
RUN pecl install xdebug-3.1.5

## install xhprof (tideways forked xhprof and is maintaining it for php8+)
RUN curl "https://github.com/tideways/php-xhprof-extension/archive/v5.0.4.tar.gz" -fsL -o ./a.tar.gz && \
    tar xf ./a.tar.gz && \
    ls -la && cd ./php-xhprof-extension-5.0.4 && \
    ls -la && \
    phpize && \
    ./configure && \
    make && \
    make install && \
    cd .. && rm -rf ./a.tar.gz ./php-xhprof-extension-5.0.4

RUN ln -s /docker/20-xdebug.ini "/etc/php/$PHP_VERSION/fpm/conf.d/20-xdebug.ini"
RUN ln -s /docker/20-xdebug.ini "/etc/php/$PHP_VERSION/cli/conf.d/20-xdebug.ini"

EXPOSE 9000
EXPOSE 9003

WORKDIR "/var/www/html/w"

ENTRYPOINT ["/bin/bash", "/php_entrypoint.sh"]

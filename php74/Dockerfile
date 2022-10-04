FROM docker-registry.wikimedia.org/bullseye:latest

ENV PHP_VERSION=7.4

# Note that WMF APT key is pre-installed.
# See: https://wikitech.wikimedia.org/wiki/APT_repository#Security

# Does not have arm images using 3rd party instead
#RUN echo "deb https://apt.wikimedia.org/wikimedia bullseye-wikimedia component/php74" \
#   > /etc/apt/sources.list.d/wikimedia-php74.list

RUN apt update && apt install -yq curl \
wget \
gnupg2 \
ca-certificates \
lsb-release \
apt-transport-https


RUN curl -s https://packages.sury.org/php/apt.gpg --output apt.gpg && APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1 apt-key add apt.gpg && rm apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php7.list

# Install PHP dependencies:
RUN apt update && apt install -yq php7.4 \
php7.4-cli \
php7.4-common \
php7.4-apcu \
php7.4-bcmath \
php7.4-cli \
php7.4-curl \
php7.4-dba \
php7.4-gd \
php7.4-gmp \
php7.4-intl \
php7.4-ldap \
php7.4-mbstring \
php7.4-mysql \
php7.4-pgsql \
php7.4-sqlite3 \
php7.4-xml \
php7.4-zip \
php7.4-redis \
php7.4-dev \
php7.4-ldap \
php7.4-mysql \
php7.4-pgsql \
php7.4-dev \
sed \
build-essential

RUN update-alternatives --set php /usr/bin/php7.4

# install composer
# see "command-line installation" https://getcomposer.org/download/
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === file_get_contents('https://composer.github.io/installer.sig')) { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"

RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN php -r "unlink('composer-setup.php');"

# Install PHP tools globally
## Linters and Code Chekers
RUN composer global require "friendsofphp/php-cs-fixer"
RUN composer global require "squizlabs/php_codesniffer"

## Extra tools
### Static Code analyzers : finds bugs in PHP code
RUN composer global require "phpstan/phpstan"
RUN composer global require "phpmd/phpmd"
RUN composer global require "vimeo/psalm"
ENV PATH="/root/.composer/vendor/bin:$PATH"

# Install XDebug but disable it by default due to its performance impact:

RUN test -f /bin/sed && ln -s /bin/sed /usr/bin/sed
RUN test -f /usr/bin/sed && ln -s /usr/bin/sed /bin/sed

RUN pecl install xdebug-3.1.5 && docker-php-ext-enable xdebug

RUN printf 'zend_extension=xdebug.so \
xdebug.mode="${XDEBUG_MODE}" \
extension=tideways_xhprof.so \
' | tee -a /docker/20-xdebug.ini

RUN ln -s /docker/20-xdebug.ini "/etc/php/$PHP_VERSION/cli/conf.d/20-xdebug.ini"

# install xhprof (tideways forked xhprof and is maintaining it for PHP7+)
RUN curl "https://github.com/tideways/php-xhprof-extension/archive/v5.0.4.tar.gz" -fsL -o ./a.tar.gz && \
    tar xf ./a.tar.gz && \
    ls -la && cd ./php-xhprof-extension-5.0.4 && \
    ls -la && \
    phpize && \
    ./configure && \
    make && \
    make install && \
    cd .. && rm -rf ./a.tar.gz ./php-xhprof-extension-5.0.4 && \
    docker-php-ext-enable tideways_xhprof



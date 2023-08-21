FROM docker-registry.wikimedia.org/bullseye:latest

ENV PHP_VERSION=8.1

# Note that WMF APT key is pre-installed.
# See: https://wikitech.wikimedia.org/wiki/APT_repository#Security

# Does not have arm images using 3rd party instead
#RUN echo "deb https://apt.wikimedia.org/wikimedia bullseye-wikimedia component/php81" \
#   > /etc/apt/sources.list.d/wikimedia-php81.list

RUN apt-get update && apt-get install -yq curl \
wget \
gnupg2 \
ca-certificates \
lsb-release \
apt-transport-https


RUN curl -s https://packages.sury.org/php/apt.gpg --output apt.gpg && APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1 apt-key add apt.gpg && rm apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php8.list

# Install PHP dependencies:
RUN apt-get update && apt-get install -yq php8.1 \
php8.1-cli \
php8.1-common \
php8.1-apcu \
php8.1-bcmath \
php8.1-cli \
php8.1-curl \
php8.1-dba \
php8.1-gd \
php8.1-gmp \
php8.1-intl \
php8.1-ldap \
php8.1-mbstring \
php8.1-mysql \
php8.1-pgsql \
php8.1-sqlite3 \
php8.1-xml \
php8.1-zip \
php8.1-redis \
php8.1-dev \
php8.1-ldap \
php8.1-mysql \
php8.1-pgsql \
php8.1-dev \
sed \
git \
build-essential \
pkg-config \
libthai0 \
libthai-dev

RUN git clone https://gerrit.wikimedia.org/r/mediawiki/php/wikidiff2.git
WORKDIR wikidiff2
RUN phpize
RUN ./configure && make && make install

RUN echo 'extension=wikidiff2.so' > /etc/php/8.1/mods-available/wikidiff2.ini
RUN ln -s /etc/php/8.1/mods-available/wikidiff2.ini /etc/php/8.1/apache2/conf.d/wikidiff2.ini
RUN ln -s /etc/php/8.1/mods-available/wikidiff2.ini /etc/php/8.1/cli/conf.d/wikidiff2.ini
#RUN ln -s /etc/php/8.1/mods-available/wikidiff2.ini /etc/php/8.1/fpm/conf.d/wikidiff2.ini
RUN phpenmod wikidiff2

RUN update-alternatives --set php /usr/bin/php8.1

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

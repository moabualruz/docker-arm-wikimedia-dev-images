FROM docker-registry.wikimedia.org/buster:latest

ENV PHP_VERSION=7.4

# Note that WMF APT key is pre-installed.
# See: https://wikitech.wikimedia.org/wiki/APT_repository#Security

# Does not have arm images using 3rd party instead
#RUN echo "deb https://apt.wikimedia.org/wikimedia buster-wikimedia component/php74" \
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

# Install XDebug but disable it by default due to its performance impact:

RUN ln -s /bin/sed /usr/bin/sed

RUN sh /docker/build-xdebug.sh

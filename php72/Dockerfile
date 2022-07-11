FROM docker-registry.wikimedia.org/buster:latest

ENV PHP_VERSION=7.2

# Note that WMF APT key is pre-installed.
# See: https://wikitech.wikimedia.org/wiki/APT_repository#Security

# Does not have arm images using 3rd party instead
#RUN echo "deb https://apt.wikimedia.org/wikimedia buster-wikimedia component/php72" \
#   > /etc/apt/sources.list.d/wikimedia-php72.list

RUN apt update && apt install -yq curl \
wget \
gnupg2 \
ca-certificates \
lsb-release \
apt-transport-https


RUN curl -s https://packages.sury.org/php/apt.gpg --output apt.gpg && APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1 apt-key add apt.gpg && rm apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php7.list

# Install PHP dependencies:
RUN apt update && apt install -yq php7.2 \
php7.2-cli \
php7.2-common \
php7.2-apcu \
php7.2-bcmath \
php7.2-cli \
php7.2-curl \
php7.2-dba \
php7.2-gd \
php7.2-gmp \
php7.2-intl \
php7.2-ldap \
php7.2-mbstring \
php7.2-mysql \
php7.2-pgsql \
php7.2-sqlite3 \
php7.2-xml \
php7.2-zip \
php7.2-redis \
php7.2-dev \
php7.2-ldap \
php7.2-mysql \
php7.2-pgsql \
php7.2-dev \
sed \
build-essential

RUN update-alternatives --set php /usr/bin/php7.2


# Install XDebug but disable it by default due to its performance impact:

RUN ln -s /bin/sed /usr/bin/sed

RUN sh /docker/build-xdebug.sh

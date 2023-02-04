FROM docker-registry.wikimedia.org/bullseye:latest

# We don't want the default index.html for running PHP applications, and
# xdebug is a major performance drag, so disable it here (it's already
# been disabled for CLI PHP in stretch-php81).

RUN apt update && apt install -yq apache2 \
    && rm /var/www/html/index.html \
    && a2enmod proxy_fcgi \
    && a2enmod mpm_event \
    && a2enmod rewrite \
    && a2enmod http2 \
    && a2enmod cache

# Apache configuration:
COPY ../files/mediawiki-apache2/ports.conf /etc/apache2/ports.conf
COPY ../files/mediawiki-apache2/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY ../files/mediawiki-apache2/apache2.conf /etc/apache2/apache2.conf
COPY ../files/mediawiki-apache2/envvars /etc/apache2/envvars

EXPOSE 8080
# EXPOSE 443

WORKDIR "/var/www/html/w"

COPY ../files/mediawiki-apache2/entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]

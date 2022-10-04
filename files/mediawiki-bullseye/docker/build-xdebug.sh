#!/bin/sh

set +e

# Use Xdebug 3.0.4 rather than 2.6 that is packaged with stretch
# The sed line is needed to fix a bug with Tar.php packaged with stretch
# Linux users will need to override xdebug.client_host with their hostname
# using e.g. XDEBUG_CONFIG='client_host=yourhostname'

cd /docker

tar -xzf xdebug-3.0.4.tgz
cd xdebug-3.0.4
phpize
./configure --enable-xdebug
make
make install

printf 'zend_extension=xdebug.so
xdebug.mode="${XDEBUG_MODE}"
extension=tideways_xhprof.so
' | tee -a /docker/20-xdebug.ini

ln -s /docker/20-xdebug.ini "/etc/php/$PHP_VERSION/cli/conf.d/20-xdebug.ini"

cd ..
rm -rf xdebug-3.0.4

git clone --depth=1 https://github.com/tideways/php-xhprof-extension.git
cd php-xhprof-extension
phpize
./configure
make
make install
cd ..
rm -rf ../php-xhprof-extension

apt-get -y remove php-dev build-essential
apt-get -y autoremove --purge

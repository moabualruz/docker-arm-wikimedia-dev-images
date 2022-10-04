#!/bin/bash

# Copy PlatformSettings.php. We do this unconditionally so that changes made
# in PlatformSettings.php in image updates are put in place each time the
# mediawiki container is created.
cp /docker/PlatformSettings.php includes/PlatformSettings.php

"php-fpm$PHP_VERSION" --nodaemonize

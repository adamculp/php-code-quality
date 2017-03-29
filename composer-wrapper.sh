#!/bin/sh

php /usr/local/lib/php-qa-tools/composer.phar $@
STATUS=$?
return $STATUS
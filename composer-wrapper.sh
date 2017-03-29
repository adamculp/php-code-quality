#!/bin/sh

php /usr/local/lib/php-code-quality/composer.phar $@
STATUS=$?
return $STATUS
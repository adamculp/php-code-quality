# this is a WORK IN PROGRESS

# DO NOT USE YET


#
# Choose the desired PHP version
# Choices available at https://hub.docker.com/_/php/ stick to "-cli" versions recommended
#
FROM php:7.1-cli

MAINTAINER Adam Culp <adamculp@uws.net>

ENV TARGET_DIR="/usr/local/lib/php-qa-tools" \
    COMPOSER_HOME="~/.composer" \
    COMPOSER_BIN_DIR="/usr/local/bin" \
    COMPOSER_ALLOW_SUPERUSER=1 \
    HTTP_PROXY_REQUEST_FULLURI=1 \
    HTTPS_PROXY_REQUEST_FULLURI=0 \
    TIMEZONE=America/New_York \
    PHP_MEMORY_LIMIT=512M

RUN mkdir -p $TARGET_DIR

WORKDIR $TARGET_DIR

# RUN mkdir /opt/php-qa-tools && cd /opt/php-qa-tools \
#    && wget https://phar.phpunit.de/phpunit.phar -O phpunit \
#    && wget https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar -O phpcs \
#    && wget https://squizlabs.github.io/PHP_CodeSniffer/phpcbf.phar -O phpcbf \
#    && wget https://phar.phpunit.de/phploc.phar -O phploc \
#    && wget http://static.pdepend.org/php/latest/pdepend.phar -O pdepend \
#    && wget http://static.phpmd.org/php/latest/phpmd.phar -O phpmd \
#    && wget https://phar.phpunit.de/phpcpd.phar -O phpcpd \
#    && wget https://github.com/theseer/phpdox/releases/download/0.9.0/phpdox-0.9.0.phar -O phpdox \
#    && wget http://get.sensiolabs.org/php-cs-fixer.phar -O php-cs-fixer \
#    && chmod a+x /opt/php-qa-tools/*

# Run composer installation of needed tools
RUN $TARGET_DIR/install-composer.sh && \
    composer selfupdate && \
    composer require --prefer-stable --prefer-source "hirak/prestissimo:^0.3" && \
    composer require --prefer-stable --prefer-dist \
        "squizlabs/php_codesniffer:3.0.x-dev" \
        "phpunit/phpunit:^5" \
        "phploc/phploc:dev-master" \
        "phpmd/phpmd:dev-master" \
        "pdepend/pdepend:dev-master" \
        "sebastian/phpcpd:dev-master" \
        "theseer/phpdox:dev-master" \
        "friendsofphp/php-cs-fixer:^1" \

        "techlivezheng/phpctags:dev-master" \
        "wimg/php-compatibility:dev-master" \
        "etsy/phan:dev-master" && \

# install PHPCompatibility



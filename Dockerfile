# Choose the desired PHP version
# Choices available at https://hub.docker.com/_/php/ stick to "-cli" versions recommended
FROM php:7.1-cli

MAINTAINER Adam Culp <adamculp@uws.net>

ENV TARGET_DIR="/usr/local/lib/php-code-quality" \
    COMPOSER_ALLOW_SUPERUSER=1 \
    TIMEZONE=America/New_York \
    PHP_MEMORY_LIMIT=512M

RUN mkdir -p $TARGET_DIR

WORKDIR $TARGET_DIR

COPY composer-installer.sh $TARGET_DIR/
COPY composer-wrapper.sh /usr/local/bin/composer

RUN apt-get update && \
    apt-get install -y wget && \
    apt-get install -y zip && \
    apt-get install -y git && \
    apt-get install -y libxml2-dev && \
    docker-php-ext-install xml

RUN chmod 744 $TARGET_DIR/composer-installer.sh
RUN chmod 744 /usr/local/bin/composer

# Run composer installation of needed tools
RUN $TARGET_DIR/composer-installer.sh && \
   composer selfupdate && \
   composer require --prefer-stable --prefer-source "hirak/prestissimo:^0.3" && \
   composer require --prefer-stable --prefer-dist \
       "squizlabs/php_codesniffer:^3.0.2" \
       "phpunit/phpunit:^6.2.4" \
       "phploc/phploc:dev-master" \
       "pdepend/pdepend:^2.5" \
       "phpmd/phpmd:dev-master" \
       "sebastian/phpcpd:dev-master" \
       "friendsofphp/php-cs-fixer:dev-master" \
       "wimg/php-compatibility:^8.0.0" \
       "phpmetrics/phpmetrics:dev-master" \
       "phpstan/phpstan:dev-master"

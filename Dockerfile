# Choose the desired PHP version
# Choices available at https://hub.docker.com/_/php/ stick to "-cli" versions recommended
FROM php:8.0.12-cli

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
        "squizlabs/php_codesniffer:^3.6" \
        "phpunit/phpunit:^9.5" \
        "phploc/phploc:^7.0" \
        "pdepend/pdepend:^2.10" \
        "phpmd/phpmd:^2.10" \
        "sebastian/phpcpd:^6.0" \
        "friendsofphp/php-cs-fixer:^3.2" \
        "phpcompatibility/php-compatibility:^9.3" \
        "phpmetrics/phpmetrics:^2.7" \
        "phpstan/phpstan:^1.1"

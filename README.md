# php-code-quality
The objective is to include multiple PHP code quality tools (phpqatools and more) in one instance. Currently this means:

- squizlabs/php_codesniffer
- phpunit/phpunit
- phploc/phploc
- pdepend/pdepend
- phpmd/phpmd
- sebastian/phpcpd
- friendsofphp/php-cs-fixer
- wimg/php-compatibility
- phpmetrics/phpmetrics

## Usage

Note: This container does nothing when invoking it without a command.

Example:

```
$ docker run -it --rm -v "$PWD":/app -w /app adamculp/php-code-quality:latest <your-command-with-arguments>
```

In the example above, the mounted host directory is your current working directory ($PWD).
This is the most common case, because it enables you to run the tools on everything in
and/or below that directory.

There are two ways it can be used:

* Run a command in the container on your mounted directory or below.
* Run a script from your mounted directory or below.

Available commands in the container:

* php + args
* composer + args
* vendor/bin/phploc + args
* vendor/bin/phpmd + args
* vendor/bin/pdepend + args
* vendor/bin/phpcpd + args
* vendor/bin/phpmetrics + args
* phpunit
* vendor/bin/phpcs
* php-cs-fixer
* sh (or any other command)

Some possible example commands:

### PHP Lines of Code (PHPLoc)

See https://github.com/sebastianbergmann/phploc for more usage details of this tool 
```
$ docker run -it --rm -v "$PWD":/app -w /app adamculp/php-code-quality:latest php /usr/local/lib/php-code-quality/vendor/bin/phploc -v --names "*.php" --exclude "vendor" . > ./php_code_quality/phploc.txt
```

### PHP Mess Detector (phpmd)

See https://phpmd.org/download/index.html for more usage details of this tool
```
$ docker run -it --rm -v "$PWD":/app -w /app adamculp/php-code-quality:latest php /usr/local/lib/php-code-quality/vendor/bin/phpmd . xml codesize --exclude 'vendor' --reportfile './php_code_quality/phpmd_results.xml'
```

### PHP Depends (Pdepend)

See https://pdepend.org/ for more usage details of this tool
```
$ docker run -it --rm -v "$PWD":/app -w /app adamculp/php-code-quality:latest php /usr/local/lib/php-code-quality/vendor/bin/pdepend --ignore='vendor' --summary-xml='./php_code_quality/pdepend_output.xml' --jdepend-chart='./php_code_quality/pdepend_chart.svg' --overview-pyramid='./php_code_quality/pdepend_pyramid.svg' .
```

### PHP Copy/Paste Detector (phpcpd)

See https://github.com/sebastianbergmann/phpcpd for more usage details of this tool
```
$ docker run -it --rm -v "$PWD":/app -w /app adamculp/php-code-quality:latest php /usr/local/lib/php-code-quality/vendor/bin/phpcpd . --exclude 'vendor' > ./php_code_quality/phpcpd_results.txt
```

### PHPMetrics

See http://www.phpmetrics.org/ for more usage details of this tool
```
$ docker run -it --rm -v "$PWD":/app -w /app adamculp/php-code-quality:latest php /usr/local/lib/php-code-quality/vendor/bin/phpmetrics --excluded-dirs 'vendor' --report-html=./php_code_quality/metrics_results .
```

### PHP Codesniffer (phpcs) using PHPCompatibility rules

See https://github.com/wimg/PHPCompatibility and https://github.com/squizlabs/PHP_CodeSniffer/wiki for more usage details of this tool
```
$ docker run -it --rm -v "$PWD":/app -w /app adamculp/php-code-quality:latest php /usr/local/lib/php-code-quality/vendor/bin/phpcs -sv --config-set installed_paths /usr/local/lib/php-code-quality/vendor/wimg/php-compatibility/ --standard='PHPCompatibility' --extensions=php --ignore=vendor --report-file=./php_code_quality/codesniffer_results.txt .
```

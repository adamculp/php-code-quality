# php-code-quality
The objective is to include multiple PHP code quality tools (phpqatools and more) in an easy to use Docker image. The 
tools include php-qa-tools, PHP static analysis, lines of PHP code report, mess detector, code smell highlighting, 
copy/paste detection, and the applications compatibility against versions of PHP.

More specifically this includes:

- squizlabs/php_codesniffer
- phpunit/phpunit
- phploc/phploc
- pdepend/pdepend
- phpmd/phpmd
- sebastian/phpcpd
- friendsofphp/php-cs-fixer
- wimg/php-compatibility
- phpmetrics/phpmetrics
- phpstan/phpstan

## Usage

Note: This container does nothing when invoking it without a command, such as:

Windows users: The use of "$PWD" for present working directory will not work as expected, instead use the full path. 
Such as "//c/Users/adamculp/project".

```
$ cd </path/to/desired/directory>
$ docker run -it --rm -v "$PWD":/app -w /app adamculp/php-code-quality:latest <desired-command-with-arguments>
```

In the example above, Docker runs an interactive terminal to be removed when all is completed, and mounts 
the current host directory ($PWD) inside the container, sets this as the current working directory, and then 
loads the image adamculp/php-code-quality. Following this the user can add any commands to be executed inside 
the container. (such as running the tools provided by the image)

This is the most common use case, enabling the user to run the tools on everything in and/or below the working 
directory.

Available commands provided by the adamculp/php-code-quality image:

* php + args
* composer + args
* vendor/bin/phploc + args
* vendor/bin/phpmd + args
* vendor/bin/pdepend + args
* vendor/bin/phpcpd + args
* vendor/bin/phpmetrics + args
* vendor/bin/phpunit + args
* vendor/bin/phpcs + args
* vendor/bin/php-cs-fixer + args
* vendor/bin/phpstan + args (more robust commands via config file)
* sh (or any other command) + args

### Some possible example commands:

NOTE: If using the commands below "as-is", please create a 'php_code_quality' folder within the project first. 
This will be used, by the commands, to contain the results of the various tools. Modify as desired.

#### PHP Lines of Code (PHPLoc)

See https://github.com/sebastianbergmann/phploc for more usage details of this tool.

```
$ docker run -it --rm -v "$PWD":/app -w /app adamculp/php-code-quality:latest \
php /usr/local/lib/php-code-quality/vendor/bin/phploc -v --names "*.php" \
--exclude "vendor" . > ./php_code_quality/phploc.txt
```

#### PHP Mess Detector (phpmd)

See https://phpmd.org/download/index.html for more usage details of this tool.

```
$ docker run -it --rm -v "$PWD":/app -w /app adamculp/php-code-quality:latest \
php /usr/local/lib/php-code-quality/vendor/bin/phpmd . xml codesize --exclude 'vendor' \
--reportfile './php_code_quality/phpmd_results.xml'
```

#### PHP Depends (Pdepend)

See https://pdepend.org/ for more usage details of this tool.

```
$ docker run -it --rm -v "$PWD":/app -w /app adamculp/php-code-quality:latest \
php /usr/local/lib/php-code-quality/vendor/bin/pdepend --ignore='vendor' \
--summary-xml='./php_code_quality/pdepend_output.xml' \
--jdepend-chart='./php_code_quality/pdepend_chart.svg' \
--overview-pyramid='./php_code_quality/pdepend_pyramid.svg' .
```

#### PHP Copy/Paste Detector (phpcpd)

See https://github.com/sebastianbergmann/phpcpd for more usage details of this tool.

```
$ docker run -it --rm -v "$PWD":/app -w /app adamculp/php-code-quality:latest \
php /usr/local/lib/php-code-quality/vendor/bin/phpcpd . \
--exclude 'vendor' > ./php_code_quality/phpcpd_results.txt
```

#### PHPMetrics

See http://www.phpmetrics.org/ for more usage details of this tool.

```
$ docker run -it --rm -v "$PWD":/app -w /app adamculp/php-code-quality:latest \
php /usr/local/lib/php-code-quality/vendor/bin/phpmetrics --excluded-dirs 'vendor' \
--report-html=./php_code_quality/metrics_results .
```

#### PHP Codesniffer (phpcs)

See https://github.com/squizlabs/PHP_CodeSniffer/wiki for more usage details of this tool.

```
$ docker run -it --rm -v "$PWD":/app -w /app adamculp/php-code-quality:latest \
php /usr/local/lib/php-code-quality/vendor/bin/phpcs -sv --extensions=php --ignore=vendor \
--report-file=./php_code_quality/codesniffer_results.txt .
```

#### PHPCompatibility rules applied to PHP Codesniffer

See https://github.com/wimg/PHPCompatibility and https://github.com/squizlabs/PHP_CodeSniffer/wiki for more 
usage details of this tool.

```
$ docker run -it --rm -v "$PWD":/app -w /app adamculp/php-code-quality:latest sh -c \
'php /usr/local/lib/php-code-quality/vendor/bin/phpcs -sv --config-set installed_paths  /usr/local/lib/php-code-quality/ && \
php /usr/local/lib/php-code-quality/vendor/bin/phpcs -sv --standard='PHPCompatibility' --extensions=php --ignore=vendor . \
--report-file=./php_code_quality/phpcompatibility_results.txt .'
```

## Alternative Preparations

Rather than allowing Docker to retrieve the image from Docker Hub, users could also build the docker image locally 
by cloning the image repo from Github.

Why? As an example, a different version of PHP provided by including a different PHP image may be desired. Or a 
specific version of the tools loaded by Composer might be required.

After cloning, navigate to the location:

```
$ git clone https://github.com/adamculp/php-code-quality.git
$ cd php-code-quality
```

Alter the Dockerfile as desired, then build the image locally:

```
$ docker build -t adamculp/php-code-quality .
```

Or a user may simply desire the image as-is, for later use:

```
$ docker build -t adamculp/php-code-quality https://github.com/adamculp/php-code-quality.git
```

## Enjoy!

Please star, on Docker Hub and Github, if you find this helpful.

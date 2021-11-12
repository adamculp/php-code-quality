# php-code-quality
My objective is to include multiple PHP code quality tools in an easy-to-use Docker image. The tools include PHP static analysis, lines of PHP code report, mess detector, code smell highlighting, copy/paste detection, and the application compatibility from one version of PHP to another for modernization efforts.

More specifically the Docker image includes:

- phpstan/phpstan
- squizlabs/php_codesniffer
- phpcompatibility/php-compatibility
- phploc/phploc
- phpmd/phpmd
- pdepend/pdepend
- sebastian/phpcpd
- phpmetrics/phpmetrics
- phpunit/phpunit
- friendsofphp/php-cs-fixer

Now available through both Docker Hub and Github Container Repository. (see below)

## Usage

Note: This image does nothing when invoking it without a followup command (as shown below in `Some example commands` for each tool), such as:

```
cd </path/to/desired/directory>
docker run -it --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp \
adamculp/php-code-quality:latest <followup-command-with-arguments>
```

Also, note the example above is for using the Docker Hub repository. Alternatively, you can also use the Github Package repository as well by prepending `ghcr.io/` to the image identifier, like the following: (Replacing the placeholders in angle brackets with your values.)

```
cd </path/to/your/project>
docker run -it --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp \
 adamculp/php-code-quality:latest <followup-command-with-arguments>
```

WINDOWS USERS: The use of "$PWD" for present working directory will not work as expected, instead use the full path. Such as "//c/Users/adamculp/project".

In the example above, Docker runs an interactive terminal to be removed when all is completed, and mounts the current host directory ($PWD) inside the container, sets this as the current working directory, and then loads the image `adamculp/php-code-quality` or `ghcr.io/adamculp/php-code-quality` as the case may be.

Following this the user can add any commands to be executed within the container. (such as running the tools provided by the image)

This is the most common use case, enabling the user to run the tools on everything in and/or below the working directory.

Available commands provided by the adamculp/php-code-quality image:

* sh (or any other command) + args
* php + args
* composer + args
* vendor/bin/<chosen-tool-command-below> + args

### Some example commands:

IMPORTANT: If using the commands below "as-is", please create a 'php_code_quality' folder within the project first. This will be used, by the commands, to contain the results of the various tools. Modify as desired.

IMPORTANT: If you run into memory issues, where the output states the process ran out of memory, you can alter the amount of memory the PHP process uses for a given command by adding the -d flag to the PHP command. Note that the following example is for extreme cases since the image already sets the memory limit to 512M. (not recommended)

```
php -d memory_limit=1G
```

#### PHPStan

See [PHPStan Documentation](https://phpstan.org/user-guide/getting-started) for more documentation on use.

```
docker run -it --rm --name php-code-quality -v "$PWD":/usr/src/myapp -w /usr/src/myapp \
adamculp/php-code-quality:latest sh -c 'php /usr/local/lib/php-code-quality/vendor/bin/phpstan \
 analyse -l 0 --error-format=table > ./php_code_quality/phpstan_results.txt .'
```

#### PHP Codesniffer (phpcs)

See [PHP_CodeSniffer Wiki](https://github.com/squizlabs/PHP_CodeSniffer/wiki) for more usage details of this tool.

```
docker run -it --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp adamculp/php-code-quality:latest \
php /usr/local/lib/php-code-quality/vendor/bin/phpcs -sv --extensions=php --ignore=vendor \
--report-file=./php_code_quality/codesniffer_results.txt .
```

#### PHPCompatibility rules applied to PHP Codesniffer

See [PHPCompatibility Readme](https://github.com/PHPCompatibility/PHPCompatibility) and [PHP_CodeSniffer Wiki](https://github.com/squizlabs/PHP_CodeSniffer/wiki) above for more usage details of this tool. PHPCompatibility is a collection of sniffs to be used with PHP_CodeSniffer.

```
docker run -it --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp adamculp/php-code-quality:latest sh -c \
'php /usr/local/lib/php-code-quality/vendor/bin/phpcs -sv --config-set installed_paths  /usr/local/lib/php-code-quality/vendor/phpcompatibility/php-compatibility && \
php /usr/local/lib/php-code-quality/vendor/bin/phpcs -sv --standard='PHPCompatibility' --extensions=php --ignore=vendor . \
--report-file=./php_code_quality/phpcompatibility_results.txt .'
```

#### PHP Lines of Code (PHPLoc)

See [PHPLOC Readme](https://github.com/sebastianbergmann/phploc) for more usage details of this tool.

```
docker run -it --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp adamculp/php-code-quality:latest \
php /usr/local/lib/php-code-quality/vendor/bin/phploc  \
--exclude vendor . > ./php_code_quality/phploc.txt
```

#### PHP Mess Detector (phpmd)

See [PHPMD Readme](https://github.com/phpmd/phpmd) for more usage details of this tool.

```
docker run -it --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp adamculp/php-code-quality:latest \
php /usr/local/lib/php-code-quality/vendor/bin/phpmd . xml codesize --exclude 'vendor' \
--reportfile './php_code_quality/phpmd_results.xml'
```

#### PHP Depends (Pdepend)

See [PDepend Docs](https://pdepend.org/) for more usage details of this tool.

Note: I haven't used this for awhile, and notice it may require a Tidelift subscription for use.

```
docker run -it --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp adamculp/php-code-quality:latest \
php /usr/local/lib/php-code-quality/vendor/bin/pdepend --ignore='vendor' \
--summary-xml='./php_code_quality/pdepend_output.xml' \
--jdepend-chart='./php_code_quality/pdepend_chart.svg' \
--overview-pyramid='./php_code_quality/pdepend_pyramid.svg' .
```

#### PHP Copy/Paste Detector (phpcpd)

See [PHPCPD Readme](https://github.com/sebastianbergmann/phpcpd) for more usage details of this tool.

```
docker run -it --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp adamculp/php-code-quality:latest \
php /usr/local/lib/php-code-quality/vendor/bin/phpcpd . \
--exclude 'vendor' > ./php_code_quality/phpcpd_results.txt
```

#### PHPMetrics

See http://www.phpmetrics.org/ for more usage details of this tool.

```
docker run -it --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp adamculp/php-code-quality:latest \
php /usr/local/lib/php-code-quality/vendor/bin/phpmetrics --excluded-dirs 'vendor' \
--report-html=./php_code_quality/metrics_results .
```

## Alternative Preparations

Rather than allowing Docker to retrieve the image from the Docker Hub or Github Container Repositories, users may also build the docker image locally by cloning the image repo from Github.

Why? As an example, a different version of PHP may be desired. Or a specific version of any tools might be required.

After cloning, navigate to the location:

```
git clone https://github.com/adamculp/php-code-quality.git
cd php-code-quality
```

Alter the Dockerfile as desired, then build the image locally: (don't miss the dot at the end)

```
docker build -t adamculp/php-code-quality .
```

Or a user may simply desire the image as-is, and cache for later use:

```
docker build -t adamculp/php-code-quality https://github.com/adamculp/php-code-quality.git
```

## Enjoy!

Please star, on [Docker Hub](https://hub.docker.com/repository/docker/adamculp/php-code-quality), [Github Container Repository](https://github.com/adamculp/php-code-quality/pkgs/container/php-code-quality), or [Github](https://github.com/adamculp/php-code-quality), if you find this helpful.

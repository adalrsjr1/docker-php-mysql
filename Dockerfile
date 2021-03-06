FROM alpine:latest
MAINTAINER adalrsjr1 - https://github.com/adalrsjr1

# Install Apache + PHP based on:: https://hub.docker.com/r/mlabbe/speedtest-mini/~/dockerfile/
#                                 https://github.com/kost/docker-alpine/blob/master/alpine-apache-php/Dockerfile
#                                 https://hub.docker.com/r/mlabbe/speedtest-mini/~/dockerfile/

RUN apk --update add php5-apache2 curl \
    php5-mcrypt \ 
	php5-soap \ 
	php5-openssl \ 
	php5-gmp \ 
	php5-pdo_odbc \ 
	php5-json \ 
	php5-dom \ 
	php5-pdo \ 
	php5-zip \ 
	php5-mysql \ 
	php5-sqlite3 \ 
	php5-apcu \ 
	php5-pdo_pgsql \ 
	php5-bcmath \ 
	php5-gd \ 
	php5-xcache \ 
	php5-odbc \ 
	php5-pdo_mysql \ 
	php5-pdo_sqlite \ 
	php5-gettext \ 
	php5-xmlreader \ 
	php5-xmlrpc \ 
	php5-bz2 \ 
	php5-memcache \ 
	php5-mssql \ 
	php5-iconv \ 
	php5-pdo_dblib \
	php5-curl \ 
	php5-ctype \ 
	php5-phar \ 
	php5-cli \
	php5-phar && \
    rm -f /var/cache/apk/* 
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    mkdir /app && chown -R apache:apache /app && \
    sed -i 's#^DocumentRoot ".*#DocumentRoot "/app"#g' /etc/apache2/httpd.conf && \
    sed -i 's#AllowOverride none#AllowOverride All#' /etc/apache2/httpd.conf && \
	sed -i 's#AllowOverride None#AllowOverride All#' /etc/apache2/httpd.conf && \
	sed -i 's#Require all denied#Require all granted#' /etc/apache2/httpd.conf && \
	sed -i 's#\#LoadModule rewrite_module modules/mod_rewrite.so#LoadModule rewrite_module modules/mod_rewrite.so#' /etc/apache2/httpd.conf && \
	sed -i 's#short_open_tag = Off#short_open_tag = On#' /etc/php5/php.ini && \
	sed -i 's#error_reporting = .*$#error_reporting = E_ERROR | E_WARNING | E_PARSE#' /etc/php5/php.ini && \
	sed -i 's#display_errors = Off#display_errors = On#' /etc/php5/php.ini && \
	sed -i 's#display_startup_errors = Off#display_startup_errors = On#' /etc/php5/php.ini && \
	echo "Apache successfully installed"
ADD app/* /app/.

ADD scripts/run.sh /scripts/run.sh
RUN mkdir /scripts/pre-exec.d && \
    mkdir /scripts/pre-init.d && \
    chmod -R 755 /scripts && \
	sed -i '1s/^/ServerName localhost \r\n\r\n/' /etc/apache2/httpd.conf && \
	mkdir /run/apache2 

# install MySql based on:: https://github.com/timhaak/docker-mariadb-alpine

# ENV LANG="en_US.UTF-8" \
#    LC_ALL="en_US.UTF-8" \
#	LANGUAGE="en_US.UTF-8" \
#	DB_USER="mysql" \
#	DB_PASS="" \
#	TERM="xterm"

# RUN apk --update add mariadb mariadb-client php-pdo_mysql php-mysql php-mysqli #&& \
#	rm -rf /tmp/src && \
#    rm -rf /var/cache/apk/* \

# ADD ./scripts/my.cnf /etc/mysql/my.cnf
# ADD ./scripts/mysql.sh /scripts/pre-init.d/.

EXPOSE 80
# EXPOSE 3306

# VOLUME /app
WORKDIR /app
VOLUME /data

# ENTRYPOINT ["/scripts/run.sh"]


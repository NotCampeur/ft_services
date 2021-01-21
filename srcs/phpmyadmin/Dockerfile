FROM 	alpine:latest

RUN		apk update \
	&& apk add nginx \
				wget \
				php7-fpm \
				php7-common \
				php7-iconv \
				php7-json \
				php7-opcache \
				php7-mbstring \
				php7-zlib \
				php7-session \
				php7-gd \
				php7-curl \
				php7-xml \
				php7-mysqli \
				php7-imap \
				php7-cgi \
				fcgi \
				php7-pdo \
				php7-pdo_mysql \
				php7-soap \
				php7-xmlrpc \
				php7-posix \
				php7-mcrypt \
				php7-gettext \
				php7-ldap \
				php7-ctype \
				php7-dom \
				# mysql \
				# mysql-client \
				php-mysqli \
				mariadb \
				mariadb-client \
				--no-cache --upgrade bash

RUN 	mysql --version

RUN		wget http://files.directadmin.com/services/all/phpMyAdmin/phpMyAdmin-5.0.2-all-languages.tar.gz \
		&& tar -zxvf phpMyAdmin-5.0.2-all-languages.tar.gz \
		&& rm phpMyAdmin-5.0.2-all-languages.tar.gz \
		&& mv phpMyAdmin-5.0.2-all-languages phpmyadmin

RUN		chmod -R 777 /phpmyadmin/

RUN		ln -s /phpmyadmin/ /var/www/localhost/htdocs/phpmyadmin

COPY	nginx.conf		/etc/nginx/
COPY	pma_setup.sh	setup.sh
COPY	mysql_init.sh	init.sh
COPY	config.inc.php	/phpmyadmin/

RUN		chmod +x setup.sh
RUN		chmod +x init.sh

RUN		mkdir /run/nginx

EXPOSE	5000

CMD		["sh", "./setup.sh" ]
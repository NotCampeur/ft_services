FROM 	alpine:latest

RUN		apk update
RUN		apk add nginx
RUN		apk add wget
RUN		apk add php7
RUN		apk add php7-fpm
RUN		apk add php7-common
RUN		apk add php7-iconv
RUN		apk add php7-json
RUN		apk add php7-opcache
RUN		apk add php7-mbstring
RUN		apk add php7-zlib
RUN		apk add php7-session
RUN		apk add php7-gd
RUN		apk add php7-curl
RUN		apk add php7-xml
RUN		apk add php7-mysqli
RUN		apk add php7-imap
RUN		apk add php7-cgi
RUN		apk add php7-pdo
RUN		apk add php7-pdo_mysql
RUN		apk add php7-soap
RUN		apk add php7-xmlrpc
RUN		apk add php7-posix
RUN		apk add php7-mcrypt
RUN		apk add php7-gettext
RUN		apk add php7-ldap
RUN		apk add php7-ctype
RUN		apk add php7-dom
RUN		apk add fcgi

RUN		wget http://files.directadmin.com/services/all/phpMyAdmin/phpMyAdmin-5.0.2-all-languages.tar.gz \
		&& tar -zxvf phpMyAdmin-5.0.2-all-languages.tar.gz \
		&& rm phpMyAdmin-5.0.2-all-languages.tar.gz \
		&& mv phpMyAdmin-5.0.2-all-languages phpmyadmin

COPY	nginx.conf		/etc/nginx/
COPY	pma_setup.sh	setup.sh
COPY	config.inc.php	/phpmyadmin/

RUN		mkdir /run/nginx

EXPOSE	5000

CMD		["sh", "./setup.sh" ]
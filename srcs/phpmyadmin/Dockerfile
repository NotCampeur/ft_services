FROM alpine:latest

RUN apk update \
	&& apk add wget php7 php7-fpm \
		php7-opcache php7-gd php7-mysqli \
		php7-zlib php7-curl php7-mbstring \
		php7-json php7-session

RUN wget http://files.directadmin.com/services/all/phpMyAdmin/phpMyAdmin-5.0.2-all-languages.tar.gz \
	&& tar zxvf phpMyAdmin-5.0.2-all-languages.tar.gz \
	&& rm phpMyAdmin-5.0.2-all-languages.tar.gz \
	&& mkdir /www && mv phpMyAdmin-5.0.2-all-languages /www/phpmyadmin

ADD setup.sh 			.
ADD config.inc.php		/www/phpmyadmin

RUN chmod +x setup.sh

EXPOSE 5000

CMD ["sh", "setup.sh"]
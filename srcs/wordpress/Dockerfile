FROM 	alpine:latest

RUN 	apk update \
		&& apk add nginx \
		&& apk add wget php7 \
		php7-fpm \
		php7-opcache \
		php7-gd \
		php7-mysqli \
		php7-zlib \
		php7-curl \
		php7-mbstring \
		php7-json \
		php7-session

RUN		wget https://wordpress.org/latest.tar.gz \
		&& tar -xvf latest.tar.gz \
		&& rm latest.tar.gz

COPY 	wp-config.php 	/wordpress/wp-config.php
COPY 	nginx.conf		/etc/nginx/

# NEEDED BYE THE COMMAND 'NGINX' IN THE NGINX'S SETUP.SH
RUN		mkdir -p /run/nginx

COPY	wordpress_setup.sh	setup.sh
RUN		chmod +x 			setup.sh

EXPOSE 5050

CMD ["sh", "./setup.sh"]
FROM 	alpine:latest

RUN 	apk update \
	&& apk add nginx \
				wget \
				php7 \
				php7-fpm \
				php7-opcache \
				php7-gd \
				php7-mysqli \
				php7-zlib \
				php7-curl \
				php7-mbstring \
				php7-json \
				php7-session \
				php7-cgi

RUN		wget https://wordpress.org/latest.tar.gz \
		&& tar -xvf latest.tar.gz \
		&& rm latest.tar.gz

COPY 	test.php 			/wordpress/
COPY 	nginx.conf			/etc/nginx/
COPY	wordpress_setup.sh	setup.sh

# NEEDED BYE THE COMMAND 'NGINX' IN THE NGINX'S SETUP.SH
RUN		mkdir /run/nginx

EXPOSE 5050

CMD ["sh", "./setup.sh"]
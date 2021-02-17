FROM 	alpine:latest

RUN 	apk update
RUN		apk add nginx
RUN		apk add wget
RUN		apk add php7
RUN		apk add php7-common
RUN		apk add php7-fpm
RUN		apk add php7-opcache
RUN		apk add php7-gd
RUN		apk add php7-mysqli
RUN		apk add php7-zlib
RUN		apk add php7-curl
RUN		apk add php7-mbstring
RUN		apk add php7-json
RUN		apk add php7-session
RUN		apk add php7-cgi

RUN		apk add telegraf

RUN		wget https://wordpress.org/latest.tar.gz \
		&& tar -xvf latest.tar.gz \
		&& rm latest.tar.gz

RUN		mkdir -p /wordpress/wp-content/uploads/2021/01

RUN		chmod 777 -R /wordpress/

COPY 	wp-config.php		/wordpress/
COPY 	nginx.conf			/etc/nginx/
COPY	wordpress_setup.sh	setup.sh
COPY	qr_code_paypal.png	/wordpress/wp-content/uploads/2021/01
COPY	./telegraf.conf		/etc/telegraf.conf

# NEEDED BYE THE COMMAND 'NGINX' IN THE NGINX'S SETUP.SH
RUN		mkdir /run/nginx

EXPOSE 5050

CMD ["sh", "./setup.sh"]
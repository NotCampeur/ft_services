FROM 	alpine:latest

RUN 	apk update \
		&& apk add nginx \
					openssl

COPY 	nginx.conf		/etc/nginx/
COPY	nginx_setup.sh	setup.sh
RUN		chmod +x 		setup.sh

# NEEDED BY THE COMMAND 'OPENSSL'
RUN		mkdir -p /etc/nginx/certs

# NEEDED BY THE COMMAND 'NGINX' IN THE NGINX'S SETUP.SH
RUN		mkdir -p /run/nginx

COPY	page /page/

RUN openssl req -x509 -nodes \
	-subj '/C=FR/ST=PARIS/L=PARIS/O=42/CN=localhost' \
	-days 1 -newkey rsa:1024 \
	-keyout /etc/ssl/private/nginx-selfsigned.key \
	-out /etc/nginx/certs/nginx-selfsigned.crt

EXPOSE 22 35:80 36:443 

CMD ["sh", "./setup.sh"]
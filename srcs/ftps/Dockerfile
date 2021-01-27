FROM	alpine:latest

RUN 	apk update
RUN		apk add vsftpd
RUN		apk add openssl
RUN		apk add pure-ftpd --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

COPY	ftps_setup.sh	setup.sh

RUN		openssl req -x509 -nodes \
			-subj '/C=FR/ST=PARIS/L=PARIS/O=42/CN=localhost' \
			-days 365 -newkey rsa:2048 \
			-keyout /etc/ssl/private/vsftpd-selfsigned.key \
			-out /etc/ssl/certs/vsftpd-selfsigned.crt

EXPOSE 21 21000-21010

ENTRYPOINT [ "sh", "./setup.sh" ]
FROM	alpine:latest

RUN 	apk update
RUN		apk add openssl
RUN		apk add vsftpd
RUN		apk add pure-ftpd --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache
RUN     apk add telegraf

COPY	ftps_setup.sh	setup.sh
COPY	./telegraf.conf     /etc/telegraf.conf

EXPOSE 21 1200

ENTRYPOINT [ "sh", "./setup.sh" ]

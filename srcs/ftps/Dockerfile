FROM	alpine:latest

RUN 	apk update
RUN		apk add openssl
RUN		apk add pure-ftpd --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

COPY	ftps_setup.sh	setup.sh

EXPOSE 21 1200

ENTRYPOINT [ "sh", "./setup.sh" ]

FROM	alpine:latest

RUN 	apk update \
		&& apk add vsftpd && apk add openssl

COPY	ftps_setup.sh	setup.sh

EXPOSE 21 21000

ENTRYPOINT [ "sh", "./setup.sh" ]
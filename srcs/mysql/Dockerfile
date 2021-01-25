FROM alpine:latest

RUN 	apk update
RUN		apk add mariadb
RUN		apk add mariadb-client

COPY 	mysql_setup.sh		setup.sh
COPY	database_init.sql	init.sql
COPY	wordpress.sql		.

CMD ["sh", "./setup.sh"]
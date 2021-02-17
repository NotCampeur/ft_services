FROM alpine:latest

RUN 	apk update
RUN		apk add mariadb
RUN		apk add mariadb-client
RUN     apk add telegraf

COPY 	mysql_setup.sh		setup.sh
COPY	database_init.sql	init.sql
COPY	wordpress.sql		.
COPY	./telegraf.conf     /etc/telegraf.conf

CMD ["sh", "./setup.sh"]
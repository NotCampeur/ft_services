FROM    alpine:latest

RUN     apk update
RUN     apk add influxdb

RUN		apk add telegraf

COPY    influxdb_setup.sh   setup.sh
COPY	./telegraf.conf     /etc/telegraf.conf

CMD     ["sh", "/setup.sh"]
FROM    alpine:latest

RUN     apk update
RUN     apk add influxdb

RUN		apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

COPY    influxdb_setup.sh   setup.sh
COPY	./telegraf.conf /etc/telegraf/telegraf.conf

CMD     ["sh", "/setup.sh"]
FROM    alpine:latest

RUN     apk update
RUN     apk add influxdb

COPY    influxdb_setup.sh   setup.sh

CMD     ["sh", "/setup.sh"]
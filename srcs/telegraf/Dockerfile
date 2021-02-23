FROM 	alpine:latest

RUN			apk update

RUN			apk add wget

RUN			apk add libc6-compat

RUN			wget https://dl.influxdata.com/telegraf/releases/telegraf-1.14.0-static_linux_amd64.tar.gz
RUN         tar xf telegraf-1.14.0-static_linux_amd64.tar.gz
RUN         rm telegraf-1.14.0-static_linux_amd64.tar.gz

COPY		telegraf.conf       .
COPY		telegraf_setup.sh   setup.sh

CMD         ["sh", "./setup.sh"]
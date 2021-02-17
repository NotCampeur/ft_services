FROM    alpine:latest

RUN     apk update

# The following add is needed to correct this error :
# "/bin/grafana-server: No such file or directory" which is caused by a lib-c mismatch: 
# Grafana is build with ld-linux-armhf.so, but Alpine base image contains only ld-musl-armv7.so.
RUN     apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main libc6-compat

RUN     wget https://dl.grafana.com/oss/release/grafana-7.3.7.linux-amd64.tar.gz \
        && tar -zxvf grafana-7.3.7.linux-amd64.tar.gz \
        && rm grafana-7.3.7.linux-amd64.tar.gz

RUN     apk add telegraf

COPY    grafana_setup.sh        setup.sh
COPY	./telegraf.conf         /etc/telegraf.conf
COPY    ./grafana.db            /grafana-7.3.7/data/grafana.db

EXPOSE  3000

WORKDIR /grafana-7.3.7/

CMD     ["sh", "/setup.sh"]

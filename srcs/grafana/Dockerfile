FROM    alpine:latest

RUN     apk update

RUN     wget https://dl.grafana.com/oss/release/grafana-7.3.7.linux-amd64.tar.gz \
        && tar -zxvf grafana-7.3.7.linux-amd64.tar.gz \
        && rm grafana-7.3.7.linux-amd64.tar.gz

COPY    grafana_setup.sh    setup.sh

EXPOSE  3000

CMD     ["sh", "./setup.sh"]

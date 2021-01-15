FROM alpine:latest

RUN apk update && apk add --no-cache --upgrade bash \
&& apk add mariadb mariadb-client openrc

RUN mysql --version

COPY mysql_setup.sh setup.sh
COPY init.sh .
COPY wordpress.sql .
RUN chmod +x setup.sh
RUN chmod +x init.sh

EXPOSE 3306

CMD ["sh", "init.sh"]
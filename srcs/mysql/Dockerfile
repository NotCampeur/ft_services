FROM alpine:latest

RUN apk update && apk add --no-cache --upgrade bash \
&& apk add mariadb mariadb-client openrc

RUN mysql --version

ADD setup.sh .
ADD init.sh .
ADD wordpress.sql .
RUN chmod +x setup.sh
RUN chmod +x init.sh

EXPOSE 3306

CMD ["sh", "init.sh"]
FROM alpine:latest

RUN apk update

COPY mysql_setup.sh setup.sh

CMD ["sh", "./setup.sh"]
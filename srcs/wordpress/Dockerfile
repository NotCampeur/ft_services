FROM 	alpine:latest

RUN 	apk update

COPY	wordpress_setup.sh	setup.sh
RUN		chmod +x 			setup.sh

EXPOSE 5050

CMD ["sh", "./setup.sh"]
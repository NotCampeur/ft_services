openssl req -x509 -nodes \
	-subj '/C=FR/ST=PARIS/L=PARIS/O=42/CN=localhost' \
	-days 365 -newkey rsa:2048 \
	-keyout /etc/ssl/private/nginx-selfsigned.key \
	-out /etc/nginx/certs/nginx-selfsigned.crt

adduser -D "admin"
echo "admin:password" | chpasswd

nginx

pure-ftpd -j -Y 2 -p 21000:21000 -P 172.17.0.2

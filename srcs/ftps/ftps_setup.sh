# vsftpd default
# vsftpd restart
# vsftpd start
# nc -zv 127.0.0.1 21

# pure-ftpd -B

	# FORCE THE USE OF A TLS SESSION FOR PURE_FTPD
# echo "1" > /etc/pure-ftpd/conf/TLS

mkdir -p /etc/ssl/private/

openssl req -x509 -nodes \
	-subj '/C=FR/ST=PARIS/L=PARIS/O=42/CN=localhost' \
	-days 365 -newkey rsa:2048 \
	-keyout /etc/ssl/private/pure-ftpd.pem \
	-out /etc/ssl/private/pure-ftpd.pem

chmod 600 /etc/ssl/private/pure-ftpd.pem

adduser -D "admin"
echo "admin:password" | chpasswd

# pure-ftpd flags explanation
# 
# -j Create a home directory if needed
# -Y Enable the TLS
# -p Give the port range where ftp can work
# -P The IP address bound to ftp
# 
pure-ftpd -j -Y 1 -p 1200:1200 -P 172.17.0.2
# pure-ftpd restart
# tail -f /dev/null
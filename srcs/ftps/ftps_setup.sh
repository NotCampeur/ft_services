	# FORCE THE USE OF A TLS SESSION FOR PURE_FTPD
mkdir /etc/pure-ftpd
mkdir /etc/pure-ftpd/conf
echo "2" > /etc/pure-ftpd/conf/TLS

mkdir -p /etc/ssl/private/

openssl req -x509 -nodes \
	-subj '/C=FR/ST=PARIS/L=PARIS/O=42/CN=localhost' \
	-days 365 -newkey rsa:2048 \
	-keyout /etc/ssl/private/pure-ftpd.pem \
	-out /etc/ssl/private/pure-ftpd.pem

openssl dhparam -out /etc/ssl/private/pure-ftpd-dhparams.pem 2048

chmod 600 /etc/ssl/private/pure-ftpd.pem

adduser -D "admin"
echo "admin:password" | chpasswd

# pure-ftpd flags explanation
# 
# -j Create a home directory if needed
# -B Launch in background
# -Y Enable the TLS
# -p Give the port range where ftp can work
# -P The IP address bound to ftp
# 
pure-ftpd -j -Y 2 -p 1200:1200 -P 172.17.0.2 &
FTPS_IS_UP=1
while [ $FTPS_IS_UP -eq 1 ]
do
	sleep 5
	ps aux | grep -v "grep" | grep "pure-ftpd"
	if [ $? -ne 0 ]
	then
		FTPS_IS_UP=0
	fi
done
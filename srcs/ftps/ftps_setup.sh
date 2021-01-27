# vsftpd default
# vsftpd restart
# vsftpd start
# nc -zv 127.0.0.1 21
# adduser -D "admin"
# echo "admin:password" | chpasswd

# pure-ftpd -j -Y 2 -p 21000:21000 -P 172.17.0.2
pure-ftpd &
tail -f /dev/null
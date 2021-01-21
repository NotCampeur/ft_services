php-fpm7
nohup ./init.sh > /dev/null 2>&1 &

mkdir -p /run/mysqld/

sed -i 's/skip-networking/#skip-networking/g' /etc/my.cnf.d/mariadb-server.cnf
echo "\"skip-networking\" commented"
/usr/bin/mysql_install_db --user=root --datadir="/var/lib/mysql"
echo "mysql_install_db DONE"
nginx
echo "nginx DONE"
/usr/bin/mysqld --user=root --datadir="/var/lib/mysql"
echo "mysqld DONE"
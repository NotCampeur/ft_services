# mysql

# cat wordpress.sql | mysql wordpress -u root --skip-password

mkdir -p /run/mysqld/

sed -i 's/skip-networking/#skip-networking/g' /etc/my.cnf.d/mariadb-server.cnf
/usr/bin/mysql_install_db --user=root --datadir="/var/lib/mysql"
/usr/bin/mysqld --user=root --datadir="/var/lib/mysql" --init-file="/init.sql"
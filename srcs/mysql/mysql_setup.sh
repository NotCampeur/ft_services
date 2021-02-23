mkdir -p /run/mysqld/
sed -i 's/skip-networking/#skip-networking/g' /etc/my.cnf.d/mariadb-server.cnf
/usr/bin/mysql_install_db --user=root --datadir="/var/lib/mysql"
/usr/bin/mysqld --user=root --datadir="/var/lib/mysql" --init-file="/init.sql" &

MYSQL_IS_UP=0
# Needed since the mysql daemon have some trouble to start and will take few seconds
while [ $MYSQL_IS_UP -eq 0 ]
do
	sleep 5
	ps aux | grep -v "grep" | grep "/usr/bin/mysqld"
	if [ $? -eq 0 ]
	then
		MYSQL_IS_UP=1
		mysql --user=root wordpress < wordpress.sql
	fi
done

pkill mysqld

/usr/bin/mysqld --user=root --datadir="/var/lib/mysql"

MYSQLD_IS_UP=1
while [ $MYSQLD_IS_UP -eq 1 ]
do
	sleep 5
	ps aux | grep -v "grep" | grep "/usr/bin/mysqld"
	if [ $? -ne 0 ]
	then
		MYSQLD_IS_UP=0
	fi
done
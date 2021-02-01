use mysql;

CREATE DATABASE IF NOT EXISTS wordpress;
ALTER USER 'root'@'localhost'
	IDENTIFIED by 'password';
CREATE USER 'admin'
	IDENTIFIED BY 'password';

DROP DATABASE test;

GRANT ALL PRIVILEGES ON wordpress.* TO 'admin' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;

FLUSH PRIVILEGES;
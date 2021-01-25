use mysql;

CREATE DATABASE IF NOT EXISTS wordpress;

CREATE USER 'admin'
	IDENTIFIED BY 'password';

DROP DATABASE test;

GRANT ALL PRIVILEGES ON wordpress.* TO 'admin' WITH GRANT OPTION;

FLUSH PRIVILEGES;

wordpress -u root < wordpress.sql
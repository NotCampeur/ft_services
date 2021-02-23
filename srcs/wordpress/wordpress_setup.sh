php-fpm7
nginx

NGINX_AND_PHP_ARE_UP=1
while [ $NGINX_AND_PHP_ARE_UP -eq 1 ]
do
	sleep 5
	ps aux | grep -v "grep" | grep "nginx"
	if [ $? -ne 0 ]
	then
		NGINX_AND_PHP_ARE_UP=0
	fi
    ps aux | grep -v "grep" | grep "php-fpm7"
	if [ $? -ne 0 ]
	then
		NGINX_AND_PHP_ARE_UP=0
	fi
done
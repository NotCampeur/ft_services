nginx

NGINX_IS_UP=1
while [ $NGINX_IS_UP -eq 1 ]
do
	sleep 5
	ps aux | grep -v "grep" | grep "nginx"
	if [ $? -ne 0 ]
	then
		NGINX_IS_UP=0
	fi
done
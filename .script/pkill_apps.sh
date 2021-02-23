#! /bin/bash

RED="\e[1;31m"
GREEN="\e[1;32m"
YELLOW="\e[1;33m"
BLUE="\e[1;34m"
PURPLE="\e[35m"
DEFAULT="\e[0m"

services=('telegraf' 'nginx' 'wordpress' 'phpmyadmin' 'mysql' 'ftps' 'influxdb' 'grafana')
apps=('telegraf' 'nginx' 'php-fpm7' 'php-fpm7' 'mysqld' 'pure-ftpd' 'influxd' 'grafana-server')

index=0

echo -e ${BLUE}"[ LET THE MASSACRE BEGIN ]"${DEFAULT}

while [ $index -ne 8 ]
do
	echo -en ${YELLOW}"\tKilling ${apps[$index]} in ${services[$index]} ..."${DEFAULT}
    
    kubectl exec deploy/${services[$index]} -- pkill ${apps[$index]}

    if [ $? -eq 0 ]
    then
        echo -e ${GREEN}"DONE"${DEFAULT}
    else
        echo -e ${RED}"ERROR"${DEFAULT}
    fi

    let "index = index + 1"

done

echo -e ${PURPLE}"[ What a bloody night ]"${DEFAULT}

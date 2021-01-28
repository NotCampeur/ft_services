#! /bin/bash

GREEN="\e[1;32m"
YELLOW="\e[1;33m"
BLUE="\e[1;34m"
PURPLE="\e[35m"
DEFAULT="\e[0m"

if [[ $(minikube status | grep -c "Running") != 3 ]]
then
	echo -en ${YELLOW}"\tInstalling minikube ..."${DEFAULT}
	minikube start --driver=docker
	echo -e ${GREEN}"DONE"${DEFAULT}
fi

echo -e ${YELLOW}"\tCleaning minikube container..."${DEFAULT}
echo -e ${BLUE}"kubectl delete pods --all -"${DEFAULT}
kubectl delete pods --all
echo -e ${BLUE}"kubectl delete deployments --all -"${DEFAULT}
kubectl delete deployments --all
echo -e ${BLUE}"kubectl delete svc --all -"${DEFAULT}
kubectl delete svc --all
echo -e ${BLUE}"kubectl delete pvc --all -"${DEFAULT}
kubectl delete pvc --all
echo -e ${BLUE}"docker system prune -"${DEFAULT}
echo 'y' | docker system prune --all
echo -e ${GREEN}"DONE"${DEFAULT}

echo -en ${YELLOW}"\tStopping minikube ..."${DEFAULT}
minikube stop
echo -e ${GREEN}"DONE"${DEFAULT}
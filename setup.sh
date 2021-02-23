#! /bin/bash

RED="\e[1;31m"
GREEN="\e[1;32m"
YELLOW="\e[1;33m"
BLUE="\e[1;34m"
PURPLE="\e[35m"
DEFAULT="\e[0m"

DONE_RETURN=${GREEN}"DONE"${DEFAULT}
ERROR_RETURN=${RED}"ERROR... check logs for more infos"${DEFAULT}

NEXT_RETURN=0

SHUTDOWN=0

services="nginx wordpress phpmyadmin mysql ftps influxdb grafana"

ft_check_user_group()
{
	if [ $(grep "docker" /etc/group | grep -c "$USER") -eq 0 ]
	then
		echo -e ${YELLOW}"\tUbuntu will restart due to user group modification..."${DEFAULT}
		echo "user42" | sudo -S usermod -aG docker $USER > /dev/null
		SHUTDOWN=6
		while [ $SHUTDOWN -ne 1 ]
		do
			SHUTDOWN='expr $SHUTDOWN - 1'
			echo $SHUTDOWN
			sleep 1
		done
	else
		echo -e ${YELLOW}"\tThe docker group have the rights needed to properly work"${DEFAULT}
	fi
}

ft_install_lftp()
{
	systemctl status lftp > .log/lftp.log 2>&1 && date >> .log/lftp.log 2>&1
	if [ $? -ne 0 ]
	then
		echo -e ${YELLOW}"\tInstalling and configuring lftp..."${DEFAULT}
		echo "user42" | sudo -S apt install lftp >> .log/lftp.log 2>&1 ; date >> .log/lftp.log 2>&1
				if [ $? -ne 0 ]
		then
			NEXT_RETURN=${ERROR_RETURN}
		fi
		echo "user42" | sudo -S chmod 777 /etc/lftp.conf
				if [ $? -ne 0 ]
		then
			NEXT_RETURN=${ERROR_RETURN}
		fi
		echo "set ssl:verify-certificate no" >> /etc/lftp.conf
				if [ $? -ne 0 ]
		then
			NEXT_RETURN=${ERROR_RETURN}
		fi
		echo -e ${NEXT_RETURN}
	else
		echo -e ${YELLOW}"\tlftp seems to be already installed"${DEFAULT}
	fi
}

ft_start_minikube()
{
	if [[ $(minikube status > .log/setup.log 2>&1 ; grep -c "Running" ".log/setup.log") -ne 3 ]]
	then
		echo -en ${YELLOW}"\tInstalling minikube and Load Balancer..."${DEFAULT}
		minikube start --driver=docker >> .log/setup.log 2>&1 ; date >> .log/setup.log 2>&1
		if [ $? -eq 0 ]
		then
			echo -e ${DONE_RETURN}
		else
			echo -e ${ERROR_RETURN}
		fi
		echo -en ${YELLOW}"\tApplying metallb ..."${DEFAULT}
		NEXT_RETURN=${DONE_RETURN}
		kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml >> .log/setup.log 2>&1 ; date >> .log/setup.log 2>&1
		if [ $? -ne 0 ]
		then
			NEXT_RETURN=${ERROR_RETURN}
		fi
		kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml >> .log/setup.log 2>&1 ; date >> .log/setup.log 2>&1
		if [ $? -ne 0 ]
		then
			NEXT_RETURN=${ERROR_RETURN}
		fi
		kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)" >> .log/setup.log 2>&1 ; date >> .log/setup.log 2>&1
		if [ $? -ne 0 ]
		then
			NEXT_RETURN=${ERROR_RETURN}
		fi
		echo -n "kubectl apply -f srcs/load_balancer/metallb-deployment.yaml -" >> .log/setup.log 2>&1
		date >> .log/setup.log 2>&1
		kubectl apply -f srcs/load_balancer/metallb-deployment.yaml >> .log/setup.log 2>&1
		if [ $? -ne 0 ]
		then
			NEXT_RETURN=${ERROR_RETURN}
		fi
		echo -e ${NEXT_RETURN}
	fi

	echo -en ${YELLOW}"\tCleaning the previous minikube container..."${DEFAULT}
	NEXT_RETURN=${DONE_RETURN}
	echo -n "kubectl delete pods --all -" >> .log/setup.log 2>&1 ; date >> .log/setup.log 2>&1
	kubectl delete pods --all >> .log/setup.log 2>&1
	if [ $? -ne 0 ]
	then
		NEXT_RETURN=${ERROR_RETURN}
	fi
	echo -n "kubectl delete deployments --all -" >> .log/setup.log 2>&1 ; date >> .log/setup.log 2>&1
	kubectl delete deployments --all >> .log/setup.log 2>&1
	if [ $? -ne 0 ]
	then
		NEXT_RETURN=${ERROR_RETURN}
	fi
	echo -n "kubectl delete svc --all -" >> .log/setup.log 2>&1 ; date >> .log/setup.log 2>&1
	kubectl delete svc --all >> .log/setup.log 2>&1
	if [ $? -ne 0 ]
	then
		NEXT_RETURN=${ERROR_RETURN}
	fi
	echo -n "kubectl delete pvc --all -" >> .log/setup.log 2>&1 ; date >> .log/setup.log 2>&1
	kubectl delete pvc --all >> .log/setup.log 2>&1
	if [ $? -ne 0 ]
	then
		NEXT_RETURN=${ERROR_RETURN}
	fi
	echo -e ${NEXT_RETURN}

	eval $(minikube -p minikube docker-env)
}

ft_build_image()
{
	for service in $services
	do
		echo -en ${YELLOW}"\tBuilding $service..."${DEFAULT}
		echo -n "docker build srcs/$service -t $service -" > .log/$service.log
		date >> .log/$service.log
		docker build srcs/$service -t $service >> .log/$service.log
		if [ $? -eq 0 ]
		then
			echo -e ${DONE_RETURN}
		else
			echo -e ${ERROR_RETURN}
		fi
	done
}

ft_run_container()
{
	for service in $services
	do
		echo -en ${YELLOW}"\tApplying $service-deployment.yaml..."${DEFAULT}
		echo -n "kubectl apply -f srcs/$service/$service-deployment.yaml -" >> .log/setup.log 2>&1
		date >> .log/setup.log 2>&1
		kubectl apply -f srcs/$service/$service-deployment.yaml >> .log/setup.log 2>&1
		if [ $? -eq 0 ]
		then
			echo -e ${DONE_RETURN}
		else
			echo -e ${ERROR_RETURN}
		fi
	done
}




echo -e ${BLUE}"[ Check the docker user group ]"${DEFAULT}
ft_check_user_group

if [ $SHUTDOWN -eq 0 ]
then
{
	echo -e ${BLUE}"[ LFTP ]"${DEFAULT}
	ft_install_lftp

	echo -e ${BLUE}"[ Minikube | Metallb ]"${DEFAULT}
	ft_start_minikube

	echo -e ${BLUE}"[ Docker images building ]"${DEFAULT}
	ft_build_image

	echo -e ${BLUE}"[ YAML Kubernetes applying ]"${DEFAULT}
	ft_run_container

	echo -e ${BLUE}"[ Finished ]"

	echo -e ${PURPLE}"\n[ DEBUG INFO IN 30 seconds: ]"

	sleep 30

	echo -e ${BLUE}"[ CLUSTER-INFO ]"${DEFAULT}
	kubectl cluster-info
	echo -e ${BLUE}"[ GET NODES ]"${DEFAULT}
	kubectl get nodes
	echo -e ${BLUE}"[ GET PODS ]"${DEFAULT}
	kubectl get pods
	echo -e ${BLUE}"[ GET DEPLOYMENTS ]"${DEFAULT}
	kubectl get deployments
	echo -e ${BLUE}"[ GET SVC ]"${DEFAULT}
	kubectl get svc
	echo -e ${BLUE}"[ STARTING DASHBOARD ]"${DEFAULT}
	minikube dashboard
}
else
	echo "user42" | sudo -S shutdown -r now > /dev/null
fi

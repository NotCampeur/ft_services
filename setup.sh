#! /bin/bash

GREEN="\e[1;32m"
YELLOW="\e[1;33m"
PURPLE="\e[35m"
DEFAULT="\e[0m"

services="nginx wordpress"
# services="wordpress"

ft_build_image()
{
	for service in $services
	do
		echo -en ${YELLOW}"\tBuilding $service..."${DEFAULT}
		echo -n "docker build srcs/$service -t $service -" > .log/$service.log
		date >> .log/$service.log
		docker build srcs/$service -t $service >> .log/$service.log
		echo -e ${GREEN}"DONE"${DEFAULT}
	done
}

ft_run_container()
{
	echo -en ${YELLOW}"\tApplying metallb-deployment.yaml..."${DEFAULT}
	echo -n "kubectl apply -f srcs/load_balancer/metallb-deployment.yaml -" >> .log/setup.log
	date >> .log/setup.log
	kubectl apply -f srcs/load_balancer/metallb-deployment.yaml >> .log/setup.log
	echo -e ${GREEN}"DONE"${DEFAULT}
	for service in $services
	do
		echo -en ${YELLOW}"\tApplying $service-deployment.yaml..."${DEFAULT}
		echo -n "kubectl apply -f srcs/$service/$service-deployment.yaml -" >> .log/setup.log
		date >> .log/setup.log
		kubectl apply -f srcs/$service/$service-deployment.yaml >> .log/setup.log
		echo -e ${GREEN}"DONE"${DEFAULT}
	done
}

ft_start_minikube()
{
	if [[ $(minikube status | grep -c "Running") == 0 ]]
	then
		echo -e ${YELLOW}"\tInstalling minikube and metallb..."${DEFAULT}
		echo -e ${PURPLE}; minikube start --driver=docker --extra-config=apiserver.service-node-port-range=1-35000
		minikube addons enable metrics-server
		minikube addons enable dashboard
		kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
		kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
		kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)" > /dev/null
	else
		echo -en ${YELLOW}"\tCleaning the previous minikube container..."${DEFAULT}
		echo -n "kubectl delete pods --all -" > .log/setup.log ; date >> .log/setup.log
		kubectl delete pods --all >> .log/setup.log
		echo -n "kubectl delete deployments --all -" >> .log/setup.log ; date >> .log/setup.log
		kubectl delete deployments --all >> .log/setup.log
		echo -n "kubectl delete svc --all -" >> .log/setup.log ; date >> .log/setup.log
		kubectl delete svc --all >> .log/setup.log
		echo -n "kubectl delete pvc --all -" >> .log/setup.log ; date >> .log/setup.log
		kubectl delete pvc --all >> .log/setup.log
		echo -e ${GREEN}"DONE"${DEFAULT}
	fi
	eval $(minikube docker-env)
}

yes | docker system prune > /dev/null

echo -e ${PURPLE}"[ Minikube | Metallb ]"${DEFAULT}
ft_start_minikube

echo -e ${PURPLE}"[ Docker images building ]"${DEFAULT}
ft_build_image

echo -e ${PURPLE}"[ YAML Kubernetes applying ]"${DEFAULT}
ft_run_container

echo -e ${PURPLE}"[ Finished ]"
# minikube dashboard
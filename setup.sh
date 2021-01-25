#! /bin/bash

GREEN="\e[1;32m"
YELLOW="\e[1;33m"
BLUE="\e[1;34m"
PURPLE="\e[35m"
DEFAULT="\e[0m"

services="nginx wordpress phpmyadmin mysql"

ft_start_minikube()
{
	if [[ $(minikube status > .log/setup.log ; cat .log/setup.log | grep -c "Running") == 0 ]]
	then
		echo -en ${YELLOW}"\tInstalling minikube ..."${DEFAULT}
		minikube start --driver=docker --cpus=2 --memory=2200 --extra-config=apiserver.service-node-port-range=1-35000 >> .log/setup.log ; date >> .log/setup.log
		echo -e ${GREEN}"DONE"${DEFAULT}
		# echo -en ${YELLOW}"\tEnabling addons ..."${DEFAULT}
		# minikube addons enable metrics-server >> .log/setup.log ; date >> .log/setup.log
		# minikube addons enable dashboard >> .log/setup.log ; date >> .log/setup.log
		# echo -e ${GREEN}"DONE"${DEFAULT}
		echo -en ${YELLOW}"\tApplying metallb ..."${DEFAULT}
		kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml >> .log/setup.log ; date >> .log/setup.log
		kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml >> .log/setup.log ; date >> .log/setup.log
		kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)" > /dev/null
		echo -e ${GREEN}"DONE"${DEFAULT}
	else
		echo -en ${YELLOW}"\tCleaning the previous minikube container..."${DEFAULT}
		echo -n "kubectl delete pods --all -" >> .log/setup.log ; date >> .log/setup.log
		kubectl delete pods --all >> .log/setup.log
		echo -n "kubectl delete deployments --all -" >> .log/setup.log ; date >> .log/setup.log
		kubectl delete deployments --all >> .log/setup.log
		echo -n "kubectl delete svc --all -" >> .log/setup.log ; date >> .log/setup.log
		kubectl delete svc --all >> .log/setup.log
		echo -n "kubectl delete pvc --all -" >> .log/setup.log ; date >> .log/setup.log
		kubectl delete pvc --all >> .log/setup.log
		echo -e ${GREEN}"DONE"${DEFAULT}
	fi
	eval $(minikube -p minikube docker-env)
	echo -en ${YELLOW}"\tApplying metallb-deployment.yaml..."${DEFAULT}
	echo -n "kubectl apply -f srcs/load_balancer/metallb-deployment.yaml -" >> .log/setup.log
	date >> .log/setup.log
	kubectl apply -f srcs/load_balancer/metallb-deployment.yaml >> .log/setup.log
	echo -e ${GREEN}"DONE"${DEFAULT}
}

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
	for service in $services
	do
		echo -en ${YELLOW}"\tApplying $service-deployment.yaml..."${DEFAULT}
		echo -n "kubectl apply -f srcs/$service/$service-deployment.yaml -" >> .log/setup.log
		date >> .log/setup.log
		kubectl apply -f srcs/$service/$service-deployment.yaml >> .log/setup.log
		echo -e ${GREEN}"DONE"${DEFAULT}
	done
}

yes | docker system prune > /dev/null

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
echo -e ${BLUE}"[ GET DEPLOYMENTS ]"${DEFAULT}
kubectl get deployments
echo -e ${BLUE}"[ GET SVC ]"${DEFAULT}
kubectl get svc
echo -e ${BLUE}"[ STARTING DASHBOARD ]"${DEFAULT}
minikube dashboard

#! /bin/bash

services="nginx wordpress"
# services="wordpress"

ft_build_image()
{
	for service in $services
	do
		docker build srcs/$service -t $service > .log/$service.log
	done
}

ft_run_container()
{
	for service in $services
	do
		kubectl apply -f srcs/$service/$service-deployment.yaml
		# kubectl create deployment srcs/$service/$service-deployment.yaml srcs/$service
		# docker run -t $service >> .log/$service.log
	done
}

ft_start_minikube()
{
	if [[ $(minikube status | grep -c "Running") == 0 ]]
	then
		minikube start --driver=docker --extra-config=apiserver.service-node-port-range=1-35000
		minikube addons enable metrics-server
		minikube addons enable dashboard
		kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
		kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
		kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)" > /dev/null
	else
		kubectl delete pods --all
		kubectl delete deployments --all
		kubectl delete svc --all
		kubectl delete pvc --all
	fi
	eval $(minikube docker-env)
}

# minikube start --driver=docker --cpus=2 --memory=2200 --extra-config=apiserver.service-node-port-range=1-35000

yes | docker system prune > /dev/null
ft_start_minikube
ft_build_image
kubectl apply -f srcs/load_balancer/metallb-deployment.yaml
ft_run_container

# minikube dashboard
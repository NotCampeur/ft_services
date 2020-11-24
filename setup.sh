#! /bin/sh

services="nginx"

ft_build_image()
{
	for service in $services
	do
		docker build srcs/$service -t image_$service > .log/log_$service.log
	done
}

ft_run_container()
{
	for service in $services
	do
		docker run -t image_$service >> .log/log_$service.log
	done
}

ft_build_image
ft_run_container
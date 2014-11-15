#!/bin/sh

# Takes 1 argument, the IP of the etcd instance

echo "Build Docker image for Georiot Service"
cd /opt/GeoRiot.Service.ConsoleHost/
docker build -t local/georiot_service .

echo "Start up 3 Georiot Service Docker containers..."
docker run -d -p 8080 -v /var/run/docker.sock:/var/run/docker.sock -e IP=$1 --link etcd:etcd local/georiot_service
docker run -d -p 8080 -v /var/run/docker.sock:/var/run/docker.sock -e IP=$1 --link etcd:etcd local/georiot_service
docker run -d -p 8080 -v /var/run/docker.sock:/var/run/docker.sock -e IP=$1 --link etcd:etcd local/georiot_service

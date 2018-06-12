#!/bin/bash

echo "LOGIN....."

cd ../../

cat './Deployment/Build&Release/app/pass.txt' |docker login --password-stdin -u eco-vadis  https://rancher-eco.westeurope.cloudapp.azure.com:8081

sudo docker-compose -f platform-docker-compose.yml build --pull

sudo docker-compose -f platform-docker-compose.yml push 


cd "./Deployment/Build&Release"

sudo docker build . -t eco-platform-release

##### PLEASE GENERATE ACCESS TOKEN via Rancher and put here to have acces rigth to rancher.
sudo docker run -e RANCHER_URL="https://rancher-eco.westeurope.cloudapp.azure.com:8080/" \
                -e RANCHER_ACCESS_KEY="" \
                -e RANCHER_SECRET_KEY="" \
                -e RANCHER_ENVIRONMENT=dev --rm eco-platform-release
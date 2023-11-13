#!/bin/bash

sudo apt update
sudo apt upgrade

sudo apt install -y nginx
echo "<h1>Hello KaotiK</h1>" > /var/www/html/index.html
sudo systemctl start nginx

#Installing Docker
sudo apt-get remove docker docker-engine docker.io
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"
sudo apt-get update
sudo apt-get install docker-ce -y
sudo usermod -a -G docker $USER
sudo systemctl enable docker
sudo systemctl restart docker
sudo docker run --name docker-nginx -p 80:80 nginx:latest

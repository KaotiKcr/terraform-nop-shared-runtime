#!/bin/bash

sudo apt update
sudo apt upgrade

# Bootstraping hard drives

sudo apt install xfsprogs -y
sudo mkfs -t xfs /dev/nvme1n1
sudo mkdir /data
sudo mount /dev/nvme1n1 /data
BLK_ID=$(sudo blkid /dev/nvme1n1 | cut -f2 -d" ")
if [[ -z $BLK_ID ]]; then
    echo "Hmm ... no block ID found ... "
    exit 1
fi
echo "$BLK_ID     /data   xfs    defaults   0   2" | sudo tee --append /etc/fstab
sudo mount -a

# Installing Nginx

sudo apt install -y nginx
echo "<h1>Hello KaotiK</h1>" > /var/www/html/index.html
sudo systemctl start nginx


#Installing Docker

# sudo apt-get remove docker docker-engine docker.io
# sudo apt-get install -y \
#     apt-transport-https \
#     ca-certificates \
#     curl \
#     software-properties-common
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# sudo apt-key fingerprint 0EBFCD88
# sudo add-apt-repository \
#     "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
#     $(lsb_release -cs) \
#     stable"
# sudo apt-get update
# sudo apt-get install docker-ce -y
# sudo usermod -a -G docker $USER
# sudo systemctl enable docker
# sudo systemctl restart docker
# sudo docker run --name docker-nginx -p 80:80 nginx:latest

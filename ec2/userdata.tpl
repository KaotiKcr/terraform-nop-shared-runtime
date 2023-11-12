#!/bin/bash
sudo apt update -y &&
sudo apt install -y nginx
echo "Hello KaotiK" > /var/www/html/index.html

#!/bin/bash
sudo apt update -y &&
sudo apt install -y nginx
echo "<h1>Hello KaotiK</h1>" > /var/www/html/index.html

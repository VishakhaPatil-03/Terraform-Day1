#!/bin/bash
sudo apt update -y
apt install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx

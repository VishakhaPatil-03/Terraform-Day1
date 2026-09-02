#!/bin/bash
sudo apt update
sudo apt install nginx -y 
sudo apt start nginx
sudo systemctl enable nginx

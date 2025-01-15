#!/bin/bash

# Wait until cloud-init finishes
until [ -f /var/lib/cloud/instance/boot-finished ]; do
    sleep 1
done

# Update package lists and install nginx
sudo apt-get update -q
sudo apt-get install -y nginx

# Start nginx service
sudo systemctl start nginx

#!/bin/bash
yum update -y

yum install httpd -y
systemctl enable httpd --now
echo "${WELCOME_MSG}" > /var/www/html/index.html

#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd.service
systemctl enable httpd.service
yum install git -y
git clone https://github.com/MrVivekSharma/KPMG-App.git /var/www/html/
rm -rf /var/www/html/*.md
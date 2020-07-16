#!/bin/bash
yum install httpd -y
echo "<h1>Deployment by Terraform </h1>" >/var/www/html/index.html
systemctl enable httpd
service httpd start
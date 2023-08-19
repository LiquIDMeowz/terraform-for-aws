#!/bin/bash
sudo su
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo '<center><h1>This Amazon EC2 instance was created by Terraform thanks to Vladimir Krastev.</h1></center>' > /var/www/html/index.html
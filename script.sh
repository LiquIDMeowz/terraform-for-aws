#!/bin/bash
sudo su
yum update -y
# Install packages
yum install -y httpd
yum install -y amazon-efs-utils
# Start & Enable web-server
systemctl start httpd
systemctl enable httpd
# Echo content to index.html
echo '<iframe width="560" height="315" src="https://www.youtube.com/embed/dQw4w9WgXcQ?autoplay=1&mute=1" title="YouTube video player" frameborder="0" allow="autoplay" allowfullscreen></iframe>' > /var/www/html/index.html
# Mount FS
mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${aws_efs_file_system.file_system_1.file_system_dns_name}:/ /var/www/html
mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${aws_efs_file_system.file_system_1.id}:/ /var/www/html
mount -t efs ${aws_efs_file_system.file_system_1.id}:/ /var/www/html
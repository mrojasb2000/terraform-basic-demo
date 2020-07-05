#!/bin/bash
export PATH=$PATH:/usr/local/bin
sudo -i
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
yum update -y 
yum install -y httpd
echo "<html><h1>Hola, Excelente Ejercicio....</h1></html>" > /var/www/html/index.html
service httpd start
chkconfig httpd on
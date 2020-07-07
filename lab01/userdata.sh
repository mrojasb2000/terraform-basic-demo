#!/bin/bash
export PATH=$PATH:/usr/local/bin
sudo -i
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
yum update -y 

yum install -y docker
service docker start
usermod -a -G docker ec2-user

curl -L https://github.com/docker/compose/releases/download/1.20.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

groupadd docker
usermod -aG docker ${USER}

chown "$USER":"$USER" /home/"$USER"/.docker -R
chmod g+rwx "$HOME/.docker" -R
chmod 666 /var/run/docker.sock

mkdir -p /home/ec2-user/limoneno
mkdir -p /home/ec2-user/limoneno/.docker
chown -R ec2-user:ec2-user /home/ec2-user/limoneno

cd /home/ec2-user/limoneno

tee -a docker-compose.yml <<EOF
version: '3.0'
services:
  mysql:
    image: mysql-limoneno
    build:
      context: ./.docker
      dockerfile: mysql.Dockerfile
    container_name: limoneno-database-develop
    volumes:
      - limoneno-database-develop:/var/lib/mysql
    environment:
      MYSQL_ROOT_PASSWORD: lemontech
    ports:
      - 3307:3306
    networks:
      webapp:
        ipv4_address: 26.0.0.2
  phpmyadmin:
    image: phpmyadmin/phpmyadmin
    container_name: limoneno-phpmyadmin-develop
    environment:
      PMA_HOST: mysql
    links:
      - "mysql:mysql"
    ports:
      - 7000:80
    networks:
      webapp:
        ipv4_address: 26.0.0.3
  redis:
    image: redis
    ports:
      - "16379:6379"
    networks:
      webapp:
        ipv4_address: 26.0.0.4
volumes:
  limoneno-database-develop:
networks:
  webapp:
    driver: bridge
    ipam:
      config:
        - subnet: 26.0.0.0/24
EOF

cd /home/ec2-user/limoneno/.docker

tee -a my.cnf <<EOF
[mysqld]
pid-file        = /var/run/mysqld/mysqld.pid
socket          = /var/run/mysqld/mysqld.sock
datadir         = /var/lib/mysql
secure-file-priv= NULL
# Disabling symbolic-links is recommended to prevent assorted security risks
symbolic-links=0

# Custom config should go here
!includedir /etc/mysql/conf.d/

#Login method
default-authentication-plugin=mysql_native_password
EOF

tee -a mysql.Dockerfile <<EOF
FROM mysql:5.7
COPY ./my.cnf /etc/mysql/my.cnf
EOF

cd /home/ec2-user/limoneno
docker-compose up -d

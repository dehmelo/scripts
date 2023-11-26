#!/bin/bash

echo "Updating system repositories"
sleep 3
apt-get update
echo " "

echo "Installing Nginx package"
echo "Wait..."
sleep 3
apt-get install -y nginx
systemctl start nginx
echo "The service has been installed and started"
echo " "

echo "Installing Docker package"
echo "Wait..."
sleep 3
apt-get install -y docker.io
echo " "

echo "Installing Curl package"
echo "Wait..."
sleep 3
apt-get install -y curl
echo " "


echo "Installing Docker-Compose package"
echo "Wait..."
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose

ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
echo " "

echo "Insert data into Nginx configuration files."
sleep 3

declare -a arr=([1]="blog.devops.com.br" "app.devops.com.br")

sites_host="192.168.57.110"

cat <<EOF> ./docker-compose.yml
version: '3.1'
services:
EOF

for i in "${!arr[@]}"
do
   echo "$i"
   echo "${arr[i]}"
cat <<EOF> /etc/nginx/sites-available/${arr[i]}.conf
server {
	listen 80;
        server_name ${arr[i]};
        location / {
        proxy_pass http://${sites_host}:8$i;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        }
}
EOF

ln -s /etc/nginx/sites-available/${arr[i]}.conf /etc/nginx/sites-enabled

cat <<EOF>> ./docker-compose.yml
  wordpress$i:
    image: wordpress
    container_name: app$i
    restart: always
    ports:
      - 8$i:80
    environment:
      WORDPRESS_DB_HOST: db$i
      WORDPRESS_DB_USER: exampleuser
      WORDPRESS_DB_PASSWORD: examplepass
      WORDPRESS_DB_NAME: exampledb
    volumes:
      - ./wordpress$i:/var/www/html
  db$i:
    image: mysql:5.7
    container_name: db$i
    restart: always
    environment:
      MYSQL_DATABASE: exampledb
      MYSQL_USER: exampleuser
      MYSQL_PASSWORD: examplepass
      MYSQL_RANDOM_ROOT_PASSWORD: '1'
    volumes:
      - ./db$i:/var/lib/mysql
EOF

done

nginx -t && systemctl reload nginx
  echo "Verified configuration file."
  echo "Service restarted to apply changes."
echo " "

echo "Uploading Apps container"
docker-compose up -d
echo " "

echo "These are the containers available for access: "
docker-compose ps
echo " "

echo "Check the desired APP domain through the browser!"


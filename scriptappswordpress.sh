#!/bin/bash

echo "Atualizando os repositorios do sistema"
sleep 3
apt-get update
echo " "

echo "Instalando pacote do Nginx"
echo "Aguarde..."
sleep 3
apt-get install -y nginx
systemctl start nginx
echo "O serviço foi instalado e iniciado "
echo " "

echo "Instalando pacote do Docker"
echo "Aguarde..."
sleep 3
apt-get install -y docker.io
echo " "

echo "Instalando pacote do Curl"
echo "Aguarde..."
sleep 3
apt-get install -y curl
echo " "


echo "Instalando pacote do Docker-Compose"
echo "Aguarde..."
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose

ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
echo " "

echo "Realizando insercao de dados nos arquivos de configuracao do Nginx."
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
  echo "Arquivo de configuracao verificado."
  echo "Servico reinicializado para a aplicacao das alteracoes."
echo " "

echo "Subindo container dos Apps"
docker-compose up -d
echo " "

echo "Estes sao os containers disponiveis para acesso: "
docker-compose ps
echo " "

echo "Verifique o dominio do APP desejado atraves do navegador!"


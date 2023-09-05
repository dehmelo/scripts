#!/bin/bash

read -p "Digite o nome do usuário: " username
read -sp "Digite a senha do usuário: " password
echo

password_hash=$(openssl passwd -1 "$password")

sudo useradd -m -p "$password_hash" -d /home/"$username" -s /bin/bash "$username"

if [ $? -eq 0 ]; then
    echo "Usuário $username criado com sucesso!"
else
    echo "Houve um erro ao criar o usuário."
fi


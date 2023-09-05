#!/bin/bash

read -p "Enter username: " username
read -sp "Enter user password: " password
echo

password_hash=$(openssl passwd -1 "$password")

sudo useradd -m -p "$password_hash" -d /home/"$username" -s /bin/bash "$username"

if [ $? -eq 0 ]; then
    echo "User $username successfully created!"
else
    echo "There was an error creating the user."
fi


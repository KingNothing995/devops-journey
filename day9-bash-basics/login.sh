#!/bin/bash
# This is a script that will ask for a user and password and will check if they are correct

echo "Enter username:"
read username

echo "Enter password:"
read -s password

if [ "$username" = "admin" ] && [ "$password" = "devops" ]; then
    echo -e "\nLogin successful!"
else
    echo -e "\nLogin failed!"
fi 